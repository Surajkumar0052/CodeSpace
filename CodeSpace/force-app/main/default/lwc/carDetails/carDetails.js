import { LightningElement,  wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import { registerListener, unregisterAllListeners } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

const fields = [
      'Car__c.Name',
      'Car__c.Mileage__c',
      'Car__c.Per_Day_Rent__c',
      'Car__c.Picture__c',
      'Car__c.Contact__r.Name',
      'Car__c.Contact__r.Email',
      'Car__c.Contact__r.HomePhone',
      'Car__c.Build_Year__c',
      'Car__c.Car_Type__r.Name'
]

export default class CarDetails extends LightningElement {
      carId;
      selectedTabValue;

      @wire(CurrentPageReference) pageRef;

      @wire(getRecord, { recordId: '$carId', fields })
      car;

      connectedCallback() {
            registerListener('carselect', this.callBackMethod, this);
      }

      callBackMethod(payload) {
            this.carId = payload.Id;
      }

      disconnectedCallback() {
            unregisterAllListeners(this);
      }

      tabChangeHandler(event) {
            this.selectedTabValue = event.target.value;
      }

      addedReviewHandler(){
            const carReview = this.template.querySelector('c-car-reviews');
            if(carReview){
                  carReview.getCarReviews();
            }

            console.log('tab : ' , this.selectedTabValue);
            this.selectedTabValue = 'viewreviews';
      }

      get carFound() {
            if (this.car.data) {
                  console.log('True');
                  return true;
            }
            console.log('False');
            return false;
      }
}