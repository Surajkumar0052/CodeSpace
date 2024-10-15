trigger OrderTrigger on Order_Id__c (before insert, before update) {
    List<Order_Id__c> orderIdToBeUpdated = new List<Order_Id__c>();
    if(Trigger.isBefore && Trigger.isInsert){
        OrderHandler.relateONumOId(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
       for(Order_Id__c orderId : Trigger.new){
           if(orderId.Order_Id__c != Trigger.oldMap.get(orderId.id).Order_Id__c){
               orderIdToBeUpdated.add(orderId);
           }
       }
       if(!orderIdToBeUpdated.isEmpty()){
           OrderHandler.relateONumOId(orderIdToBeUpdated);
       }

    }
    
}