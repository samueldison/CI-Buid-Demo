package com.rhino_horn.safari.rhino_horn;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

public class RhinoHornApplicationMainTest {

    @Test
    void testMainMethodRuns() {
        // Random port so the test never collides with 8084 on the build host
        assertDoesNotThrow(() -> RhinoHornApplication.main(new String[]{"--server.port=0"}));
    }
}
