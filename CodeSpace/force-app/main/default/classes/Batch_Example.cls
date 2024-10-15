global class Batch_Example implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Name, Type FROM Opportunity';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> scope){
        for(Opportunity opp : scope){
            opp.type = 'New Customer';
        }
        update scope;
        System.debug('Sub Job : ' + bc.getChildJobId());
    }
    
    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, JobType FROM AsyncApexJob WHERE Id =: bc.getJobId()];
        System.debug('Status : ' + job.Status);
    }
}