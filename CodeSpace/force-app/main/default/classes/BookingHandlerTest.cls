// previous month => next 1 month booking records => per room 100+ booking 400+ booking.

@isTest
public class BookingHandlerTest {
	@testSetup static void testData(){
        Room__c roomData = new Room__c();
        roomData.Check_In_Check_Out_Time__c = 'Adjustable';
        roomData.Booking_Amount__c = 1200;
        insert roomData;
        
        Contact conData = new Contact();
        conData.lastName = 'Tiwari';
        
        Booking__c bookingData = new Booking__c();
        bookingData.Amount_Paid__c = 1200;
        bookingData.Start_Date__c = System.today() + 3;
        bookingData.End_Date__c = System.today() + 4;
        Time checkInTime = Time.newInstance(14, 0, 0, 0); 
        bookingData.Check_in_Time__c = checkInTime;
        Time checkOutTime = Time.newInstance(13, 0, 0, 0); 
        bookingData.Check_out_Time__c = checkOutTime;
        bookingData.Room__c = roomData.Id;
        bookingData.Customer__c = conData.Id;
        insert bookingData;
        
    }
    @isTest
    public static void testMethod1(){
        BookingHandler bookings = new BookingHandler();
        List<Booking__c> bookingList = [SELECT Id, Amount_Paid__c, Start_Date__c, End_Date__c, Check_in_Time__c, Customer__c, Check_out_Time__c, Room__c FROM Booking__c  ];
        bookings.onBeforeInsert(bookingList);
        
        Map<Id, Booking__c> oldBookingMap = new Map<Id, Booking__c>();
        
        
        bookings.onBeforeUpdate(bookingList, oldBookingMap);
    }
    
    
}