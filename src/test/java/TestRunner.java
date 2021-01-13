import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

/**
 * The UI Test runner
 */

@CucumberOptions(
        features = "features/WSI_UI/WE",
        glue = {"com.napt.api.wsi.steps"},
        tags = {"@test456"},
        plugin = {"pretty", "html:target/cucumber_target.html", "json:target/cucumber.json", "rerun:target/failed_scenarios.txt"})
public class TestRunner extends AbstractTestNGCucumberTests {

}

