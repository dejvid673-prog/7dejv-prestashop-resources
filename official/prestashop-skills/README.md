# Oficjalne PrestaShop Skills

- Źródło: [`PrestaShop/skills`](https://github.com/PrestaShop/skills)
- Zweryfikowana gałąź: `main`
- Zweryfikowany commit: `0bbf2e0db4379118e968ca87707500cf688c22c1`
- Data weryfikacji: 2026-08-19

Repozytorium jest oficjalnym katalogiem instrukcji dla agentów AI obsługujących, zarządzających i rozwijających PrestaShop.

## Aktualny katalog

| Folder upstream | Nazwa w README upstream | `name` w `SKILL.md` | Funkcja |
| --- | --- | --- | --- |
| `autoupgrade/user/prestashop-update-check` | `prestashop-store-check` | `prestashop-update-check` | sprawdzenie gotowości sklepu do aktualizacji |
| `autoupgrade/user/prestashop-update` | `prestashop-store-update` | `prestashop-update` | wykonanie aktualizacji przez Update Assistant |
| `autoupgrade/user/prestashop-restore` | `prestashop-store-rollback` | `prestashop-restore` | przywrócenie wskazanego backupu |

Rozbieżność nazw między tabelą w upstream README a frontmatter plików `SKILL.md` jest stanem upstream na przypiętym commicie. Przy automatycznej instalacji lub routingu należy sprawdzać rzeczywistą nazwę po instalacji, zamiast zakładać jedną z wersji.

## Instalacja wskazana przez upstream

```text
npx skills install PrestaShop/skills/autoupgrade/user
```

## Ocena bezpieczeństwa

- `prestashop-update-check` jest zasadniczo diagnostyczny i nakazuje nie naprawiać błędów automatycznie.
- `prestashop-update` uruchamia backup oraz aktualizację. Zawiera bramkę przed aktualizacją, ale wymaga dodatkowej lokalnej zasady: potwierdzenia integralności backupu, dokładnej instancji sklepu i dostępnego planu wycofania przed `update:start`.
- `prestashop-restore` wybiera backup przez bramkę, lecz samo przywracanie jest operacją destrukcyjną. W 7DEJV OS wymaga ponownego potwierdzenia bezpośrednio przed wykonaniem.
- Parametr `-q` ogranicza wyjście. W zadaniu produkcyjnym trzeba zachować i sprawdzić logi zamiast polegać wyłącznie na komunikacie końcowym.

## Licencja i sposób przechowywania

Na zweryfikowanym commicie repozytorium nie zawierało pliku `LICENSE`, a GitHub nie zwracał rozpoznanej licencji. Z tego powodu treść `SKILL.md` nie została skopiowana do tego repozytorium. Przechowujemy katalog, linki, hashe plików i przypiętą rewizję.

## Linki bezpośrednie

- [`prestashop-update-check/SKILL.md`](https://github.com/PrestaShop/skills/blob/0bbf2e0db4379118e968ca87707500cf688c22c1/autoupgrade/user/prestashop-update-check/SKILL.md)
- [`prestashop-update/SKILL.md`](https://github.com/PrestaShop/skills/blob/0bbf2e0db4379118e968ca87707500cf688c22c1/autoupgrade/user/prestashop-update/SKILL.md)
- [`prestashop-restore/SKILL.md`](https://github.com/PrestaShop/skills/blob/0bbf2e0db4379118e968ca87707500cf688c22c1/autoupgrade/user/prestashop-restore/SKILL.md)
