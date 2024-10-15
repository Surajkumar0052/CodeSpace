trigger BookingTrigger on Booking__c (before insert, before update) {
    BookingHandler newBooking = new BookingHandler();
    if(Trigger.isInsert && Trigger.IsBefore){
        newBooking.onBeforeInsert(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.IsBefore){
        newBooking.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
	
}