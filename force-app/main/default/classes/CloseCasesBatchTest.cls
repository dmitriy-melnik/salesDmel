@IsTest
public with sharing class CloseCasesBatchTest {

    @IsTest
    static void testCloseCases() {
        Case case1 = new Case(
                Status = 'New'
        );

        Case case2 = new Case(
                Status = 'New'
        );

        insert new List<Case>{case1, case2};

        Test.startTest();

        CloseCasesBatch closeCasesBatch = new CloseCasesBatch();
        Id jobId = Database.executeBatch(closeCasesBatch);

        Test.stopTest();

        List<Case> cases = [SELECT Id FROM Case WHERE CreatedDate > LAST_N_DAYS:90];
        for (Case case_i : cases) {
            System.assertNotEquals('Closed', case_i.Status);
        }
    }
}