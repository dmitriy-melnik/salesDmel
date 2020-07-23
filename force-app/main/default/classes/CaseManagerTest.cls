@IsTest
public with sharing class CaseManagerTest {

    /*@TestSetup
    static void setupTestData() {
        Case caseTest = new Case(
                Subject='Test record',
                Status='New',
                Origin='Phone');
        insert caseTest;
    }*/

    @IsTest
    static void createCaseTest() {
        String existingEmail = '12345@email.com';
        String notExistingEmail = '1@email.com';
        Contact contact = new Contact(
                LastName = 'Test_name',
                Email = existingEmail
        );
        insert contact;

        Id thisCaseId = CaseManager.createCase('Watermelon', 'New', 'Phone', existingEmail);
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id, ContactId FROM Case WHERE Id = :thisCaseId];

        System.assertEquals(thisCase.ContactId, contact.Id);

        thisCaseId = CaseManager.createCase('Watermelon', 'New', 'Phone', notExistingEmail);
        System.assert(thisCaseId != null);
        thisCase = [SELECT Id, ContactId FROM Case WHERE Id = :thisCaseId];

        Contact unknownContact = [SELECT Id FROM Contact WHERE LastName = 'UNKNOWN' LIMIT 1];
        System.assertEquals(thisCase.ContactId, unknownContact.Id);

    }

    /*@isTest static void testGetCaseById() {
        List<Case> testCases = [SELECT Id, Subject FROM Case LIMIT 1];
        Id recordId = testCases[0].Id;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
                'https://yourInstance.salesforce.com/services/apexrest/Cases/'
                        + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Case thisCase = CaseManager.getCaseById();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals(testCases[0].Subject, thisCase.Subject);
    }*/
}