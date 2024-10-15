import { api, LightningElement, track, wire } from 'lwc';
import getCars from '@salesforce/apex/CarSearchController.getCars';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CarSearchResult extends LightningElement {
      @api carTypeId;
      @track cars=[];
      selectedCarId;

      connectedCallback(){
            console.log('Result Id : ', '$carTypeId');
      }
      @wire( getCars, { carTypeId: '$carTypeId' })
      wiredCars({ data, error }) {
            if (data) {
                  console.log('Data wired : ', data);
                  this.cars = data;
                  console.log('Data wired : ', data);
            }
            else if (error) {
                  this.showNotification('Error', error.body.message, 'error');
            }
      }

      handleCarSelect(event){
            const carId = event.detail;
            this.selectedCarId = carId;

      }

      showNotification(title, message, variant) {
            this.dispatchEvent(new ShowToastEvent({
                  title: title,
                  message: message,
                  variant: variant
            }));
      }

      get carsFounded(){
            if(this.cars){
                  return true;
            }
            else{
                  return false;
            }
      }
}