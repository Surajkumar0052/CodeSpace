/**
 * @description       : 
 * @author            : Suraj Kumar
 * @group             : 
 * @last modified on  : 14-10-2024
 * @last modified by  : Suraj Kumar
**/
trigger TaskTrigger on Task (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        TaskHandler.changeTaskOwner(Trigger.new);
    }
}