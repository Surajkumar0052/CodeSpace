trigger MsPincodeTrigger on Ms_Pincode__c (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isUpdate || trigger.isInsert)){
	MsPinCodeHandler.cityUpdate();        
    }
}