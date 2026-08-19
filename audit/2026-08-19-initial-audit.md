# Audyt początkowy — 2026-08-19

## Zakres

- repozytorium `dejvid673-prog/prestashop-oficjalne-repo`,
- materiały wskazane w rozmowie: oficjalne PrestaShop Skills, PrestaShop MCP Server, kontekst AI oraz społecznościowe `jeffsenso/prestashop-skills`,
- pochodzenie, licencje, ryzyko wykonawcze i gotowość do dalszego rozwoju.

Audyt jest statyczny i dokumentacyjny. Nie instalowano skills, modułów, zależności ani PrestaShop. Nie łączono się ze sklepem i nie wykonywano backupu, aktualizacji, przywracania ani operacji MCP.

## Ustalenia

### Wysokie

1. **Nazwa repozytorium może sugerować afiliację.** Naprawione 2026-08-19: repo zostało przemianowane na `7dejv-prestashop-resources`. README nadal jednoznacznie wskazuje, że repo jest własnością `dejvid673-prog`, a nie organizacji PrestaShop.
2. **Brak jawnej licencji w `PrestaShop/skills`.** Publiczna dostępność nie oznacza zgody na redystrybucję. Treści skills nie skopiowano.
3. **Stubs MCP są własnościowe i nie są serwerem.** Nie wolno ich przedstawiać jako pełnej implementacji ani kopiować jako kodu źródłowego serwera.
4. **Update i restore są operacjami wysokiego ryzyka.** Oficjalne skills zawierają bramki, ale lokalna polityka musi dodatkowo wymagać weryfikacji backupu, dokładnego celu, okna serwisowego i ponownej zgody przed zapisem.

### Średnie

1. **Niespójne nazwy skills upstream.** Nazwy prezentowane w README różnią się od pola `name` w `SKILL.md`. Automatyczny router powinien opierać się na faktycznie zainstalowanych plikach.
2. **PrestaShop 9.2 pozostaje przedprodukcyjny w zweryfikowanych źródłach.** Ask AI i MCP należy testować poza produkcją.
3. **Brak potwierdzonego publicznego repo pełnego MCP Servera.** Zewnętrzne repozytoria o podobnej nazwie nie mogą zostać automatycznie uznane za oficjalne.
4. **Repo docelowe nie ma własnej licencji.** To nie blokuje katalogowania, ale utrudnia bezpieczne przyjmowanie wkładu i ponowne wykorzystanie oryginalnej dokumentacji repozytorium.

### Niskie

1. Brak automatycznej walidacji źródeł. Naprawione 2026-08-19 przez `scripts/Test-SourceRegistry.ps1` i GitHub Actions.
2. Repo nie ma jeszcze szablonu decyzji o promocji społecznościowego materiału do lokalnego, utrzymywanego skilla.

## Kontrole bezpieczeństwa

| Kontrola | Wynik | Uwagi |
| --- | --- | --- |
| Sekrety i dane klientów | PASS | repo zawiera wyłącznie publiczne metadane i dokumentację |
| Kod wykonywalny | PASS | nie dodano kodu ani automatycznych instalatorów |
| Oddzielenie official/community/planned | PASS | osobne katalogi i jawne etykiety |
| Pochodzenie | PASS | zapisano URL i commit SHA dla repozytoriów |
| Licencje upstream | PASS z ograniczeniem | brak licencji i proprietary blokują kopiowanie |
| Gotowość produkcyjna MCP/9.2 | BLOCK | dostępne źródła opisują wersję beta |
| Walidacja działającego sklepu | NOT RUN | brak instancji testowej w zakresie zadania |

## Kryteria akceptacji

- [x] Repozytorium ze zrzutu zostało jednoznacznie zidentyfikowane.
- [x] Utworzono logiczne foldery i README.
- [x] Zarejestrowano oficjalne i społecznościowe źródła bez mieszania statusu.
- [x] Zapisano przypięte rewizje i ograniczenia licencyjne.
- [x] Wykonano statyczny audyt bezpieczeństwa materiałów.
- [x] Zmieniono nazwę repozytorium na niezawierającą sugestii afiliacji.
- [x] Wysłano pytanie o licencję do oficjalnego kanału [PrestaShop Discussion #42381](https://github.com/PrestaShop/PrestaShop/discussions/42381).
- [x] Dodano walidator struktury, linków, rewizji i licencji oraz workflow GitHub Actions.
- [ ] Nie skopiowano pełnej treści oficjalnych skills, ponieważ upstream nie deklaruje licencji.
- [ ] Nie uruchomiono pilota MCP ani skills, ponieważ brak osobnej instancji PrestaShop w zakresie tego etapu.

## Rekomendowana kolejność dalszych działań

1. Poczekać na odpowiedź w [PrestaShop Discussion #42381](https://github.com/PrestaShop/PrestaShop/discussions/42381) przed kopiowaniem treści z `PrestaShop/skills`.
2. Utrzymywać przypięte rewizje przez uruchomienie walidatora przy każdej aktualizacji rejestru.
3. Przygotować osobny projekt pilotażowy na świeżej instancji PrestaShop 9.2 dopiero po stabilnym wydaniu albo świadomie na becie, bez danych produkcyjnych.
4. Zacząć własne skills od operacji tylko do odczytu: audyt sklepu, produkty o niskim stanie i raport zamówień. Dopiero po testach dodać kontrolowane zapisy.
