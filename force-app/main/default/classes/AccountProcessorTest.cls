@IsTest
public class AccountProcessorTest {
    @IsTest
    private static void testCountContacts(){
        Account acc = new Account(Name = 'TestAcc2');
        insert acc;

        Contact con = new Contact(LastName = 'TestCont2', AccountId = acc.Id);
        insert con;

        List<Id> lstOfAccIds = new List<Id>();
        lstOfAccIds.add(acc.Id);

        Test.startTest();
        AccountProcessor.countContacts(lstOfAccIds);
        Test.stopTest();

        Account a = [select Number_of_Contacts__c from Account where id = :acc.id LIMIT 1];
        System.assertEquals ( Integer.valueOf(a.Number_of_Contacts__c) ,1);
    }
}