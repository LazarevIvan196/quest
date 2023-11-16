package services;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class JsonService {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(JsonService.class);
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static Map<String, Object> readJson(String path) {
        try (InputStream inputStream = JsonService.class.getResourceAsStream(path)) {
            return objectMapper.readValue(inputStream, new TypeReference<>() {
            });
        } catch (IOException e) {
            log.error("Error reading JSON data from file.", e);
            return new HashMap<>();
        }
    }


}
