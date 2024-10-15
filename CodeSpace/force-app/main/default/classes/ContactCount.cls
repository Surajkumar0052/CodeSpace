public class ContactCount {
    public static void getContactCount(List<Contact> conList){
       
        Set<Id> accIds = new Set<Id>();
        for(Contact con : conList){
            if(con.AccountId != null){
               accIds.add(con.AccountId); 
            }     
        }
        List<Account> accList = new List<Account>();
		for(Account acc : [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account 
                           WHERE Id In : accIds]){
            acc.Number_of_Contact__c = acc.contacts.size();
            accList.add(acc);          
        }
        update accList;
  
    }
}