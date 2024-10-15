/**
 * @description       : 
 * @author            : Suraj Kumar
 * @group             : 
 * @last modified on  : 14-10-2024
 * @last modified by  : Suraj Kumar
**/
public class TaskHandler {
    public static void changeTaskOwner(List<Task> newTaskRecords){
        Set<Id> highPriorityTaskOwners = new Set<Id>();
        Set<Id> nonHighPriorityTaskOwners = new Set<Id>();
        Map<Id, Id> userIdToOwnerMap = new Map<Id, Id>();

        for(Task taskObj : newTaskRecords){
            if (taskObj.WhatId != null) {
                Schema.SObjectType sobjectType = taskObj.whatId.getSObjectType();
                String sobjectName = sobjectType.getDescribe().getName();
                if(taskObj.Priority != null && sobjectName == 'Account'){
                    if(taskObj.Priority == 'High'){
                        highPriorityTaskOwners.add(taskObj.OwnerId);
                    }
                    if(taskObj.Priority != 'High'){
                        nonHighPriorityTaskOwners.add(taskObj.OwnerId);
                    }
                }
            }
        }
        System.debug('highPriorityTaskOwners : ' + highPriorityTaskOwners);
        System.debug('nonHighPriorityTaskOwners : ' + nonHighPriorityTaskOwners);

        for(User userObj : [SELECT Id, isActive, ManagerId FROM User WHERE (Id IN : highPriorityTaskOwners OR ManagerId IN : nonHighPriorityTaskOwners)]){
            if(highPriorityTaskOwners.contains(userObj.Id)){
                if(!userIdToOwnerMap.containsKey(userObj.Id)){
                    userIdToOwnerMap.put(userObj.Id, userObj.ManagerId);
                }
            }
            if(nonHighPriorityTaskOwners.contains(userObj.ManagerId)){
                System.debug('User is Non priority task owner');
                if(!userIdToOwnerMap.containsKey(userObj.ManagerId)){
                    userIdToOwnerMap.put(userObj.ManagerId, userObj.Id);
                    System.debug('Non priority task owner added in map');
                }
            }
        }

        
        if(userIdToOwnerMap != null){
            System.debug('userIdToOwnerMap : ' + userIdToOwnerMap);
            for(Task taskObj : newTaskRecords){
                if(taskObj.Priority != null && taskObj.Priority == 'High'){
                    if(userIdToOwnerMap.containsKey(taskObj.OwnerId) && userIdToOwnerMap.get(taskObj.OwnerId) != null){
                        taskObj.OwnerId = userIdToOwnerMap.get(taskObj.OwnerId);
                    }
                }
                if(taskObj.Priority != null && taskObj.Priority != 'High'){
                    if(userIdToOwnerMap.containsKey(taskObj.OwnerId) && userIdToOwnerMap.get(taskObj.OwnerId) != null){
                        taskObj.OwnerId = userIdToOwnerMap.get(taskObj.OwnerId);
                    }
                }
            }
        }
    }
}