global class LeadBatch implements Database.Batchable <SObject> {

    private String leadSource;
    public LeadBatch(String str) {
        leadSource = str;
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id,LeadSource FROM Lead WHERE CreatedDate > LAST_N_MONTHS:3';
        return Database.getQueryLocator(query);
    }
 
    //Lead l = [SELECT Id,LeadSource FROM Lead WHERE CreatedDate > :System.today().addMonths(-3)];

    global void execute(Database.BatchableContext bc, List<Lead> scope) {

        for (Lead l : scope) {
            l.LeadSource = leadSource;
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        Id job = bc.getJobId();
        System.debug(job);
    }
}