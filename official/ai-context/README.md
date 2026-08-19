# Oficjalny kontekst AI PrestaShop

PrestaShop utrzymuje centralne pliki kontekstu, które opisują architekturę, granice legacy, multistore, CQRS, konwencje i testy dla agentów AI.

## Źródła

- [AI-Assisted Development — PrestaShop Developer Documentation](https://devdocs.prestashop-project.org/9/development/ai-assisted-development/)
- [`PrestaShop/PrestaShop/.ai/CONTEXT.md`](https://github.com/PrestaShop/PrestaShop/blob/develop/.ai/CONTEXT.md)
- [Katalog `.ai/` w PrestaShop core](https://github.com/PrestaShop/PrestaShop/tree/develop/.ai)

Zweryfikowany commit gałęzi `develop`: `d53bb168759633cd073231ea576b650bb38a0878`.

## Wzorzec

`CONTEXT.md` jest wspólnym źródłem prawdy. Pliki takie jak `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, reguły Cursor i instrukcje Copilot mają do niego kierować zamiast utrzymywać różne, rozchodzące się kopie zasad.

Pełna hierarchia `.ai/` jest dokumentowana dla PrestaShop 9.2. Nie należy automatycznie narzucać jej starszemu sklepowi lub modułowi bez sprawdzenia jego wersji i architektury.
