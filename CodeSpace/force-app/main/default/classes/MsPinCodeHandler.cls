public class MsPinCodeHandler {
    public static void cityUpdate(){
        Map<Decimal, String> msPinCodeDataMap = new Map<Decimal, String>();
        for(Ms_Pincode__c pincode : (List<Ms_Pincode__c>)Trigger.new ){
            if((Trigger.isInsert) || (Trigger.isUpdate && pincode.City__c <>((map<id,Ms_Pincode__c>) Trigger.OldMap).get(pincode.id).City__c )){
                msPinCodeDataMap.put(pincode.Pincode__c , pincode.City__c);
            }
            else if(Trigger.IsUpdate && (pincode.Pincode__c == null)){
                msPinCodeDataMap.put(null,null);
            }
        }
        if(msPinCodeDataMap.isEmpty()){
            return;
        }
        
        List<Account> updateAccounts = new List<Account>();
        for(Account acc : [SELECT Id, Pincode__c, City__c FROM Account WHERE Pincode__c IN: msPinCodeDataMap.keySet()]){
            acc.City__c=msPinCodeDataMap.get(acc.Pincode__c);
            updateAccounts.add(acc);
        }
        update updateAccounts; 
        
        
        
    }
}