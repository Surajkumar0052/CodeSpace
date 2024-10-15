public class PatientNumber {
    
    public static void PatienttaskTrigger(){
        
        Map<String, Id> patientDataMap = new Map<String, Id>();
        
        for(billing_summary__c bill : (List<billing_summary__c>)Trigger.new ){
            if(String.isNotBlank(bill.Patient_Number__c) ){
                patientDataMap.put(bill.Patient_Number__c, NULL);
            }
        }
        if(patientDataMap.size()>0){
            for(Patient__c patient :[SELECT Patient_number__c, Id FROM patient__c WHERE Patient_number__c IN:patientDataMap.keyset() ] ){
                patientDataMap.put(patient.Patient_number__c, patient.Id);                    
            }   
        }       
        for(billing_summary__c billObj : (List<billing_summary__c>)Trigger.new){
            if(patientDataMap.containsKey(billObj.Patient_number__c) && !patientDataMap.isEmpty()){
                billObj.Patient__c = patientDataMap.get(billObj.Patient_Number__c);
            }            
        }          
    }        
}