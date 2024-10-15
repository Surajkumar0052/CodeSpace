trigger RentCarTrigger on Rent_Car__c (before insert, before update) {
    if(Trigger.isInsert && Trigger.isBefore){
        RentCarHandler.calculateRentAmount();
    }
}