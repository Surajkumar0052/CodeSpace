import { LightningElement, wire } from 'lwc';
import { fireEvent} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class SendingComponentPubSub extends LightningElement {
    message = 'Hello';
    @wire(CurrentPageReference) pageRef;

    handleClick() {
        fireEvent(this.pageRef, 'sendData', this.message);
    }
}