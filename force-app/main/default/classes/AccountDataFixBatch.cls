/**
 * Created by Manlik on 25.06.2020.
 */

global class AccountDataFixBatch implements Database.Batchable<sObject> {
    global Integer recordsProcessed = 0;
    private String query;

    public AccountDataFixBatch(String country) {
        country = String.isNotBlank(country) ? country : 'USA';
        this.query = 'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
                'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
                'MailingState, MailingPostalCode FROM Contacts) ' +
                ' FROM Account ' +
                ' Where BillingCountry = \''  + country + '\'';
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                this.query
        );
    }


    global void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }

    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                JobItemsProcessed,
                TotalJobItems, CreatedBy.Email
        FROM AsyncApexJob
        WHERE Id = :bc.getJobId()];
        EmailManager.sendMail('email@m.com', 'test job', 'TEST');
    }

}