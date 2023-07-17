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

    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("d MMMM uuuu");
    private MedicalsService medicalsService;

    private Pilot pilot;

    @Before
    public void setUpMedicalsService() {
        medicalsService = new MedicalsService();
    }

    @ParameterType(".*")
    public PilotClass pilotClass(String label) {
        return PilotClass.withLabel(label);
    }

    @ParameterType(".*")
    public LocalDate date(String date) {
        return LocalDate.parse(date, dateFormatter.withResolverStyle(STRICT));
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
        assertThat(medicalsService.findDateLimitForNextMedical(pilot).format(dateFormatter))
                .isEqualTo(date.format(dateFormatter));
    }

    @Given("Peter/Terry is a {pilotClass} pilot born on {date}")
    public void peter_is_a_class_pilot_born_on(PilotClass pilotClass, LocalDate birthDate) {
        pilot = Pilot.builder()
                .pilotClass(pilotClass)
                .birthDate(birthDate)
                .build();
    }

    @When("his last medical was on {date}")
    public void his_last_medical_was_on_january(LocalDate medicalDate) {
        medicalsService.recordDateOfMedical(pilot, medicalDate);
    }

    @When("today is {date}")
    public void today_is(LocalDate date) {
        medicalsService.checkLicenseValidity(pilot, date);
    }

    @Then("his license should now be {pilotClass}")
    public void his_license_should_now_be(PilotClass pilotClass) {
        assertThat(pilot.getPilotClass()).isEqualTo(pilotClass);
    }

    @Then("be valid until {date}")
    public void be_valid_until(LocalDate date) {
        assertThat(medicalsService.findDateLimitForNextMedical(pilot).format(dateFormatter))
                .isEqualTo(date.format(dateFormatter));
    }
}
