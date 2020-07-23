public with sharing class CloseCasesScheduler implements Schedulable {


    public void execute(SchedulableContext ctx) {

        Database.executeBatch(new CloseCasesBatch());

    }
}