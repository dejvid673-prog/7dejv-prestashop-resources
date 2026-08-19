---
name: prestashop-internals-foundations
description: Map PrestaShop internals and safe extension points before architecture, development, or core-behavior analysis.
metadata:
  short-description: PrestaShop internals map and safe extension boundaries
---

# PrestaShop Internals Foundations

Use this skill when you need to understand where a PrestaShop feature lives, what owns it, and which extension point is safest.

## Version Gate

- Determine the exact target version from the repository, project metadata, or explicit task context. PrestaShop 9.1.x is the target only when the project or an explicit requirement establishes it.
- If the exact target version cannot be determined, do not guess. Stop version-dependent analysis and mark it `NOT VERIFIED`.
- The full core `.ai/` hierarchy starts with PrestaShop 9.2 and is absent from the `9.1.x` branch. For a 9.1.x target, use `develop/.ai` only as supplementary architectural guidance and verify every conclusion against 9.1.x code and PrestaShop 9 DevDocs.
- Do not project a 9.2-only path, service, or convention onto 9.1.x. If the target source cannot be inspected, stop version-dependent analysis and report `NOT VERIFIED`.

## Prerequisites

Before drawing any conclusions:

1. Determine the exact target PrestaShop version.
2. Read the target core's root `.ai/CONTEXT.md` when it exists; otherwise follow the 9.1.x fallback in the version gate.
3. Read the relevant domain context when available and inspect the matching target-version domain code.
4. Read the relevant component contexts when available and inspect the matching target-version component code.

For product work, start with `Domain/Product/CONTEXT.md` and then load the related component contexts for CQRS, Forms, Context, Router, Database, Hook, Locale, and Multistore as needed.

## What This Skill Should Produce

PRESTASHOP INTERNALS MAP

- Target version
- Relevant domains
- Relevant components
- Relevant legacy elements
- Relevant CQRS: commands, queries, handlers, `CommandBus`, and `QueryBus`
- Controllers/routes
- Services and dependency injection
- Hooks
- Forms and grids
- Permissions, `AdminSecurity`, and CSRF
- Multistore and `ShopConstraint`
- Languages, locale, and translations
- Persistence/data
- Product and combinations when relevant
- Safe extension points
- Forbidden modifications
- Risks
- Recommended sources

## Working Rules

- Treat `src/Core`, `src/Adapter`, `src/PrestaShopBundle`, `classes`, `controllers`, `modules`, `themes`, `admin-dev`, and `config/services` as architectural locations to classify, not as a license to edit core.
- Prefer supported extension points: modules, hooks, Symfony controllers, CQRS handlers, services, forms, grids, repositories, and configuration.
- Do not recommend editing upstream core when a module or adapter layer can solve the problem.
- Distinguish modern code from legacy boundaries. Note where ObjectModel, legacy controllers, or legacy globals still matter.
- Call out `ShopConstraint`, permission scope, `AdminSecurity`, CSRF, translation scope, and multistore scope whenever they affect the answer.
- Distinguish `src/Core/Domain` declarations from concrete implementations in `src/Adapter`, and identify whether persistence uses Doctrine, a repository wrapping `ObjectModel`, or an unavoidable legacy path.
- Do not recommend direct SQL when an appropriate domain command, query, repository, or public API exists. Any unavoidable SQL must be parameterized and correctly scoped.
- If the target version is unknown, stop version-dependent analysis and mark it `NOT VERIFIED`. If a relevant file path cannot be verified, mark that path and conclusions depending on it `NOT VERIFIED`.

## Reading Order

When the task touches a specific area, load only the matching official contexts:

- Product catalog work: Product domain first.
- Back-office pages: Controller, CQRS, Forms, Grid, Router, Database, Context, Locale.
- Module extension work: Hook, Controller, Forms, CQRS, Database, and the target domain.
- Multi-shop behavior: MULTISTORE and Context.

## Decision Standard

The answer should tell the caller:

- where the feature lives,
- which layer owns the logic,
- which files are reference only,
- which files are safe extension points,
- and which files or patterns should not be modified.
