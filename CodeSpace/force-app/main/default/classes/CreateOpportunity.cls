// Whenever a new account is created with rating as hot, create a new opportunity name as account name, stageName as prospecting,
// close date as 15 days from today and type as new customer.

public class CreateOpportunity {
    public static void create(List<Account> accounts){
        // Creating a list of opportunity
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account a : accounts){
            if(a.rating == 'Hot'){
                Opportunity opp = new Opportunity();
                opp.Name = a.Name;
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today() + 15;
                opp.Type = 'New Customer';
                opp.AccountId = a.Id;
                oppList.add(opp);
                
            }
        }
        // we have written insert dml after for loop because we have limit of 150 dmls in a transaction, just to bulkify
        insert oppList;
    }
}