package medicals.stepdefinitions;

import io.cucumber.java.Before;
import io.cucumber.java.ParameterType;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import medicals.domain.MedicalsService;
import medicals.domain.Pilot;
import medicals.domain.PilotClass;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import static java.time.format.ResolverStyle.STRICT;
import static org.assertj.core.api.Assertions.assertThat;

public class MedicalsStepDefinitions {

    private MedicalsService medicalsService;

    private Pilot pilot;

    @Before
    public void setUpMedicalsService() {
        medicalsService = new MedicalsService();
    }

    @ParameterType("(?:1st|2nd|3rd) class")
    public PilotClass pilotClass(String label) {
        return PilotClass.withLabel(label);
    }

    @ParameterType(".*")
    public LocalDate date(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMMM uuuu");
        return LocalDate.parse(date, formatter.withResolverStyle(STRICT));
    }

    @Given("{word} is a {pilotClass} pilot")
    public void is_a_pilot_with_class(String name, PilotClass pilotClass) {
        pilot = Pilot.builder()
                .pilotName(name)
                .pilotClass(pilotClass)
                .build();
    }

    @Given("(s)he was born on {date}")
    public void was_born_on(LocalDate date) {
        pilot.setBirthDate(date);
    }

    @When("(s)he has a medical exam on {date}")
    public void has_a_medical_exam_on(LocalDate date) {
        medicalsService.recordDateOfMedical(pilot, date);
    }

    @Then("his/her medical certificate will expire on {date}")
    public void medical_certificate_will_expire_on(LocalDate date) {
        assertThat(medicalsService.findDateLimitForNextMedical(pilot))
                .isEqualTo(date);
    }
}
