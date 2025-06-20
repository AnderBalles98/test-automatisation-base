package com.pichincha;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }
    @Test
    public void testRunner() {
        Results results = Runner.path("src/test/java/com/pichincha/features")
                .tags("@HU001").outputCucumberJson(true).parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
