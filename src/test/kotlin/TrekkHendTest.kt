import io.kotest.matchers.shouldBe
import kotlin.test.Test
import kotlin.test.assertTrue
import org.junit.jupiter.api.MethodOrderer
import org.junit.jupiter.api.Order
import org.junit.jupiter.api.TestMethodOrder

private val ROUTE = OppgjorsrapporterRoute.`trekk-hend`
private val KREDITOR_PDF_TEKST: String = lagPdfOgHentTekst(jsonNavn = "trekk-hend-kreditor", pdfgenRoute = ROUTE)
private val NAMSMANN_PDF_TEKST: String = lagPdfOgHentTekst(jsonNavn = "trekk-hend-namsmann", pdfgenRoute = ROUTE)

@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class TrekkHendTest {
    @Test
    @Order(1)
    fun `kompiler PDF uten feil og lagre lokalt`() {
        assertTrue(KREDITOR_PDF_TEKST.isNotEmpty())
        assertTrue(NAMSMANN_PDF_TEKST.isNotEmpty())
    }

    @Test
    fun `trekk-hend(kreditor) PDF har forventet innhold`() {
        KREDITOR_PDF_TEKST.also { println(it) } shouldBe
            """
            Trekkhendelser - tilbakemelding fra Nav til kreditor
            Navn: McDuck inkasso AS
            Adresse: Postboks 313, 3158 ANDEBY
            Organisasjonsnummer: 859 503 241
            Fremkjørt: 21.04.2026
            Fnr Navn Org.nr Kreditors KID/referanse Type hendelse
            184538 66986 Donald Duck 087 453 421 0107036257420540624 Ingen ytelse
            224685 28375 Gulbrand Gråstein 141 619 942 0103064541812328464 Opphør ytelse
            Trekkhendelser (T12) side 1 av 1
            """
                .trimIndent()
                .trim()
    }

    @Test
    fun `trekk-hend(namsmann) PDF har forventet innhold`() {
        NAMSMANN_PDF_TEKST.also { println(it) } shouldBe
            """
            Trekkhendelser - tilbakemelding fra Nav til namsmann
            Navn: NAMSFOGDEN I ANDEBY
            Adresse: Postboks 313, 3158
            Organisasjonsnummer: 087 453 421
            Fremkjørt: 21.04.2026
            Fnr Navn Org.nr Kreditors KID/referanse Type hendelse
            184538 66986 Donald Duck 0107036257420540624 Ingen ytelse
            245089 24131 Guffen Gås 5900562964792591 Ingen ytelse
            284820 19570 Petter Smart 01626785861606857982 Opphør ytelse
            Trekkhendelser (T12) side 1 av 1
            """
                .trimIndent()
                .trim()
    }
}
