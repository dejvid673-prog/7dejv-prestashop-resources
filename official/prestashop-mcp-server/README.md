# PrestaShop MCP Server

## Co zostało potwierdzone

PrestaShop oficjalnie dokumentuje MCP Server jako warstwę udostępniającą dane i akcje sklepu klientom zgodnym z Model Context Protocol. PrestaShop 9.2 Beta 1 wykorzystuje go w funkcji Ask AI.

Oficjalne źródła:

- [MCP Overview](https://docs.mcp.prestashop.com/en/1-mcp-overview/)
- [PrestaShop 9.2 Beta 1 — Ask AI i MCP Server](https://build.prestashop-project.org/news/2026/prestashop-9-2-beta1/)
- [`PrestaShopCorp/ps-mcp-server-stubs`](https://github.com/PrestaShopCorp/ps-mcp-server-stubs)

## Czego nie wolno mylić

`ps-mcp-server-stubs` nie jest pełnym serwerem ani modułem gotowym do instalacji. To paczka do autouzupełniania i analizy statycznej dla modułów deklarujących narzędzia, prompty i zasoby MCP.

Zweryfikowany commit stubs: `7d3716324415b148c1c13ab818d1f9b3f3e13458`.

Pełne publiczne repozytorium oficjalnego modułu `ps_mcp_server` nie zostało potwierdzone podczas audytu. Projekty znalezione pod kontami prywatnych autorów nie zostały zaklasyfikowane jako oficjalne.

## Licencja

README oraz `LICENSE.txt` repozytorium stubs określają licencję jako własnościową (`Proprietary — Copyright (c) PrestaShop SA. All Rights Reserved`). Kod nie został skopiowany do tego repozytorium.

## Status produkcyjny

Na dzień audytu najnowszym potwierdzonym wydaniem linii 9.2 było `9.2.0-beta.1`. Oficjalna informacja ostrzega, aby nie używać tej wersji na sklepie produkcyjnym. Pilotaż MCP należy prowadzić na osobnej instancji testowej, z minimalnymi uprawnieniami i rejestrem każdej akcji zapisu.
