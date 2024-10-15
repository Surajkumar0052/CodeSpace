public class RentCarHandler {
    public static void calculateRentAmount(){
        Set<Id> carIds = new Set<Id>();
        for(Rent_Car__c rent : (List<Rent_Car__c>)Trigger.new){
            if(rent.Car__c != Null && rent.Payment_Mode__c != Null && rent.Rent_End_Date__c != Null && rent.Rent_Start_Date__c !=Null){
                carIds.add(rent.Car__c);
            }
        }
        
        Map<Id, Car__c> carMap = new Map<Id, Car__c>([SELECT Id, Name, Per_Day_Rent__c, Available_for_rent__c FROM Car__c WHERE Id IN : carIds]);
        
        for(Rent_Car__c rent : (List<Rent_Car__c>)Trigger.new){
            if(carMap.containsKey(rent.Car__c)){
                if(carMap.get(rent.Car__c).Available_for_rent__c == True){
                    Integer dayDiff = rent.Rent_End_Date__c.day() - rent.Rent_Start_Date__c.day();
                    rent.Rent_Amount__c = carMap.get(rent.Car__c).Per_Day_Rent__c * dayDiff;
                    carMap.get(rent.Car__c).Available_for_rent__c = False;
                    System.debug('Rent Amount : ' + rent.Rent_Amount__c); 
                    
                }
                else{
                    rent.Car__c.addError('Sorry, this car is not available for rent');
                }
                
            }
        }
        
    }
}