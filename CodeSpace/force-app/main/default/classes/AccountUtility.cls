// We have a field on account which will be lookup to contact and will show contact which has high budget which is a 
// custom field in contact.
public class AccountUtility {
    public static void populateKeyContact(Set<Id> accIds){     
        
        List<Account> accList = new List<Account>();
        for(Account acc : [SELECT Id, Name, Key_Contact__c, (SELECT Id, Budget__c FROM Contacts ORDER BY Budget__c desc LIMIT 1)
                           FROM Account 
                           WHERE Id In: accIds]){
                               acc.Key_Contact__c = acc.Contacts[0].Id;
                               System.debug('Key COntact for ' + acc.Name + ' is : ' + acc.Key_Contact__c);
                               accList.add(acc);
                           }
        update accList;
        
    }
}