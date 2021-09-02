package com.napt.api.steps;

import com.napt.framework.ui.runner.WebDriverManager;
import io.cucumber.core.api.Scenario;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import org.apache.log4j.Logger;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriverException;

import java.net.MalformedURLException;

/**
 * Hooks Class
 */
public class Hooks  {

    private static final Logger log = Logger.getLogger(Hooks.class);

    @Before
    public void beforeScenario(Scenario sc) throws MalformedURLException {
        log.info("Scenario: " + sc.getName());
    }

    /**
     * Capture a selenium screenshot when a test fails and add it to the Cucumber generated report
     * if the scenario has accessed selenium in its lifetime
     *
     * @throws ClassCastException, WebDriverException
     */
    private void screenshotCapture(Scenario sc) {
        if (sc.isFailed()) {
            log.info("sc is Failed: " + sc.isFailed());
            if (WebDriverManager.getDriver() instanceof TakesScreenshot) {
                TakesScreenshot takeScreenshot = (TakesScreenshot) WebDriverManager.getDriver();
                try {
                    byte[] data = takeScreenshot.getScreenshotAs(OutputType.BYTES);
                    sc.embed(data, "image/png");
                    log.info("Screenshot Embed it in the report");
                } catch (ClassCastException cce) {
                    cce.printStackTrace();
                } catch (WebDriverException wde) {
                    System.err.println(wde.getMessage());
                }
            } else {
                log.warn("This web driver implementation cannot create screenshots: " + WebDriverManager.getDriver().getClass().getName());
            }
        }
    }

    @After
    public void afterScenario(Scenario sc) {
            log.info(sc.getName() + "has finished with result " + sc.getStatus().name());
    }

}