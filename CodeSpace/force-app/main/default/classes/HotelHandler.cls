/* User Story:
A Hotel booking app has 3 objects :
1.Hotel: records of hotel with their name
2:Monthly Charges: it has a lookup to hotel object and contain the information of their per day charges of each month.
3:Booking: It is child object of Hotel and contains all the booking records having Hotel name, Checkin Date, Check Out Date & Total Amount.
Write a trigger for following Condition.
When the new booking is created having the details Hotel name, Checkin Date, Check Out Date. The Total Amount field should be auto calculated 
and filled. */

public class HotelHandler{
    
    /*public class Wrapper{
        Hotel__c hotelObj = new Hotel__c();
        List<Monthly_Charges__c> chargesList = new List<Monthly_Charges__c>();
        List<Booking__c> bookingList = new List<Booking__c>(); 
        
    }
    public static void main(){
        // map to store data of data types in wrapper class
        Map<Id, Wrapper> hotelDataMap = new Map<Id, Wrapper>();
        
        //checking if map contains hotel__c or not if not then put the booking data in map
        for(Booking__c booking : (List<Booking__c>)Trigger.new){
            if(!hotelDataMap.containsKey(booking.Hotel__c)){
                hotelDataMap.put(booking.Hotel__c, new Wrapper());
            }
            hotelDataMap.get(booking.Hotel__c).bookingList.add(booking);
        }
        
        // Getting hotel data which is present in booking  
        for(Hotel__c hotel : [SELECT ID, Name,(SELECT Charges_Per_Day__c, Month_Start_Date__c, Month_End_Date__c FROM Monthly_Charges__r )  FROM Hotel__c WHERE Id IN: hotelDataMap.keySet() ]){
            hotelDataMap.get(hotel.Id).hotelObj= hotel;       
        }
        
        for(Monthly_Charges__c charges : [SELECT Id, Hotel__c, Charges_Per_Day__c FROM Monthly_Charges__c WHERE Hotel__c IN: hotelDataMap.keySet()] ){
            hotelDataMap.get(charges.Hotel__c).chargesList.add(charges);
        } 
        
        
        for(Wrapper hotelData : hotelDataMap.values() ){
            for(booking__c bookingData : hotelData.bookingList){
                Map<String, Integer> numberOfDays = new Map<String, Integer>();
                if((bookingData.Check_in_Date__c !=null) && (bookingData.Check_out_Date__c !=null)){
                    if(bookingData.Check_in_Date__c.isSameDay(bookingData.Check_out_Date__c)){
                        numberOfDays.put(bookingData.Check_in_Date__c +'' + bookingData.Check_out_Date__c,1);
                    }
                }
            }
        }


        
        
    }*/
}