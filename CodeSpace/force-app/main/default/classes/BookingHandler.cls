public class BookingHandler {
    public void onBeforeInsert(List<Booking__c> newBookingList ){
        Set<Id> conIds = new Set<Id>();
        Set<Id> roomIds = new Set<Id>();
        for(Booking__c booking : newBookingList){
            if(booking.Customer__c != Null){
                conIds.add(booking.Customer__c);
            }
            else if(booking.Room__c != Null ){
                roomIds.add(booking.Room__c);
            }
        }
        Map<Id, Room__c> roomMap = new Map<Id, Room__c>([SELECT Id, Name, Booking_Amount__c, Maintenance_Mode__c, Check_In_Check_Out_Time__c, 
                                                         (SELECT Room__c, Name, Customer__c, Start_Date__c, End_Date__c, 
                                                          Check_in_Time__c, Check_out_Time__c, Amount_Paid__c, Check_in_Status__c FROM bookings__r) FROM Room__c WHERE Id IN: roomIds]); 
        
        List<Contact> conList = new List<Contact>([SELECT Id, Name, (SELECT Id, Name FROM Bookings__r) FROM Contact WHERE Id IN : conIds ]);
        Map<Id, Integer> countMap = new Map<Id, Integer>();
                
        for(Contact con : conList){
            Integer count = con.bookings__r.size();
            countMap.put(con.Id, count);
            System.debug('Bookings count on contact : ' + count);
        }
        
        
        for(Booking__c booking : newBookingList){
            Integer count = countMap.get(booking.Customer__c);
           
            if((booking.Amount_Paid__c !=Null)  && (booking.Amount_Paid__c != roomMap.get(booking.Room__c).Booking_Amount__c)){
                booking.Amount_Paid__c.addError('Paid Amount should be equal to Room booking amount' );
            }
            if(roomMap.get(booking.Room__c).Maintenance_Mode__c){
                booking.addError('Room is in maintenance mode');
            }
            
            if(booking.Start_Date__c != Null && booking.End_Date__c != Null){
                if(booking.Start_Date__c > booking.End_Date__c){
                    booking.Start_Date__c.addError('Start date can\'t be greater than end date');
                }
            }
            
            
            if((roomMap.get(booking.Room__c).bookings__r.size()) > 0){
                for(Booking__c oldbooking : roomMap.get(booking.Room__c).bookings__r){
                    if( (booking.Start_Date__c <= oldbooking.End_Date__c) &&
                       (booking.Check_in_Time__c <= oldbooking.Check_out_Time__c)) {
                           System.debug('Condition : ' + booking.Start_Date__c);
                           booking.addError('There is already a booking : ' + oldbooking.name +' till ' + oldbooking.End_Date__c + ' ' + oldbooking.Check_out_Time__c);
                           System.debug('Current Booking start date : ' + booking.Start_Date__c); 
                           
                       }
                    
                    if((oldbooking.Start_Date__c == booking.Start_Date__c)){
                   		
                        countMap.put(booking.id, count);
                        if(count>=2){
                            System.debug('Count : ' + count);
                            booking.Customer__c.addError('There are already 2 Bookings for this contact');
                        }
                        
                    }
                    
                }
            }

            if(roomMap.get(booking.Room__c).Check_In_Check_Out_Time__c == 'Standard'){
                Time checkInTime = Time.newInstance(11, 00, 00, 000);
                Time checkOutTime = Time.newInstance(12, 00, 00, 000);
                booking.Check_in_Time__c = checkInTime;
                booking.Check_out_Time__c = checkOutTime;
            }
   
        }
        
    }
    
    public void onBeforeUpdate(List<Booking__c> newbookings, Map<Id,Booking__c> oldBookings){
        List<Booking__c> bookingsToBeUpdated = new List<Booking__c>();
        for(Booking__c booking : newBookings){
            if((booking.Start_Date__c <> oldBookings.get(booking.id).Start_Date__c) ||
               (booking.End_Date__c <> oldBookings.get(booking.id).End_Date__c) ||
               (booking.Check_in_Time__c <> oldBookings.get(booking.id).Check_in_Time__c) || 
               (booking.Check_out_Time__c <> oldBookings.get(booking.id).Check_out_Time__c) ||
	       (booking.Amount_Paid__c <> oldBookings.get(booking.Id).Amount_Paid__c)){
                   bookingsToBeUpdated.add(booking);
               }
        }
        onBeforeInsert(bookingsToBeUpdated);
    }
        
}