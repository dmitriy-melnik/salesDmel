@IsTest
public class WarehouseSyncScheduleTest {
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @IsTest
    public static void testJob() {
        
        MaintenanceRequestTest.CreateData( 5,2,2,'Repair');
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String jobId = System.schedule('TestScheduleJob', CRON_EXP, new WarehouseSyncSchedule());
        
        System.assertNotEquals(null, jobId);
        
        Test.stopTest();
    }
}