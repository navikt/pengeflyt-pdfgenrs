import io.kotest.matchers.shouldBe
import kotlin.test.Test
import kotlin.test.assertTrue
import org.junit.jupiter.api.MethodOrderer
import org.junit.jupiter.api.Order
import org.junit.jupiter.api.TestMethodOrder

private val ROUTE = OppgjorsrapporterRoute.`trekk-kred`
private val PDF_TEKST: String = lagPdfOgHentTekst(jsonNavn = "trekk-kred", pdfgenRoute = ROUTE)

@TestMethodOrder(MethodOrderer.OrderAnnotation::class)
class TrekkKredTest {
    @Test
    @Order(1)
    fun `kompiler PDF uten feil og lagre lokalt`() {
        assertTrue(PDF_TEKST.isNotEmpty())
    }

    @Test
    fun `trekk-kred PDF har forventet innhold`() {
        PDF_TEKST.also { println(it) } shouldBe
            """
            Trekkoppgjørsrapport fra Nav
            Navn: LILLESTRØM KOMMUNE
            Adresse: Jonas Lies gate 18, 2000
            Organisasjonsnummer: 820710592
            Periode: 01.02.2026 - 28.02.2026
            Kontonummer: 1000 23 23456
            NAV Økonomi Stønad
            Arkivref Sakreferanse Fnr Navn Ytelse f.o.m. - t.o.m. Beløp
            80000844172 - 243927771 Saksnr. 128201 04504349435 Dette er en testperson 30.12.2025 - 31.12.2025 60,00
            80000844172 - 243927771 Saksnr. 128201 04504349435 Dette er en testperson 01.12.2025 - 11.12.2025 268,00
            80000844172 - 243927771 Saksnr. 128201 04504349435 Dette er en testperson 12.12.2025 - 29.12.2025 358,00
            80000844172 - 243927771 Saksnr. 128201 04504349435 Dette er en testperson 19.11.2025 - 26.11.2025 480,00
            80000844172 - 243927771 Saksnr. 128201 04504349435 Dette er en testperson 27.11.2025 - 30.11.2025 160,00
            Delsum arkivref 243927771 1 326,00
            80000819252 - 243928104 Husleie 07793012901 Dette er en testperson 23.02.2026 - 28.02.2026 3 914,00
            80000819252 - 243928104 Husleie 07793012901 Dette er en testperson 16.02.2026 - 22.02.2026 3 914,00
            Delsum arkivref 243928104 7 828,00
            80000819252 - 243928165 Husleie 00576841437 Dette er en testperson 09.02.2026 - 15.02.2026 2 725,00
            80000819252 - 243928165 Husleie 00576841437 Dette er en testperson 16.02.2026 - 22.02.2026 2 725,00
            Delsum arkivref 243928165 5 450,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 09.02.2026 - 13.02.2026 711,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 20.02.2026 - 21.02.2026 143,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 16.02.2026 - 19.02.2026 569,00
            Delsum arkivref 243928328 1 423,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 09.02.2026 - 13.02.2026 711,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 20.02.2026 - 21.02.2026 143,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 16.02.2026 - 19.02.2026 569,00
            Delsum arkivref 243928328 1 423,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 09.02.2026 - 13.02.2026 711,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 09.02.2026 - 13.02.2026 711,00
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 09.02.2026 - 13.02.2026 711,00
            Trekkoppgjørsrapport fra Nav side 1 av 2
            Periode: 01.02.2026 - 28.02.2026
            Organisasjonsnr: 820710592
            Fortsetter fra forrige side
            Arkivref Sakreferanse Fnr Navn Ytelse f.o.m. - t.o.m. Beløp
            80000844172 - 243928328 128195 01154849230 Dette er en testperson 16.02.2026 - 19.02.2026 569,00
            Delsum arkivref 243928328 1 423,00
            80000844172 - 243999801 120666 10581233523 Dette er en testperson 14.02.2026 - 27.02.2026 4 852,00
            Delsum arkivref 243999801 4 852,00
            Sum enhet NAV Økonomi Stønad 20 879,00
            NAV
            Arkivref Sakreferanse Fnr Navn Ytelse f.o.m. - t.o.m. Beløp
            80000816561 - 243928051 04508082521 Dette er en testperson 01.02.2026 - 28.02.2026 15 599,00
            80000816561 - 243928051 04508082521 Dette er en testperson 01.02.2026 - 28.02.2026 18 691,00
            80000816561 - 243928051 04508082521 Dette er en testperson 01.02.2026 - 28.02.2026 −15 599,00
            80000816561 - 243928051 04508082521 Dette er en testperson 01.02.2026 - 28.02.2026 −18 480,00
            80000816561 - 243928051 04508082521 Dette er en testperson 01.02.2026 - 28.02.2026 18 480,00
            80000816561 - 243928051 04508082521 Dette er en testperson 01.02.2026 - 28.02.2026 15 388,00
            Delsum arkivref 243928051 34 079,00
            Sum enhet NAV 34 079,00
            Totalsum kreditor. 54 958,00
            Trekkoppgjørsrapport fra Nav side 2 av 2
            """
                .trimIndent()
                .trim()
    }
}
