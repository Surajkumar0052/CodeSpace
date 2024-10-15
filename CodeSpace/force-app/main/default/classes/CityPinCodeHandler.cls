/*Account , MsPincode - create and update
Account - pincode ( 110055 ) , City - New Delhi
MsPincode -> pincode ( 110055 ) -> city (New Delhi)

reverse Scenerio

Mspincode - record banaya / update
Ms pincode ka city jo update kiya woh account me apne app update ho jae */
public class CityPinCodeHandler {
    public static void getCityName(List<Account> accList){

        //Created map to store account data
        Map<Decimal, String> pinCodeMap= new Map<Decimal, String>();
        List <Account> accountList =  new List <Account>();
        for(Account acc : (List<Account>)Trigger.new){
            if(acc.Pincode__c != null){    
                pinCodeMap.put(acc.Pincode__c, null); // got pincodes of user entered data in map as key
                accountList.add(acc); // stored relevant account data in list so that we don't have to check condition again to iterate.
            }
            else{
                acc.City__c = ''; // city will be blank if pincode is not entered in account record
            }
        }
        
        if(pinCodeMap.isEmpty()){
            return;
        }
        
        for(Ms_Pincode__c pincode : [SELECT Id, Pincode__c, City__c FROM Ms_Pincode__c WHERE Pincode__c IN:pinCodeMap.keySet()]){
            pinCodeMap.put(pincode.Pincode__c,pincode.City__c); // got pincode and city of ms pincode in map
            // Now we have account's pincode data and MsPincode's pincode and city data
            
        }
        for(Account acc: accountList ){  // iterating on accountList to check if user entered pincode matches the pincode stored in map
            if(pinCodeMap.containsKey(acc.Pincode__c) ){
                acc.City__c = pinCodeMap.get(acc.Pincode__c);
            }
            else{
                acc.City__c = ''; 
            }
        }
    }
}