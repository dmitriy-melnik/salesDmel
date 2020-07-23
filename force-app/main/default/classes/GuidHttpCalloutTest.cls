@IsTest
public with sharing class GuidHttpCalloutTest {

    @IsTest
    static void getGuidIdTest() {
        Test.setMock(HttpCalloutMock.class, new GuidIdHttpCalloutMock());
        HttpResponse response = GuidHttpCallout.getGuidId();
        String actualValue = response.getBody();
        String expectedValue = 'd21a3046-bbc2-11ea-b3de-0242ac130004';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
}