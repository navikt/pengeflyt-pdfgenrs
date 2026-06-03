// pdfgenrs tilbyr JSON fra POST på denne pathen
#let data = json("/data.json")

// Vi ønsker å kunne gjenbruke dokument-tittelen både i metadata og i tekster, så den er definert som en variabel her:
#let rapport-tittel = [Oppgjørsrapport arbeidsgiver -- refusjoner fra Nav]

// Metadata om selve dokumentet
#set document(
  title: rapport-tittel,
  author: "pengeflyt-pdfgenrs",
  description: rapport-tittel
)
#set text(lang:"no")

// Sideoppsett, skriftstørrelse, etc.
#set text(font: "Source Sans Pro", size: 10pt, fill: rgb("3e3832"))
#set page(
  paper: "a4",
  flipped: false, // portrait
  margin: (
    x: 2cm,
    top: 4cm, // For å få plass til headeren
    bottom: 1cm
  ),
  header: context {
    let logo = image("/resources/nav-logo.svg", alt: "NAV logo")
    if here().page() == 1 {
      logo
    } else {
      grid(
        columns: (auto, 1fr, auto),
        inset: 4pt,
        align: top,
        logo, [], grid(
          columns: (auto, auto),
          inset: 4pt,
          [Utbetalingsdato:], data.utbetalingsDato,
          [Kontonummer:], data.bedrift.kontonummer.formattert,
        ),
      )
    }
  },
  footer: context [
    #set text(size: 8pt)
    #rapport-tittel #data.bedrift.orgnr.formattert
    #h(1fr)
    #counter(page).display((side, total) => [side #side av #total], both: true)
  ]
)

#title()

#grid(
  columns: (auto, 1fr, auto, auto),
  inset: 4pt,
  [Navn:], data.bedrift.navn, [Utbetalingsdato:], data.utbetalingsDato,
  [Adresse:], data.bedrift.adresse, [Rapport sendt:], data.rapportSendt,
  [Organisasjonsnr:], data.bedrift.orgnr.formattert, [Kontonummer:], data.bedrift.kontonummer.formattert,
)

#let sum-linje-bakgrunn = rgb("#f2f3f5")
#let total-linje-stroke = (y: 1pt + rgb("#e4e4e4"))
#let tabell-header-bakgrunn = rgb("e6f0ff")

#let total-utbetalt-linje = grid(
  columns: (20%, auto, 1fr, auto),
  inset: 4pt,
  fill: sum-linje-bakgrunn,
  stroke: total-linje-stroke,
  [],
  [Totalt til utbetaling til org.nr. #data.bedrift.orgnr.formattert, kontonr #data.bedrift.kontonummer.formattert],
  [],
  data.totalsum.formattert
)
#total-utbetalt-linje

#for (ytelse, posteringer, totalbelop) in data.ytelser [
  = #ytelse

  #let table-counter = counter("tabell-" + ytelse);
  #table(
    stroke: none,
    fill: (_, y) => if y == 1 {
      // Tabell-header med navn på kolonner - skal ha lyseblå bakgrunn
      tabell-header-bakgrunn
    } else if y == posteringer.len() + 2 {
      sum-linje-bakgrunn
    },
    inset: 4pt,
    columns: (auto, auto, 1fr, auto, auto, auto),
    align: (auto, auto, auto, auto, auto, right),
    table.header(
      level: 1,
      table.cell(
        colspan: 6,
        {
          table-counter.step()
          context {
            if table-counter.get().first() > 1 {
              [Fortsetter fra forrige side #v(.5em)]
            }
          }
        }
      )
    ),
    table.header(
      level: 2,
      [*Underenhet*], [*FNR*], [*Navn*], [*Periode*], [*Maksdato*], [*Beløp*]
    ),
    ..for p in posteringer {
      (
        p.orgnr.formattert,
        p.fnr.formattert,
        p.navn,
        if "periodeFra" in p and "periodeTil" in p [#p.periodeFra - #p.periodeTil],
        p.at("maksDato", default: none),
        p.belop.formattert,
      )
    },
    [], [], [Sum #ytelse], [], [], totalbelop.formattert
  )
]

#total-utbetalt-linje
