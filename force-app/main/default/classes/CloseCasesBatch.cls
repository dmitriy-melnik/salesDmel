global class CloseCasesBatch implements Database.Batchable <SObject> {

    public static final String CLOSED = 'Closed';

    public Iterable<SObject> start(Database.BatchableContext bc) {
        String query = 'SELECT Id FROM Case WHERE CreatedDate < LAST_N_DAYS:90';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Case> scope) {

        for (Case case_i : scope) { 
            case_i.Status = CLOSED;
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {
        Id job = bc.getJobId();
        System.debug(job);
    }


}