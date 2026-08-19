[CmdletBinding()]
param(
    [switch]$SkipExternalLinks,
    [switch]$SkipRemoteValidation
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$registryPath = Join-Path $repoRoot 'sources/registry.json'
$requiredReadmes = @(
    'README.md',
    'official/README.md',
    'official/prestashop-skills/README.md',
    'official/prestashop-mcp-server/README.md',
    'official/ai-context/README.md',
    'community/README.md',
    'community/prestashop-skills/README.md',
    'planned/README.md',
    'planned/development/README.md',
    'planned/operations/README.md',
    'sources/README.md',
    'audit/README.md',
    'audit/2026-08-19-initial-audit.md'
)

$failures = [System.Collections.Generic.List[string]]::new()
$externalLinks = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message)
}

function Get-SourceValue {
    param(
        [object]$Source,
        [string]$Name
    )

    $property = $Source.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $null
    }

    return $property.Value
}

function Get-GitHubJson {
    param([string]$Path)

    $output = & gh api $Path 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "GitHub API failed for '$Path': $output"
    }

    return ($output | Out-String | ConvertFrom-Json)
}

if (-not (Test-Path -LiteralPath $registryPath)) {
    throw "Missing source registry: $registryPath"
}

$registry = Get-Content -LiteralPath $registryPath -Raw | ConvertFrom-Json
if ($registry.schemaVersion -ne 1) {
    Add-Failure "Unsupported schemaVersion '$($registry.schemaVersion)'."
}

$sourceIds = @($registry.sources | ForEach-Object { $_.id })
if ($sourceIds.Count -ne (@($sourceIds | Select-Object -Unique).Count)) {
    Add-Failure 'Source IDs must be unique.'
}

foreach ($source in $registry.sources) {
    if ([string]::IsNullOrWhiteSpace($source.id) -or [string]::IsNullOrWhiteSpace($source.classification) -or [string]::IsNullOrWhiteSpace($source.kind) -or [string]::IsNullOrWhiteSpace($source.url)) {
        Add-Failure "Source '$($source.id)' lacks an id, classification, kind, or URL."
        continue
    }

    if ($source.classification -notin @('official', 'community')) {
        Add-Failure "Source '$($source.id)' has invalid classification '$($source.classification)'."
    }

    if ($source.kind -eq 'github-repository') {
        if ([string]::IsNullOrWhiteSpace($source.repository) -or [string]::IsNullOrWhiteSpace($source.ref) -or [string]::IsNullOrWhiteSpace($source.expectedSpdx)) {
            Add-Failure "GitHub source '$($source.id)' must declare repository, ref, and expectedSpdx."
        }
    } elseif ($source.kind -eq 'web-document') {
        $retrievedAt = Get-SourceValue -Source $source -Name 'retrievedAt'
        $publishedAt = Get-SourceValue -Source $source -Name 'publishedAt'
        if ([string]::IsNullOrWhiteSpace($retrievedAt) -and [string]::IsNullOrWhiteSpace($publishedAt)) {
            Add-Failure "Web source '$($source.id)' must declare retrievedAt or publishedAt."
        }
    } else {
        Add-Failure "Source '$($source.id)' has unsupported kind '$($source.kind)'."
    }
}

foreach ($relativePath in $requiredReadmes) {
    if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $relativePath))) {
        Add-Failure "Missing required documentation file '$relativePath'."
    }
}

$sourcesReadme = Get-Content -LiteralPath (Join-Path $repoRoot 'sources/README.md') -Raw
foreach ($source in $registry.sources) {
    if ($sourcesReadme -notlike "*$($source.url)*") {
        Add-Failure "Source URL for '$($source.id)' is missing from sources/README.md."
    }
}

$officialSkillFiles = @(Get-ChildItem -LiteralPath (Join-Path $repoRoot 'official') -Recurse -File -Filter 'SKILL.md')
if ($officialSkillFiles.Count -gt 0) {
    Add-Failure 'official/ must not contain vendored SKILL.md files until their license permits redistribution.'
}

$markdownFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -File -Filter '*.md'
foreach ($markdownFile in $markdownFiles) {
    $content = Get-Content -LiteralPath $markdownFile.FullName -Raw
    foreach ($match in [regex]::Matches($content, '\]\(([^)]+)\)')) {
        $link = $match.Groups[1].Value
        if ($link -match '^https?://') {
            [void]$externalLinks.Add($link)
            continue
        }

        if ($link -match '^(mailto:|#)') {
            continue
        }

        $pathPart = ($link -split '#')[0]
        if ([string]::IsNullOrWhiteSpace($pathPart)) {
            continue
        }

        $targetPath = Join-Path $markdownFile.DirectoryName ([uri]::UnescapeDataString($pathPart))
        if (-not (Test-Path -LiteralPath $targetPath)) {
            $relativeFile = $markdownFile.FullName.Substring($repoRoot.Length + 1)
            Add-Failure "Broken local link in '$relativeFile': $link"
        }
    }
}

if (-not $SkipExternalLinks) {
    foreach ($url in ($externalLinks | Sort-Object)) {
        try {
            $response = Invoke-WebRequest -Uri $url -Method Get -MaximumRedirection 5 -TimeoutSec 25
            if ($response.StatusCode -lt 200 -or $response.StatusCode -ge 400) {
                Add-Failure "External URL '$url' returned HTTP $($response.StatusCode)."
            }
        } catch {
            Add-Failure "External URL '$url' is unavailable: $($_.Exception.Message)"
        }
    }
}

if (-not $SkipRemoteValidation) {
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        Add-Failure 'GitHub CLI gh is required for remote source validation.'
    } else {
        foreach ($source in ($registry.sources | Where-Object { $_.kind -eq 'github-repository' })) {
            try {
                $repository = Get-GitHubJson -Path "repos/$($source.repository)"
                $actualSpdx = if ($null -eq $repository.license) { 'NONE' } else { $repository.license.spdx_id }
                if ($actualSpdx -ne $source.expectedSpdx) {
                    Add-Failure "License for '$($source.id)' changed: expected '$($source.expectedSpdx)', got '$actualSpdx'."
                }

                [void](Get-GitHubJson -Path "repos/$($source.repository)/commits/$($source.ref)")
            } catch {
                Add-Failure "Remote validation failed for '$($source.id)': $($_.Exception.Message)"
            }
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Host "Source registry validation failed with $($failures.Count) issue(s):" -ForegroundColor Red
    $failures | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
    exit 1
}

Write-Host "Source registry validation passed: $($registry.sources.Count) sources, $($markdownFiles.Count) Markdown files, $($externalLinks.Count) external links." -ForegroundColor Green
