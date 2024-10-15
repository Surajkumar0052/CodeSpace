@isTest
public class CalculatorTest {
    @isTest
    public static void CalculatorTest(){
        try{
            Calculator cal = new Calculator();
            cal.getSum(2, 3);
            cal.getSubtract(4, 2);
            cal.getMultiply(2, 2);
            cal.getDivision(5, 2);
            cal.getInstanceCount(); 
        }Catch(Exception ex){
            System.debug('Error :'+ex.getMessage());
        }
    }
    
}