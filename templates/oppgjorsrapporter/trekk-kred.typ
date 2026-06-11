// pdfgenrs tilbyr JSON fra POST på denne pathen
#let data = json("/data/oppgjorsrapporter/trekk-kred.json")

// Vi ønsker å kunne gjenbruke dokument-tittelen både i metadata og i tekster, så den er definert som en variabel her:
#let rapport-tittel = [Trekkoppgjørsrapport fra Nav]

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
        columns: (auto, 2cm, 1fr, auto),
        inset: 4pt,
        align: top,
        logo,
        [],
        [],
        grid(
          columns: (auto, auto),
          inset: 4pt,
          [Periode:], [*#data.periode.fra - #data.periode.til*],
          [Organisasjonsnr:], [#data.bedrift.orgnr],
        ),
      )
    }
  },
  footer: context [
    #set text(size: 8pt)
    #rapport-tittel
    #h(1fr)
    #counter(page).display((side, total) => [side #side av #total], both: true)
  ],
)

#title()
#grid(
  columns: (auto, 1fr, auto),
  grid(
    columns: (auto, auto),
    inset: 4pt,
    [Navn:], data.bedrift.navn,
    [Adresse:], data.bedrift.adresse,
    [Organisasjonsnummer:], data.bedrift.orgnr,
  ),
  [],
  grid(
    columns: (auto, auto),
    inset: 4pt,
    [Periode:], [*#data.periode.fra - #data.periode.til*],
    [Kontonummer:], [#data.bedrift.kontonummer],
    [], [],
  ),
)

#let sum-row(..celler) = (
  celler
    .pos()
    .map(c => table.cell(
      fill: rgb("f2f3f5"),
      stroke: (top: 1pt + rgb("e4e4e4"), bottom: 1pt + rgb("e4e4e4")),
      c,
    ))
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

#for (navn, sumEnhet, arkivreferanser) in data.enheter [
  = #navn

  #let table-counter = counter("tabell-" + navn);

  #table(
    columns: (auto, auto, auto, 1fr, auto, auto, 0pt),
    align: (auto, auto, auto, auto, auto, right, auto),
    table.header(
      level: 1,
      table.cell(
        colspan: 7,
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
      [*Arkivref*],
      [*Sakreferanse*],
      [*Fnr*],
      [*Navn*],
      [*Ytelse f.o.m. - t.o.m.*],
      [*Beløp*],
      [],
    ),
    ..{
      let tabellrad(arkivref, t, rowspan) = {
        (
          [#t.tssId - #arkivref],
          t.saksreferanse,
          t.fnr,
          t.navn,
          if "periodeFra" in t
            and "periodeTil" in t [#t.periodeFra - #t.periodeTil],
          t.belop,
          table.cell(rowspan: rowspan, breakable: false)[],
        )
      }

      let subtabell(arkivreferanse, ekstrarowspan: 0) = {
        let (arkivref, trekk, refnrsum) = arkivreferanse
        let (..initTrekk, sisteTrekk) = trekk
        for t in initTrekk { tabellrad(arkivref, t, 1) }
        tabellrad(arkivref, sisteTrekk, 2 + ekstrarowspan)
        sum-row([], [], [], [Delsum arkivref #arkivref], [], refnrsum)
      }

      let (..init, sisteArkivref) = arkivreferanser
      for a in init { subtabell(a) }
      subtabell(sisteArkivref, ekstrarowspan: 1)

      sum-row([], [], [], [Sum enhet #navn], [], sumEnhet)
    },
  )
]

#table(
  columns: (1fr, auto),
  align: (left, right),
  ..sum-row([Totalsum kreditor.], data.totalsum)
)




