public with sharing class AccountTriggerHandler {

    public static void handleAfterInsert(List<Account> newList) {
        //insertTasks(newList);

        List<Id> accIds = new List<Id>();
        for(Account account_i : newList) {
            accIds.add(account_i.Id);
        }
        createGuidId(accIds);

    }

    @future(callout=true)
    private static void createGuidId(List<Id> listAccountIds) {

        List<Account> newList = [SELECT Id FROM Account WHERE Id IN :listAccountIds];
        List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>();

        for(Account account_i : newList) {

            HttpResponse response = GuidHttpCallout.getGuidId() ;
            if (response.getStatusCode() == 200) {   
                    String guidId = response.getBody();
                    account_i.GUID_ID__c = guidId;
            } else {
                emailsList.add(generateEmail(account_i));
                //EmailManager.sendMail('melnik.dm.s@gmail.com', '','Something went wrong');
            }
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emailsList);
        update newList;

    }

    private static Messaging.SingleEmailMessage generateEmail(Account account) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'melnik.dm.s@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Error');
        mail.setPlainTextBody('Something went wrong');
        return mail;
    }


//-------------------------------------------------------------------------
	/*@TestVisible
    private static final String DEFAULT_DESCRIPTION = 'New description';
    
    public static void handleBeforeInsert(List<Account> newList){
        specifyDescription(newList);
    }
    
    private static void specifyDescription(List<Account> newList) {
        for (Account account_i : newList) {
            account_i.Description = DEFAULT_DESCRIPTION;
        }
    }*/
    
//-------------------------------------------------------------------------

    
    /*private static void insertTasks(List<Account> newList) {
        
        List<Task> taskToInsertList = new List<Task>();
        for (Account acc_i : newList) {
            taskToInsertList.add(
            	new Task(
                    Subject = 'Test task' + acc_i.Name, 
                    WhatId = acc_i.id
                )
            );
        }
        if(!taskToInsertList.isEmpty()) {
            insert taskToInsertList;
        }
    }*/
    
//-------------------------------------------------------------------------
	
    
}