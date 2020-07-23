@IsTest
public with sharing class CloseCasesSchedulerTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    @IsTest
    static void testScheduledJob() {
        List<Case> cases = new List<Case>{
                new Case(
                        Status = 'Open'
                ),
                new Case(
                        Status = 'Open'
                )
        };

        insert cases;

        Map<Id, Case> caseMap = new Map<Id, Case> (cases);
        List<Id> caseIds = new List<Id>(caseMap.keySet());

        Test.startTest();

        String jodId = System.schedule('CloseCaseTest', CRON_EXP, new CloseCasesScheduler());

        Test.stopTest();

        List<Task> lt = [SELECT Id FROM Task WHERE WhatId IN :caseIds];
        System.assertEquals(0, lt.size());
    }

}