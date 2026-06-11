# pengeflyt-pdfgenrs

[`pengeflyt-pdfgenrs`](https://console.nav.cloud.nais.io/team/oppgjorsrapporter/prod-gcp/app/pengeflyt-pdfgenrs) er en
applikasjon basert på [`pdfgenrs`](https://github.com/navikt/pdfgenrs). Den genererer PDF-filer for Team Pengeflyt sine
applikasjoner.

Tjenesten er i bruk av:

| Applikasjon                                                                    | Bruksområde                                       |
|--------------------------------------------------------------------------------|---------------------------------------------------|
| [`sokos-oppgjorsrapporter`](https://github.com/navikt/sokos-oppgjorsrapporter) | Oppgjørsrapporter til arbeidsgivere og kreditorer |

## Overordnet bilde av applikasjonen

Applikasjonen støtter kun `POST`-kall til spesifikke endepunkter. For bruk i teamet er dette endepunktet
`/api/v1/genpdf/oppgjorsrapporter/<rapporttype>`. Applikasjonen leter da etter `rapporttype.typ` inne i
`templates/oppgjorsrapporter/`. Dette er en [typst](https://typst.app/)-malfil som brukes til å generere en PDF.
For å kunne fylle inn dynamiske felter i malen må `POST`-kallet ha en JSON-payload.

Ved lokal utvikling kan hjelpeskriptet `run_development.sh` kjøres. Det er forutsatt at maskinen du kjører det på
har Docker installert. I en typisk utviklingssituasjon vil man endre på malfiler i `templates` og mockdata i `data`,
effekten av endringer der kan ses ved å gjøre et GET-kall til URL-en som man i produksjon vil gjøre `POST`-kall til.

Når man har kjørt `run_development.sh` kan man for eksempel gå til
[http://localhost:8080/api/v1/genpdf/oppgjorsrapporter/trekk-hend](http://localhost:8080/api/v1/genpdf/oppgjorsrapporter/trekk-hend)
for å se hva kombinasjonen av `templates/oppgjorsrapporter/trekk-hend.typ` og `data/oppgjorsrapporter/trekk-hend.json`
resulterer i.

> [!IMPORTANT]
> I motsetning til hva tilfellet var med den gamle `pdfgen`-applikasjonen, så krever `pdfgenrs` at man restarter
> `run_development.sh` hver gang man har gjort endringer på mal og/eller JSON-data.

## Formattering av `.typ`-filer

For å formatere typst-malfiler kan man bruke [`typstyle`](https://github.com/Enter-tainer/typstyle), en CLI-verktøy for formatering av `.typ`-filer.

### Installasjon

```bash
brew install typstyle
```

### Bruk

```bash
typstyle -i file.typ #formaterer filen in-place.
typstyle -i dir # formaterer filer i en mappe
```


