import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
const FIELDS = ['Account.Id', 'Account.Industry'];
export default class ToastMessage extends LightningElement {
    @api recordId;
    account;
    lastModifiedDate;
    showScreen;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredRecord({ error, data }) {
        if (error) {
            console.log('error occured');
        } else if (data) {
            console.log('OUTPUT : ',data);
            this.account = data;
            let modifiedDate = this.account.lastModifiedDate;
            if(data.fields.Industry.value !== 'Web'){
                this.showScreen = true;
                this.showNotification();
            }
            
        }
    }
    showNotification() {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'It is npot hpt',
            variant: 'Error'
        });
        this.dispatchEvent(evt);
    }
}