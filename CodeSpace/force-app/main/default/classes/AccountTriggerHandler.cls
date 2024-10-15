public class AccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> accounts){
        
    }
    
    public static void handleBeforeUpdate(List<Account> accounts){
        AccountTriggerHelper.updateRelOpps(accounts);
    }
    
    public static void handleBeforeDelete(List<Account> accounts){
        AccountTriggerHelper.restrictAccDeletion(accounts);
    }
    
    public static void handleAfterInsert(List<Account> accounts){
        
    }
    
    public static void handleAfterUpdate(List<Account> accounts){
        
    }
    
    public static void handleAfterDelete(List<Account> accounts){
        
    }
    
}