import { LightningElement, track } from 'lwc';

export default class CarSearchResult extends LightningElement {
      @track carTypeId;

      carTypeSelectChange(event){
            this.carTypeId = event.detail;
            console.log('Id : ' , this.carTypeId);
      }
}