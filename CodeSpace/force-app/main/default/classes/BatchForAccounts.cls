global class BatchForAccounts implements Database.Batchable<SObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, LastName, FirstName, Name, AccountId From Contact WHERE AccountId =Null';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> scope){
        Map<Id, Account> accountToMap = new Map<Id, Account>(); 

        for(Contact con : scope){
            Account acc = new Account();
            acc.Name = con.FirstName + ' ' + con.LastName;
            accountToMap.put(con.Id, acc);
        }
  
        insert accountToMap.values();
        System.debug('Account created : ' + accountToMap.values());
                
        for(Contact con : scope){
            con.AccountId = accountToMap.get(con.Id).Id;
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, JobType FROM AsyncApexJob WHERE Id =: bc.getJobId()];
        System.debug('Status of current job : ' + job.Status);
    }
}