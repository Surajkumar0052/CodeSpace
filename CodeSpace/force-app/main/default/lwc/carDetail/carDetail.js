import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import checkAvailability from '@salesforce/apex/CarSearchController.checkAvailability';

export default class CarDetail extends NavigationMixin(LightningElement) {
      @api carId;
      @api car;

      getAvailability() {
            console.log(this.carId);
            checkAvailability({ Id: this.carId })
                  .then(result => {
                        console.log('result' , result);
                        if (result == 'true') {
                              console.log('Available');
                        }
                        else {
                              console.log('Not available');
                        }
                  })
                  .catch(error=>{
                        console.log('Error : ' , error);
                  })

      }


}