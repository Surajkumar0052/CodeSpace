import { api, LightningElement, wire } from 'lwc';
import { fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation'; 

export default class ClassTiles extends LightningElement {
      @api car;
      @api selectedCarId;

      @wire( CurrentPageReference ) pageRef;

      handleCarSelection(event){
            event.preventDefault(); // it will prevent ancor tag

            const carId = this.car.Id;
            this.dispatchEvent(new CustomEvent('carselect', {detail : carId}));

            fireEvent(this.pageRef, 'carselect', this.car);
      }

      get isCarSelected(){
            if(this.car.Id === this.selectedCarId){
                  return "tile selected";
            }
            else{
                  return "tile";
            }
      }
}