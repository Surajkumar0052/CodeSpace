trigger PatienttaskTrigger on Billing_summary__c (before insert) {
    if(Trigger.IsBefore && Trigger.IsInsert){
        PatientNumber.PatienttaskTrigger(Trigger.new);
    }
}