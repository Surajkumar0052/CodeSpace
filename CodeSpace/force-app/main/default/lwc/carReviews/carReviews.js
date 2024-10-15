import { api, LightningElement, track } from 'lwc';
import getReviews from '@salesforce/apex/CarSearchController.getReviews';
import { NavigationMixin } from 'lightning/navigation';

export default class CarReviews extends NavigationMixin(LightningElement) {

      privateCarId;
      @track carReview = [];

      connectedCallback() {
            console.log('Car Id : ' , this.carId);
            this.getCarReviews();
      }

      @api get carId(){
            return this.privateCarId;
      }
      set carId(value){
            this.privateCarId = value;
            this.getCarReviews();
      }

      @api
      getCarReviews() {
            getReviews({ carId: this.carId })
                  .then((reviews) => {
                        this.carReview = reviews;
                        console.log('Reviewds : ', reviews);
                        console.log('Id : ', this.carId);
                  })
                  .catch(error => {
                        console.log('Error : ', error);
                  })
      }

      userClickHandler(event) {
            const userId = event.target.getAttribute('data--userid');
            this[NavigationMixin.Navigate]({
                  type: "standard__recordPage",
                  attributes: {
                        recordId: userId,
                        objectApiName: "User",
                        actionName: "view",
                  }
            });
      }

      get hasExperiences() {
            if (this.carReview.length > 0) {
                  return true;
            }
            else {
                  return false;
            }
      }

}