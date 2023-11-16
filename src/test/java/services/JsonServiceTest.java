package services;

import org.junit.jupiter.api.Test;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.assertEquals;

class JsonServiceTest {

    @Test
    void testReadJson()  {

        String path = "/example.json";
        Map<String, Object> expectedMap = Map.of("key", "value");
        Map<String, Object> result = JsonService.readJson(path);
        assertEquals(expectedMap, result);
    }
}

