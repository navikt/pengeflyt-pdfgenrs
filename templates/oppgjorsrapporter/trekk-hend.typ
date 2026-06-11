// pdfgenrs tilbyr JSON fra POST på denne pathen
#let data = json("/data/oppgjorsrapporter/trekk-hend.json")

// Vi ønsker å kunne gjenbruke dokument-tittelen både i metadata og i tekster, så den er definert som en variabel her:
#let rapport-tittel = [Trekkhendelser - tilbakemelding fra Nav til #data.mottaker.type]

// Metadata om selve dokumentet
#set document(
  title: rapport-tittel,
  author: "pengeflyt-pdfgenrs",
  description: rapport-tittel,
)

// Sideoppsett, skriftstørrelse, etc.
#set text(font: "Source Sans Pro", size: 10pt, fill: rgb("3e3832"))
#set page(
  paper: "a4",
  flipped: true, // i.e. landscape orientation
  margin: (
    x: 2cm,
    top: 3cm, // For å få plass til headeren
    bottom: 1cm,
  ),
  header: context {
    let logo = image("/resources/nav-logo.svg", alt: "NAV logo")
    if here().page() == 1 {
      logo
    } else {
      grid(
        columns: (auto, 2cm, 1fr),
        inset: 4pt,
        align: top,
        logo,
        [],
        grid(
          columns: (1fr, auto, auto),
          inset: 4pt,
          strong(rapport-tittel), [Fremkjørt:], strong(data.dato),
          [#data.mottaker.navn (org.nr #data.mottaker.orgnr.formattert)],
          [],
          [],
        ),
      )
    }
  },
  footer: context [
    #set text(size: 8pt)
    Trekkhendelser (T12)
    #h(1fr)
    #counter(page).display((side, total) => [side #side av #total], both: true)
  ],
)

// Grafisk profil på tabellen med trekkhendelser
#set table(
  stroke: (_, y) => {
    let width = if y == 1 {
      // Tabell-header med navn på kolonner - skal ha litt tykkere strek under seg
      2pt
    } else { 1pt }
    return if y == 0 {
      // Tabell-header for "tabellen fortsetter fra forrige side"; vil kun ha tekst på side 2 og utover
      none
    } else {
      (bottom: width + rgb("ddd"), rest: none)
    }
  },
  fill: (_, y) => if y == 1 {
    // Tabell-header med navn på kolonner - skal ha lyseblå bakgrunn
    rgb("e6f0ff")
  },
  inset: 4pt,
)

#title()
#grid(
  columns: (auto, 1fr, auto),
  grid(
    columns: (auto, auto),
    inset: 4pt,
    [Navn:], data.mottaker.navn,
    [Adresse:], data.mottaker.adresse,
    [Organisasjonsnummer:], data.mottaker.orgnr.formattert,
  ),
  [],
  grid(
    columns: (auto, auto),
    inset: 4pt,
    [Fremkjørt:], strong(data.dato),
    [], [],
    [], [],
  ),
)

#let table-counter = counter("tabell");
#table(
  columns: (15%, 30%, 15%, 1fr, 10%),
  table.header(
    level: 1,
    table.cell(
      colspan: 5,
      {
        table-counter.step()
        context {
          if table-counter.get().first() > 1 {
            [Fortsetter fra forrige side #v(.5em)]
          }
        }
      },
    ),
  ),
  table.header(
    level: 2,
    [Fnr], [Navn], [Org.nr], [Kreditors KID/referanse], [Type hendelse],
  ),
  ..for h in data.trekkHendelser {
    (
      [#h.fnr.formattert],
      [#h.navn],
      if h.namsmannOrgnr == none [] else [#h.namsmannOrgnr.formattert],
      [#h.kid],
      [#h.hendelse],
    )
  },
)
