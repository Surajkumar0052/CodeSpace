public class OpportunityLineItemTriggerHandler {

    public static void countLineItems(List<OpportunityLineItem> lineItemsList){

        Set<Id> oppIds = new Set<Id>();
        for(OpportunityLineItem oplObj : lineItemsList){
            if (oplObj.OpportunityId != null) {
                oppIds.add(oplObj.OpportunityId);
            }
        }

        List<Account> accToUpdate = new List<Account>();

        for(Opportunity oppObj : [SELECT Id, AccountId, Account.Opportunity_Line_Items_Count__c, (SELECT Id, OpportunityId FROM OpportunityLineItems) FROM Opportunity WHERE Id IN : oppIds]){
            Account accObj = new Account();
            accObj.Id = oppObj.AccountId;
            accObj.Opportunity_Line_Items_Count__c = oppObj.OpportunityLineItems.size();
            accToUpdate.add(accObj);

        }
        System.debug('accToUpdate --> ' + accToUpdate);

        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }

    }

}