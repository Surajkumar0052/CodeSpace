public class AccountTriggerHelper {
    
    public static void updateRelOpps(List<Account> accounts){
        System.debug('accounts --> ' + accounts);
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Opportunity opp : [SELECT Id, accountId, StageName, CreatedDate FROM Opportunity WHERE accountId IN : accounts]){
            System.debug('Opp stage bef : ' + opp.StageName);
            if((opp.createdDate < (System.today() - 30)) && (opp.StageName != 'Closed Won')){
                SYstem.debug('Opp added');
                opp.StageName = 'Closed Lost';
                oppList.add(opp);
            }
        }
        System.debug('oppList --> ' + oppList);
        
        if(!oppList.isEmpty()){
            System.debug('oppList --> ' + oppList);
            update oppList;
        }
        
    }
    
    public static void restrictAccDeletion(List<Account> accounts){
        
        for(Account acc : accounts){
            if(acc.isActive__c == true){
                acc.addError('You cannot delete an active account!!');
            }
        }
        
    }
    
}