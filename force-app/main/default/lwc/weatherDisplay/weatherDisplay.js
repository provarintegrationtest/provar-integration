import { LightningElement, api, wire } from 'lwc';
import getWeatherInfo from '@salesforce/apex/WeatherDisplayController.getWeatherInfo';
import { CurrentPageReference } from 'lightning/navigation';

export default class WeatherDisplay extends LightningElement {
    weatherInfo;
    error;
    
    get imgUrl(){
        return 'https://openweathermap.org/img/wn/'+this.weatherInfo.imgCode+'@2x.png'
    }

    @wire(CurrentPageReference) pageRef;
    recordId;

    connectedCallback(){
        this.recordId = this.pageRef.attributes.recordId;
        getWeatherInfo({locationId:this.recordId}).then(data=>{
            if (data) {
                this.weatherInfo={humidity:data.Humidity__c + '%',lastUpdated:data.CreatedDate,windSpeed:data.Wind_Speed__c + 'm/s',temperature:data.Temperature_Degree_celcius__c + '°C',imgCode:data.Icon__c,locationName:data.Location__r.Name,description:data.Description__c.charAt(0).toUpperCase()+ data.Description__c.slice(1) }
                this.error = undefined;
              } else if (error || data===null) {
                this.error = 'Unable to fetch weather API response, please try refreshing the page. If the error still persist please try after some time.';
                this.weatherInfo = undefined;
              }
        });
    }
}