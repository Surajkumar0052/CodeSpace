trigger ContactTrigger on Contact (before insert) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        ContactTriggerHandler.preventDuplicates(Trigger.new);
    }

}