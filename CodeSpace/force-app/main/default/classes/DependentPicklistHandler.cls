public class DependentPicklistHandler{
    
    public class MyPickListInfo{
        public String validFor;
    }
    
    @AuraEnabled(Cacheable=true)
    public static Region__c getRegion(String Id){
        if(String.isNotBlank(Id)){
            Region__c region = [SELECT Id, Regions__c, Zone__c FROM Region__c WHERE Id =: Id];
            return region;
        }
        else{
            return null;
        }
        
    }
    
    @AuraEnabled
    public static String updateRegionRecord(String Id, String regValue, String zoneValue){
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
    
    @AuraEnabled(Cacheable=true)
    public static Map<String, List<String>> getFieldDependencies(){
        
        Map<String, List<String>> controllingInfo = new Map<String, List<String>>();
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Region__c');
        
        Schema.DescribeSObjectResult describeResult = objType.getDescribe();
        
        Schema.DescribeFieldResult controllingFieldInfo = describeResult.fields.getMap().get('Regions__c').getDescribe();
        
        Schema.DescribeFieldResult dependentFieldInfo = describeResult.fields.getMap().get('Zone__c').getDescribe();
        
        List<Schema.PicklistEntry> controllingValues = controllingFieldInfo.getPicklistValues();
        List<Schema.PicklistEntry> dependentValues = dependentFieldInfo.getPicklistValues();
        
        System.debug('controllingValues : ' + controllingValues);
        System.debug('dependentValues : ' + dependentValues);
        
        
        for(Schema.PicklistEntry currControllingValue : controllingValues){
            System.debug('ControllingField: Label:' + currControllingValue.getLabel());
            controllingInfo.put(currControllingValue.getLabel(), new List<String>());
        }
        
        for(Schema.PicklistEntry currDependentValue : dependentValues){
            String jsonString = JSON.serialize(currDependentValue);
            System.debug('Field activity check : ' + currDependentValue.isActive());
            
            MyPickListInfo info = (MyPickListInfo) JSON.deserialize(jsonString, MyPickListInfo.class);
            System.debug('info : ' + info);
            
            String hexString = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();
            
            System.debug('DependentField: Label:' + currDependentValue.getLabel() + ' ValidForInHex:' + hexString + ' JsonString:' + jsonString);
            
            Integer baseCount = 0;
            
            for(Integer curr : hexString.getChars()){
                Integer val = 0;
                
                if(curr >= 65){
                    val = curr - 65 + 10;
                }
                else{
                    val = curr - 48;
                }
                
                if((val & 8) == 8){
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 0].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 0].getLabel()).add(currDependentValue.getLabel());
                }
                if((val & 4) == 4){
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 1].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 1].getLabel()).add(currDependentValue.getLabel());                    
                }
                if((val & 2) == 2){
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 2].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 2].getLabel()).add(currDependentValue.getLabel());                    
                }
                if((val & 1) == 1){
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 3].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 3].getLabel()).add(currDependentValue.getLabel());                    
                }
                baseCount += 4;
            }            
        } 
        
        System.debug('ControllingInfo: ' + controllingInfo);
        
        return controllingInfo;
    }
}