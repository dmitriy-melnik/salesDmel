@IsTest
public class ContactBirthdaySchedulerTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @IsTest
    static void testScheduledJob() {

        List<Contact> contacts = new List<Contact>{
                new Contact(
                        LastName = 'FirstContact',
                        Birthdate = Date.today()
                ),
                new Contact(
                        LastName = 'SecondContact',
                        Birthdate = Date.today()
                )
        };

        insert contacts;

        Map<Id, Contact> contactMap = new Map<Id, Contact> (contacts);
        List<Id> conIds = new List<Id>(contactMap.keySet());

        Test.startTest();
        // Schedule the test job
        String jodId = System.schedule('ContactBirthdayTest', CRON_EXP, new ContactBirthdayScheduler());

        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id FROM Task WHERE WhatId IN :conIds];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');

        Test.stopTest();

        lt = [SELECT Id FROM Task WHERE WhatId IN :conIds];
        System.assertEquals(conIds.size(), lt.size(), 'Task were not created');

    }
}