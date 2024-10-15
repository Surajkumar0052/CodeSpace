public with sharing class Hello {
    public static void getData(){
        Date d = System.today();
        Integer month = d.month();
        Integer days = month;
        System.debug('Days : ' + days);
    }
}