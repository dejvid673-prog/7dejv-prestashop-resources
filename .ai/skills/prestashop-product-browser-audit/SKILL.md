---
name: prestashop-product-browser-audit
description: Audit a PrestaShop product page as a shopper without editing product data or completing checkout.
metadata:
  short-description: PrestaShop product page QA skill
---

# PrestaShop Product Browser Audit

Use this skill for product QA on a local or staging PrestaShop shop when you need to verify the customer-facing result of a change.

## Default Behavior

- Act like a shopper, not like an administrator.
- Do not edit products in the back office.
- Do not save product data through forms.
- Do not finalize checkout.
- Prefer observation, screenshots, and notes over mutation.
- Add to cart only when it is useful and safe on local or staging. Do not perform that mutation on production without explicit authorization.

## Workflow

1. If a product URL is provided, open that URL.
2. If an ID, SKU, or reference is provided, locate the corresponding product through an available storefront search or a verified mapping, then open its product URL.
3. If the product cannot be identified unambiguously, stop and report `NOT VERIFIED`.
4. Confirm the page loads and record HTTP errors, redirects, browser errors, and visible UI failures.
5. Inspect the visible product data.
6. Check desktop rendering, HTML integrity, broken links, unsafe output or XSS symptoms, missing media, and layout integrity.
7. Inspect `meta_title` and `meta_description` in the document `<head>` or DOM when browser tooling provides access. If tooling exposes only the visible page, mark those fields `NOT VERIFIED`; never infer them from the H1 or page content.
8. Verify variation behavior when combinations exist.
9. Verify price and VAT presentation when visible.
10. Check a mobile or narrow viewport when browser tooling supports it.
11. Optionally perform a safe add-to-cart test on local or staging.
12. Collect screenshots or other artifacts if the browser supports them.
13. Report the findings against explicit PASS/FAIL criteria.

## What to Check

- product identity
- environment
- URL
- HTTP/browser status
- observed fields
- visual/UI status
- content status
- SEO status
- variation status
- price/VAT status
- errors
- warnings
- screenshots/artifacts
- PASS/FAIL
- recommended corrections

## Classification Rules

Separate problems into the correct bucket:

- bad data
- theme or UI problem
- module problem
- PrestaShop core problem
- not verifiable from the available surface

## Extra Checks

- Confirm name, SKU or reference if visible, price, VAT when shown, `description`, `description_short`, images, breadcrumb, category, availability, units, weight or logistics data, H1, and URL / `link_rewrite`.
- Verify `meta_title` and `meta_description` only from document metadata when tooling exposes it; otherwise report them as `NOT VERIFIED`.
- If combinations exist, switch variants and verify price, SKU/reference, images, selected attributes, and availability changes.
- Watch for XSS, broken HTML, broken links, missing media, or layout breakage.
- Use mobile checks if the browser tooling supports them.

## Guardrails

- Never treat this skill as a write path.
- If the only way to verify something is to mutate live data, stop and report the limitation.
- Read internals only when needed to interpret a behavior, not as a substitute for the browser audit itself.
- Do not assign a core, module, theme, or data root cause from appearance alone; use `NOT VERIFIED` when evidence is insufficient.
