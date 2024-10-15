import { LightningElement, wire, track } from 'lwc';
import getCarTypes from '@salesforce/apex/CarSearchController.getCarTypes';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CarSearch extends NavigationMixin(LightningElement) {
      carTypes;
      isShowModal = false;
      carLookup;
      

      @wire(getCarTypes)
      wiredCarTypes({ data, error }) {
            if (data) {
                  this.carTypes = [{ value: '', label: 'All Types' }];
                  data.forEach(element => {
                        const carType = {};
                        carType.label = element.Name;
                        carType.value = element.Id;
                        this.carTypes.push(carType);

                  });

            }
            else if (error) {
                  console.log('Error in getting CarType Data : ', error);
                  this.showNotification('Error', error.body.message, 'error');
            }
      }



      handleCarTypeChange(event) {
            const carTypeId = event.detail.value;
            console.log('carTypeId : ', event.detail.value);

            const carTypeSelectChange = new CustomEvent('cartypeselect', { detail: carTypeId });
            this.dispatchEvent(carTypeSelectChange);
      }

      rentCarHandler() {

            // this[NavigationMixin.Navigate]({
            //       type: 'standard__objectPage',
            //       attributes: {
            //             objectApiName: 'Rent_Car__c',
            //             actionName: 'new',
            //       },
            // });

            this.isShowModal = true;

            // this[NavigationMixin.Navigate]({
            //       type: 'standard__objectPage',
            //       type: 'standard__webPage',
            //       attributes: {
            //             url: 'https://rzp.io/l/Uwova5GL2'
            //       },
            // });

      }

      hideModalBox() {
            this.isShowModal = false;
      }

      showNotification(title, message, variant) {
            this.dispatchEvent(new ShowToastEvent({
                  title: title,
                  message: message,
                  variant: variant
            }));
      }

}