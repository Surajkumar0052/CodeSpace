public class ContactTriggerHandler {
    
    public static void restrictCreation(List<Contact> contactList){
        Set<Id> accountIds = new Set<Id>();
        Map<Id, List<Contact>> accToContactMap = new Map<Id, LIst<Contact>>();
        
        for(Contact con : contactList){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
        
        for(Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId IN : accountIds]){
            if(!accToContactMap.containsKey(con.AccountId)){
                accToContactMap.put(con.AccountId, new List<Contact>{con});
            }
            else{
                accToContactMap.get(con.AccountId).add(con);
            }
        }
        
        System.debug('accToContactMap --> ' + accToContactMap);
        
        for(Contact con : contactList){
            if(accToContactMap.containsKey(con.AccountId)){
                if(accToContactMap.get(con.AccountId).size() >= 2){
                    con.addError('There are already 2 contacts created for the relevant account !!!');
                }
            }
        }
    }
    
    public static void preventDuplicates(List<Contact> contactList){
        Set<String> emailSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        Map<String, String> accToContactMap = new Map<String, String>();
        
        for(Contact con : contactList){
            if(String.isNotBlank(con.Email) && con.Phone != null){
                emailSet.add(con.Email);
                phoneSet.add(con.Phone);
            }
        }
        
        for(Contact con : [SELECT Id, Email, Phone FROM Contact WHERE Email IN : emailSet AND Phone IN : phoneSet]){
            String emailPhone = con.Email + '-' + con.Phone;
            
            if(!accToContactMap.containsKey(emailPhone)){
                accToContactMap.put(emailPhone, con.Id);
            }
            
        }
        
        System.debug('accToContactMap --> ' + accToContactMap);
        
        for(Contact con : contactList){
            String emailPhone = con.Email + '-' + con.Phone;
            if(String.isNotBlank(con.Email) && con.Phone != null){
                if(accToContactMap.containsKey(emailPhone)){
                    con.addError('There is already an existing contact having the same contact details!!!');
                }
            }
        }
    }

}