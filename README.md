# Katalog oficjalnych zasobów PrestaShop dla 7DEJV

To repozytorium porządkuje zweryfikowane materiały dotyczące PrestaShop, agentów AI, skills i Model Context Protocol (MCP).

> [!IMPORTANT]
> To jest repozytorium użytkownika `dejvid673-prog`. Nie jest oficjalnym repozytorium ani produktem projektu PrestaShop i nie jest przez niego utrzymywane.

## Co znajduje się w repozytorium

| Katalog | Zawartość | Status |
| --- | --- | --- |
| [`official/`](official/) | Zweryfikowane zasoby należące do organizacji PrestaShop lub PrestaShopCorp | katalog źródeł |
| [`community/`](community/) | Materiały społecznościowe, wyraźnie oddzielone od oficjalnych | tylko referencje |
| [`planned/`](planned/) | Propozycje własnych skills 7DEJV | niezaimplementowane |
| [`sources/`](sources/) | Rejestr źródeł, licencji i przypiętych rewizji | źródło prawdy |
| [`audit/`](audit/) | Raporty z przeglądów repozytorium i źródeł | audyt |

## Najważniejsze ustalenia

- Oficjalne repozytorium [`PrestaShop/skills`](https://github.com/PrestaShop/skills) zawiera obecnie trzy skills związane z Update Assistant.
- Oficjalny PrestaShop MCP Server jest udokumentowany przez PrestaShop, ale pełny kod serwera nie został potwierdzony jako publiczne repozytorium. Publiczne [`PrestaShopCorp/ps-mcp-server-stubs`](https://github.com/PrestaShopCorp/ps-mcp-server-stubs) to wyłącznie stubs dla IDE i analizy statycznej.
- PrestaShop 9.2 Beta 1 zawiera Ask AI oparte o MCP, ale jest wersją przedprodukcyjną i nie powinna być używana w sklepie produkcyjnym.
- Oficjalne pliki kontekstu dla agentów AI są dostępne w `.ai/` repozytorium PrestaShop core od linii 9.2.

## Zasady bezpiecznego użycia

1. Najpierw środowisko testowe lub staging, nigdy pierwszy test na produkcji.
2. Aktualizacja i przywracanie sklepu wymagają wskazania dokładnej instancji, sprawdzonej kopii zapasowej i osobnej zgody bezpośrednio przed operacją.
3. Materiał bez jednoznacznej licencji nie jest kopiowany do tego repozytorium. Zamiast tego przechowujemy link, commit SHA i opis.
4. Materiały społecznościowe nie mogą być oznaczane jako oficjalne.
5. `planned/` jest backlogiem. Obecność README nie oznacza, że skill został zaimplementowany lub przetestowany.

## Szybki start

Oficjalna instrukcja instalacji skills Update Assistant:

```text
npx skills install PrestaShop/skills/autoupgrade/user
```

Nie uruchamiaj tej komendy automatycznie na stanowisku produkcyjnym. Najpierw przeczytaj [przegląd oficjalnych skills](official/prestashop-skills/) i [raport audytu](audit/2026-08-19-initial-audit.md).

## Stan katalogu

Rejestr został zweryfikowany 2026-08-19. Źródła mogą się zmienić; przed instalacją należy odświeżyć rewizje w [`sources/README.md`](sources/README.md).
