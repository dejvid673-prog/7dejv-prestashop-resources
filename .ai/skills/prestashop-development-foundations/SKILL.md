---
name: prestashop-development-foundations
description: Implement scoped PrestaShop modules, integrations, services, controllers, forms, CQRS, or product changes safely.
metadata:
  short-description: PrestaShop implementation guardrails
  sku: 7DJ-SKL-PS-DEV-001
---

# PrestaShop Development Foundations

Use this skill while implementing module, connector, controller, form, service, CQRS, or product-data work.

## Prerequisites

Before coding:

1. Confirm the exact target PrestaShop version.
2. Read the relevant official `.ai/CONTEXT.md` files when the target version contains them. For 9.1.x, validate supplementary `develop/.ai` guidance against 9.1.x code and PrestaShop 9 DevDocs because the full `.ai/` hierarchy starts with 9.2.
3. Check the existing CQRS, hooks, services, routes, forms, grids, repositories, and legacy boundaries.
4. Reuse the existing repository structure instead of creating parallel solutions.
5. For a module, inspect its version, PrestaShop/PHP compatibility, install/uninstall, upgrade scripts, service configuration, hooks, SQL, permissions, form security, error logging, and package structure.

## Core Rules

- The repository is the source of truth.
- Analyze first, code second.
- Do not modify core when a supported extension point exists.
- Avoid overrides unless there is no acceptable supported path.
- Keep the scope minimal.
- Do not create duplicate behaviors, duplicate files, or duplicate abstractions.
- Define new services through dependency injection.
- Keep controllers thin.
- Keep business logic out of controllers.
- Make multistore scope explicit.
- Make language scope explicit.
- Enforce permissions.
- Enforce CSRF protection.
- Validate all inputs.
- Defend against XSS, SQL injection, path traversal, SSRF, and unauthorized writes.
- Use parameterized database access and prefer existing CQRS, repository, or public API layers over direct SQL.
- Keep secrets out of code and out of the repository.
- Do not change customers, orders, payments, or shipping unless the task explicitly requires it.

## Product-Specific Rules

When the task touches products, distinguish these fields and concepts explicitly:

- `id_product`
- `reference` / SKU
- combination reference
- EAN / GTIN
- MPN
- name
- description
- `description_short`
- `meta_title`, `meta_description`, and `link_rewrite`
- `price`
- `wholesale_price`
- `id_tax_rules_group`
- tax rules, not a free-form VAT number
- category
- manufacturer
- supplier
- features
- attributes
- combinations
- weight and dimensions
- stock
- shop scope
- language scope

Use PrestaShop tax mechanics correctly. Do not model VAT as an arbitrary numeric field when the platform expects a tax rules group.

Do not update a product-level value when the intended target is a combination, language, or shop-specific value.

## What This Skill Should Produce

Goal

Scope

Target version

Repository state

Relevant skills used

Relevant official contexts

Architecture used

Files to change

Implementation

Security controls

Multistore handling

Language handling

Tests

Commands run

Results

Changed files

Errors

Risks

Deferred work

Next step

## Execution Standard

- Report what was actually verified, not what was assumed.
- If a test or validator did not run, say why.
- If a result is not verified, mark it `NOT VERIFIED`.
- Stop before a destructive, production, or external write that lacks explicit authorization.
- Do not declare PASS when required tests, build, static analysis, or runtime checks could not run.
