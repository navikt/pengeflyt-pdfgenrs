import io.kotest.matchers.shouldBe
import kotlin.test.Test
import kotlin.test.assertTrue
import org.junit.jupiter.api.MethodOrderer
import org.junit.jupiter.api.Order
import org.junit.jupiter.api.TestMethodOrder

private val ROUTE = OppgjorsrapporterRoute.`ref-arbg`
private val PDF_TEKST: String = lagPdfOgHentTekst(jsonNavn = "ref-arbg", pdfgenRoute = ROUTE)

@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class RefArbgTest {
    @Test
    @Order(1)
    fun `kompiler PDF uten feil og lagre lokalt`() {
        assertTrue(PDF_TEKST.isNotEmpty())
    }

    @Test
    fun `ref-arbg PDF har forventet innhold`() {
        PDF_TEKST.also { println(it) } shouldBe
            """
            Oppgjørsrapport arbeidsgiver – refusjoner fra Nav
            Navn: Helsfyr stål og plasikk Utbetalingsdato: 28.01.2025
            Adresse: Veien 24, 1234, VårBy Rapport sendt: 31.01.2025
            Organisasjonsnr: 974 600 019 Kontonummer: 0247 03 03400
            Totalt til utbetaling til org.nr. 974 600 019, kontonr 0247 03 03400 16 238,68
            Foreldrepenger
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 31.07.2026 4 234,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 1 504,68
            Sum Foreldrepenger 5 738,68
            Sykepenger
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 6 500,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            Sum Sykepenger 10 500,00
            Ytelse A
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 6 500,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            Sum Ytelse A 10 500,00
            Ytelse B
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 6 500,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            Sum Ytelse B 10 500,00
            Ytelse C
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 6 500,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            Sum Ytelse C 10 500,00
            Oppgjørsrapport arbeidsgiver – refusjoner fra Nav 974 600 019 side 1 av 2
            Utbetalingsdato: 28.01.2025
            Kontonummer: 0247 03 03400
            Ytelse D
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 6 500,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            Sum Ytelse D 10 500,00
            Ytelse E
            Underenhet FNR Navn Periode Maksdato Beløp
            009 876 111 123456 78111 Anders Andersen 01.01.2025 - 31.01.2025 6 500,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            009 876 222 123456 78222 Birte Birtesen 15.01.2025 - 31.01.2025 31.07.2026 4 000,00
            Sum Ytelse E 10 500,00
            Totalt til utbetaling til org.nr. 974 600 019, kontonr 0247 03 03400 16 238,68
            Oppgjørsrapport arbeidsgiver – refusjoner fra Nav 974 600 019 side 2 av 2
            """
                .trimIndent()
                .trim()
    }
}
