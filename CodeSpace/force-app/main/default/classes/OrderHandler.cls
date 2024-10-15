/*  We have 3 objects Order Number, Order Id and OrderIdAndOrderNumber, in OrderIdAndOrderNumber we will have order number 
and Order Id whenever in object Order Id is created, we have to search for corresponding Order Number in OrderIdAndOrderNumber
and make Order Id child of that Order Number*/

public class OrderHandler {
    public static void relateONumOId(List<Order_Id__c> orderIdList){
        List<String> IdList = new List<String>();  // to store order Id of Trigger.new records
        
        for(Order_Id__c orderId : orderIdList){
            if(orderId.Order_Id__c != Null ){
                IdList.add(orderId.Order_Id__c);
            }
        }
        if( IdList.isEmpty() ){
            return;
        }
        
        Map<String, String> idToNumMap = new Map<String, String>(); // map of id and number of object OrderIdAndOrderNumber
        for(Order_Number_and_ID__c numIdObj : [SELECT Order_Id__c, Order_Number__c FROM Order_Number_and_ID__c WHERE Order_Id__c IN : IdList]){
            idToNumMap.put(numIdObj.Order_Id__c, numIdObj.Order_Number__c);
        }
        
        Map<String, Id> oNumMap = new Map<String, Id>();  // map of Onum and its Id
        for(Order_Number__c oNumObj : [SELECT Id, Order_Number__c FROM Order_Number__c WHERE Order_Number__c In : idToNumMap.values()]){
            oNumMap.put(oNumObj.Order_Number__c, oNumObj.Id);
        }
        
        for(Order_Id__c orderId : orderIdList){
            if(idToNumMap.size()>0 && idToNumMap.containsKey(orderId.Order_Id__c)){
                if(oNumMap.size()>0 && oNumMap.containsKey(idToNumMap.get(orderId.Order_Id__c))){
                    orderId.Order_Number__c = oNumMap.get(idToNumMap.get(orderId.Order_Id__c));
                }
            }
        }
    }
}