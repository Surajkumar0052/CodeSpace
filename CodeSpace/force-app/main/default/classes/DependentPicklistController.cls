public with sharing class DependentPicklistController {
	private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    
    
    @AuraEnabled
    public static Region__c getRegionRecord(String Id){
        if(String.isNotBlank(Id)){
            Region__c region = [SELECT Id, Regions__c, Zone__c FROM Region__c WHERE Id =: Id];
            return region; 
        }
        else{
            return null;
        }
    }
    
    @AuraEnabled
    public static String updateRecord(String Id, String regValue, String zoneValue){
        if(String.isNotBlank(Id) && String.isNotBlank(regValue) && String.isNotBlank(zoneValue)){
            Region__c region = new Region__c(Id = Id, Regions__c = regValue, Zone__c = zoneValue);
            System.debug('region : ' + region);
            upsert region;
            return 'success';
        }
        else{
            return 'error';
        }
        
        
    }
    
    @AuraEnabled 
    public static PicklistWrapper getDependentPicklist() {
        Map<String,List<String>> pickListMap = new Map<String,List<String>>();
        PicklistWrapper pw = new PicklistWrapper();
        pw.pickListMap = pickListMap;
        
        if (Schema.getGlobalDescribe().get('Region__c') ==null || String.isBlank('Regions__c') || String.isBlank('Zone__c')){
            return pw;
        }
 
        Schema.sObjectType objType = Schema.getGlobalDescribe().get('Region__c').newSObject().getSObjectType();
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey('Regions__c') || !objFieldMap.containsKey('Zone__c')){
            return pw;     
        }
        
        List<PicklistEntryWrapper> depEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objFieldMap.get('Zone__c').getDescribe().getPicklistValues()), List<PicklistEntryWrapper>.class);
        List<String> controllingValues = new List<String>();
        
        for (Schema.PicklistEntry ple : objFieldMap.get('Regions__c').getDescribe().getPicklistValues()) {
            pickListMap.put(ple.getLabel(), new List<String>());
            controllingValues.add(ple.getLabel());
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    pickListMap.get(controllingValues.get(i)).add(plew.label);
                }
            }
        }
        
        pw.pickListMap = pickListMap;

        System.debug('pickListMap : ' + pickListMap);
        return pw;
    }
    
    //Refer from here https://salesforce.stackexchange.com/questions/4462/get-lists-of-dependent-picklist-options-in-apex
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';
        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        
        return validForBits;
    }
    
    public class PicklistWrapper{
    	@AuraEnabled
        public Map<String, List<String>> pickListMap;
           
    }
        
    public class PicklistEntryWrapper{
        public String active;
        public String defaultValue;
        public String label;
        public String value;
        public String validFor;
        
    }
}