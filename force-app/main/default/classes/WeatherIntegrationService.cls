public without sharing class WeatherIntegrationService {

    // Custom label for OpenWeatherMap API key
    private static final String OPEN_WEATHER_MAP_API_KEY = System.Label.OpenWeatherMapAPIKey;

    // Method to perform RESTful integration and fetch real-time weather information
    public static WeatherInfo__c fetchWeatherInfo(Location__c location) {
        if (location?.Coordinates__c != null) {
            String apiUrl = buildApiUrl(location.Coordinates__c.getLatitude(), location.Coordinates__c.getLongitude());

            // Make HTTP request
            HttpRequest request = new HttpRequest();
            request.setEndpoint(apiUrl);
            request.setMethod('GET');

            HttpResponse response = new Http().send(request);

            // Process the response
            if (response.getStatusCode() == 200) {
                return parseAndSaveWeatherInfo(response.getBody(), location);
            } else {
                System.debug('Weather API request failed with status code: ' + response.getStatusCode());
                
            }
        }
        return null;
    }

    // Helper method to build the API URL
    private static String buildApiUrl(Double latitude, Double longitude) {
        String apiKey = EncodingUtil.urlEncode(OPEN_WEATHER_MAP_API_KEY, 'UTF-8');
        //Temporarily hardcoding the URL this can be later stored in a custom metadata or custom setting. 
        return 'https://api.openweathermap.org/data/2.5/onecall?lat=' + latitude +
               '&lon=' + longitude +
               '&appid=' + apiKey +
               '&units=metric&exclude=minutely,hourly,daily,alerts';
    }

    // Helper method to parse and save weather information
    private static WeatherInfo__c parseAndSaveWeatherInfo(String responseBody, Location__c location) {
        Map<String, Object> parsedResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);

        // Extract relevant weather information from the parsed response
        Map<String, Object> currentWeather = (Map<String, Object>) parsedResponse.get('current');
        Double temperature = (Double) currentWeather.get('temp');
        Double windSpeed = (Double) currentWeather.get('wind_speed');
        Double humidity = (Double) currentWeather.get('humidity');
        String description = ((Map<String,Object>)((List<Object>) currentWeather.get('weather'))?.get(0))?.get('description')?.toString();
        String icon = ((Map<String,Object>)((List<Object>) currentWeather.get('weather'))?.get(0))?.get('icon')?.toString();

        // Save the information to the WeatherInfo__c custom object associated with the Location__c record
        WeatherInfo__c weatherInfo = new WeatherInfo__c();
        weatherInfo.Location__c = location.Id;
        weatherInfo.Location__r = new Location__c(Name=location.Name,Id=location.Id);
        weatherInfo.Temperature_Degree_celcius__c = temperature;
        weatherInfo.Description__c = description;
        weatherInfo.Wind_Speed__c = windSpeed;
        weatherInfo.Humidity__c = humidity;
        weatherInfo.Icon__c = icon;

        insert weatherInfo;
        return weatherInfo;
    }
}