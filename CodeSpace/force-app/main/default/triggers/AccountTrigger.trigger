trigger AccountTrigger on Account (before insert, before update, before delete) {
    AccountTriggerDispatcher.dispatchTrigger(Trigger.OperationType);

}