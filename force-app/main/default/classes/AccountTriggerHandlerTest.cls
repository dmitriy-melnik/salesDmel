@IsTest
private class AccountTriggerHandlerTest {

    @IsTest
    static void createGuidIdTest() {

        Test.setMock(HttpCalloutMock.class, new GuidIdHttpCalloutMock());
        Account testAccount = new Account(
                Name = 'Test'
        );

        Test.startTest();
        insert testAccount;
        Test.stopTest();

        List<Account> accounts = [SELECT Id, GUID_ID__c FROM Account LIMIT 1];
        Integer invocations = Limits.getEmailInvocations();

        if(accounts[0].GUID_ID__c != null) {
            System.assertEquals(accounts[0].GUID_ID__c, GuidIdHttpCalloutMock.guidId);
            System.assertEquals(0, invocations);
        }
    }

    /*@isTest
    static void specifyDescriptionTest() {
        
    	Account testAccount = new Account(
            Name = 'Test'
        );
        
        insert testAccount;
        
        testAccount = [SELECT Id, Description FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(AccountTriggerHandler.DEFAULT_DESCRIPTION, testAccount.Description);
    }
    
    
    @isTest
    static void insertTasksTest() {
        Account testAccount = new Account(
            Name = 'TestAcc'
        );
        
        insert testAccount;
        
        List<Task> taskList = [SELECT Id FROM Task WHERE WhatId = :testAccount.Id];
        System.assert(!taskList.isEmpty());
        
    }*/


}