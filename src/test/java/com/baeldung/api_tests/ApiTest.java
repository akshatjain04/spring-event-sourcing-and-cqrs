
  package com.baeldung.api_tests;

  import com.intuit.karate.Results;
  import com.intuit.karate.Runner;
  // import com.intuit.karate.http.HttpServer;
  // import com.intuit.karate.http.ServerConfig;
  import org.junit.jupiter.api.Test;

  import static org.junit.jupiter.api.Assertions.assertEquals;

  class ApiTest {

      @Test
      void testAll() {
          String apiHostServer = System.getenv().getOrDefault("API_HOST", "http://petstore.swagger.io/v2");
          Results results = Runner.path("classpath:com\\baeldung\\api_tests")
                  .systemProperty("url.base", apiHostServer)
                  .parallel(1);
          assertEquals(0, results.getFailCount(), results.getErrorMessages());
      }

  }
