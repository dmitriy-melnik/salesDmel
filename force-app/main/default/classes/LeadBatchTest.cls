@IsTest
public class LeadBatchTest {

    private static final String LEAD_SOURCE = 'Web';

    @IsTest
    static void testLead(){
        Lead lead1 = new Lead(  
                LastName = 'ivnchenko',
                Company = 'Company111',
                Status='Closed-Converted'
        );
        Lead lead2 = new Lead(
                LastName = 'petrenko',
                Company = 'Company111',
                Status='Closed-Converted'
        );
        insert new List<Lead>{lead1, lead2};

        Test.startTest();
        LeadBatch lp = new LeadBatch(LEAD_SOURCE);
        Id jobId= Database.executeBatch(lp);
        Test.stopTest();

        List<Lead> leadList = [SELECT Id, LeadSource FROM Lead WHERE CreatedDate > :System.today().addMonths(-3)];
        for (Lead lead_i : leadList) {
            System.assertEquals(LEAD_SOURCE, lead_i.LeadSource);
        }
    }
}