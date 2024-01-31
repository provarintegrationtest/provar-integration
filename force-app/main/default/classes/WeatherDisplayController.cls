public without sharing class WeatherDisplayController {
    @AuraEnabled
    public static WeatherInfo__c getWeatherInfo(String locationId) {
        List<WeatherInfo__c> weatherInfoList=new List<WeatherInfo__c>();
        weatherInfoList=[SELECT Icon__c,Humidity__c,Wind_Speed__c,Temperature_Degree_celcius__c, Description__c,Location__r.Name,CreatedDate FROM WeatherInfo__c WHERE Location__c = :locationId AND CreatedDate >= :DateTime.now().addMinutes(-5) LIMIT 1];

        if(weatherInfoList.isEmpty()){
            Location__c location=[Select Id,Name,Coordinates__c FROM Location__c WHERE Id=:locationId];
            weatherInfoList.add(WeatherIntegrationService.fetchWeatherInfo(location));
        }
        if(!weatherInfoList.isEmpty()){
            return weatherInfoList[0];
        }else{
            return null;
        }
    }
}