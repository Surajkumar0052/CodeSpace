/**
 * @description       : 
 * @author            : Suraj Kumar
 * @group             : 
 * @last modified on  : 08-07-2024
 * @last modified by  : Suraj Kumar
**/
trigger CaseTrigger on Case (after insert, after delete) {
    if(Trigger.isInsert && Trigger.isAfter){
        CaseTriggerHandler.setLatestCase(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isDelete){
        CaseTriggerHandler.createTask(Trigger.old);
    }

}