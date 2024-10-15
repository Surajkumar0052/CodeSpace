import { LightningElement, wire } from 'lwc';
import { registerListener, unregisterAllListeners} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class ReceivingComponentPubSub extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        registerListener("sendData", this.handleCallback, this);        
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    handleCallback(data){
        console.log('Data : ' + data);
    }
}