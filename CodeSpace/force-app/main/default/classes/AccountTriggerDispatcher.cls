public class AccountTriggerDispatcher {
    // Trigger.OperationType gives us trigger context as AFTER_INSERT, AFTER_UPDATE
    // System.TriggerOperation =~ Trigger.OperationType
    
    public static void dispatchTrigger(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                AccountTriggerHandler.handleBeforeInsert(Trigger.new);
            }
            WHEN BEFORE_UPDATE{
                AccountTriggerHandler.handleBeforeUpdate(Trigger.new);
            }
            WHEN BEFORE_DELETE{
                AccountTriggerHandler.handleBeforeDelete(Trigger.new);
            }
            WHEN AFTER_INSERT{
                AccountTriggerHandler.handleAfterInsert(Trigger.new);
            }
            WHEN AFTER_UPDATE{
                AccountTriggerHandler.handleAfterUpdate(Trigger.new);
            }
            WHEN AFTER_DELETE{
                AccountTriggerHandler.handleAfterDelete(Trigger.new);
            }
            
        }
    }

}