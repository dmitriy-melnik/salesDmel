@IsTest
public class TestVerifyDate {
    
    @IsTest
    public static void CheckDatesTest() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(40);
        
        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
        
        System.assertEquals(VerifyDate.CheckDates(date1, date2), lastDay);
        
        date2 = date1.addDays(5);
        
        System.assertEquals(VerifyDate.CheckDates(date1, date2), date2);
        
    }

}