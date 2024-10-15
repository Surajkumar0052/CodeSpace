public with sharing class CarSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Car_Type__c> getCarTypes(){
        try {
            System.debug('Data : ' + [SELECT Id, Name FROM Car_Type__c]);
            return [SELECT Id, Name FROM Car_Type__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Car__c> getCars(String carTypeId){
        try {
            if(String.isEmpty(carTypeId)){
                System.debug('if id is available : ' + [SELECT Id, Name, Available_For_Rent__c, Build_Year__c, Car_Type__c, Picture__c, Geolocation__Latitude__s,
                                                        Geolocation__Longitude__s, contact__r.Name  FROM Car__c WHERE Available_For_Rent__c = true]);
                return [SELECT Id, Name, Available_For_Rent__c, Build_Year__c, Car_Type__c, Picture__c, Geolocation__Latitude__s,
                        Geolocation__Longitude__s, contact__r.Name FROM Car__c WHERE Available_For_Rent__c = true];
                
            }
            else{
                System.debug('if id is available : ' + [SELECT Id, Name, Available_For_Rent__c, Build_Year__c, Car_Type__c, Picture__c, Geolocation__Latitude__s,
                                                        Geolocation__Longitude__s, contact__r.Name  FROM Car__c WHERE Available_For_Rent__c = true AND Car_Type__c =: carTypeId]);
                return [SELECT Id, Name, Available_For_Rent__c, Build_Year__c, Car_Type__c, Picture__c, Geolocation__Latitude__s,
                        Geolocation__Longitude__s, contact__r.Name  FROM Car__c WHERE Available_For_Rent__c = true AND Car_Type__c =: carTypeId];
                
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Car_Experience__c> getReviews(String carId){
        return [SELECT Name, Experience__c, LastModifiedDate, CreatedDate, CreatedBy.Name, CreatedBy.SmallPhotoUrl, CreatedBy.CompanyName
                FROM Car_Experience__c
                WHERE Car__c  = :carId
                ORDER BY CreatedDate DESC];
    }
    
    @AuraEnabled(cacheable=true)
    public static String checkAvailability(String Id){
        Car__c car = [SELECT Id, Name, Available_For_Rent__c FROM Car__c WHERE Id =: Id];
        if (car.Available_For_Rent__c == True) {
            return 'true';
        }
        else{
            return 'false';
        }
    }
    
}