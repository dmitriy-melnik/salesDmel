@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
	
    @IsTest 
    public static void testWareHouseCallout(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
    }
}