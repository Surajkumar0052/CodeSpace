/**
 * @description       : 
 * @author            : Suraj Kumar
 * @group             : 
 * @last modified on  : 08-07-2024
 * @last modified by  : Suraj Kumar
**/
public class CaseTriggerHandler {
    
    public static void setLatestCase(List<Case> caseList){
        Map<Id, STring> accToCaseNumberMap = new Map<Id, STring>();
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Case caseObj : caseList){
            if(caseObj.AccountId != null){
                accToCaseNumberMap.put(caseObj.AccountId, caseObj.CaseNumber);
            }
        }
        
        for(Account acc : [SELECT Id, Latest_Case_Inserted__c FROM Account WHERE ID IN : accToCaseNumberMap.keySet()]){
            if(accToCaseNumberMap.containsKey(acc.Id) && accToCaseNumberMap.get(acc.Id) != null){
                acc.Latest_Case_Inserted__c = accToCaseNumberMap.get(acc.Id);
                accountsToUpdate.add(acc);
            }
        }

        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }        
        
    }

    public static void createTask(List<Case> caseList){
        List<Task> taskRecordsToInsert = new List<Task>();
        for (Case caseObj : caseList) {
            if(caseObj.AccountId != null){
                if(caseObj.Account.Owner.isActive == true){
                    Task taskObj = new Task();
                    taskObj.Subject = 'Case is Closed';
                    taskObj.Status = 'In Progress';
                    taskObj.WhatId = caseObj.AccountId;
                    taskObj.ActivityDate = System.today();
                    taskObj.OwnerId = caseObj.Account.OwnerId;
                    taskRecordsToInsert.add(taskObj);
                }
            }
            else{
                System.debug('Account is not tagged.');
            }
        }

        if(!taskRecordsToInsert.isEmpty() && taskRecordsToInsert.size() > 0){
            insert taskRecordsToInsert;
        }
    }

}