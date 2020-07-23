@IsTest
private class OpportunityTriggerHandlerTest {

    @TestSetup
    static void setupTestData() {
        Test.setMock(HttpCalloutMock.class, new GuidIdHttpCalloutMock());
        Account testAccount = new Account(
                Name = 'Test Account'
        );

        Test.startTest();
        insert testAccount;
        Test.stopTest();
    }

    @IsTest
    static void createTasksTest() {
        Opportunity opportunity = new Opportunity(
                StageName = 'Closed Won',
                CloseDate = Date.newInstance(3100, 3, 3),
                Name = 'firstOpportunity'
        );
        insert opportunity;

        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :opportunity.Id];
        for (Task t : tasks) {
            System.assertEquals(OpportunityTriggerHandler.TASK_SUBJECT, t.Subject);
        }
    }

    @IsTest
    static void countNumberOfOpportunitiesTest() {
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        Opportunity firstTestOpportunity = new Opportunity(
                Name = 'Test',
                AccountId = testAccount.Id,
                CloseDate = Date.newInstance(2021, 2, 17),
                StageName = 'Test'

        );
        insert firstTestOpportunity;

        testAccount = [SELECT Id, Count_Of_Opportunities__c, (SELECT Id FROM Opportunities) FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(testAccount.Opportunities.size(), testAccount.Count_Of_Opportunities__c);

        Opportunity secondTestOpportunity = new Opportunity(
                Name = 'Test',
                AccountId = testAccount.Id,
                CloseDate = Date.newInstance(2022, 2, 17),
                StageName = 'Test'
        );
        insert secondTestOpportunity;

        testAccount = [SELECT Id, Count_Of_Opportunities__c, (SELECT Id FROM Opportunities) FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(testAccount.Opportunities.size(), testAccount.Count_Of_Opportunities__c);

        delete firstTestOpportunity;

        testAccount = [SELECT Id, Count_Of_Opportunities__c, (SELECT Id FROM Opportunities) FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(testAccount.Opportunities.size(), testAccount.Count_Of_Opportunities__c);

        undelete firstTestOpportunity;

        testAccount = [SELECT Id, Count_Of_Opportunities__c, (SELECT Id FROM Opportunities) FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(testAccount.Opportunities.size(), testAccount.Count_Of_Opportunities__c);
    }
}