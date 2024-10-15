public class OpportunitiesInAccounts {
    public static void OpportunityHandler(List<Opportunity> opps){
        Set<Id> oppIds = new Set<Id>();
        for(Opportunity o : opps){
            oppIds.add(o.AccountId);
        }
        
        List<Account> acc = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id IN : oppIds];
        Map<Id,Integer> accMaps = new Map<Id, Integer>();
        
        for(Account a : acc){
            Integer count = a.opportunities.size();
            accMaps.put(a.Id, count);
            
        }
        
        for(Opportunity opp : opps){
            Integer count = accMaps.get(opp.AccountId);
            if(count>=5){
                opp.addError('You cannot have more than 5 opportunities on an account');
            }
        }
    }
}