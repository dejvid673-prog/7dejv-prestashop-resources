---
name: prestashop-solution-architect
description: Select a minimal PrestaShop solution before coding when several platform extension paths may fit.
metadata:
  short-description: PrestaShop architecture decision skill
---

# PrestaShop Solution Architect

Use this skill before writing code when the question is not "how do I implement this?" but "what should I build, and should I build anything at all?"

## Prerequisite

Read `prestashop-internals-foundations` first when the request touches PrestaShop internals, domain code, or extension points. This is a logical workflow dependency, not a runtime dependency.

## Workflow

1. Define the business goal.
2. Define the technical problem.
3. Confirm the exact PrestaShop target version.
4. Inspect the current architecture and existing mechanisms.
5. Check whether PrestaShop already provides the needed behavior.
6. Compare at least two real options when more than one is viable.
7. Recommend one solution and justify why the others are worse.
8. Define the minimal implementation scope.
9. Define acceptance criteria.
10. Define the test plan.
11. Identify failure modes, recovery, and deferred scope.

## Architecture Choices to Evaluate

Consider these possibilities before inventing new code:

- module
- external application
- API integration
- connector
- hook
- Symfony controller
- CQRS command/query
- custom table
- configuration
- existing PrestaShop feature
- no new code

## Comparison Criteria

Compare the options against:

- simplicity
- performance
- security
- compatibility
- maintainability
- multistore behavior
- language behavior
- permissions
- testability
- scalability
- failure recovery
- migration cost

## What This Skill Should Produce

Problem

Business goal

Constraints

Existing PrestaShop mechanisms

Option A

Option B

Option C if needed

Comparison

Recommended architecture

Data flow

Extension points

Security

Permissions

Multistore

Languages

Performance

Failure modes

Recovery

Implementation phases

Acceptance criteria

Test plan

Risks

Deferred scope

## Guardrails

- Actively resist overengineering.
- If the cleanest answer is "do not add code", say that plainly.
- Do not discuss implementation details until the architecture choice is made.
- Do not assume a module is required when a hook, configuration change, or existing core feature is enough.
- Do not design around 9.2-only mechanisms for a 9.1.x target without a verified compatible fallback.
- Stop and report `NOT VERIFIED` if the target version, repository state, affected data, or authorization boundary cannot be established.
- Do not expand into customers, orders, payments, or shipping unless they are explicitly in scope.
