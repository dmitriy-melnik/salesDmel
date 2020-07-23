trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete,
        after delete, after undelete) {

    if (Trigger.isAfter && Trigger.isInsert){
        AccountTriggerHandler.handleAfterInsert(Trigger.new);
    }


    /*if (Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.handleBeforeInsert(Trigger.new);
    }*/
//--------------------------------------------------------------------------
	/*System.debug('Hello, world!');
    
    if (Trigger.isBefore && Trigger.isInsert) {
        System.debug('before insert');
        
            for (Account acc_i : Trigger.new) {
           		acc_i.Description = 'New description';
        	}
    }*/
    
//--------------------------------------------------------------------------
    /*
    if (Trigger.isAfter && Trigger.isInsert) {
        System.debug('after insert');
        
        List<Task> taskToInsertList = new List<Task>();
        for (ID accId_i : Trigger.newMap.keySet()) {
            taskToInsertList.add(
            	new Task(
                    Subject = 'Test task' + Trigger.newMap.get(accId_i).Name, 
                    WhatId = accId_i
                )
            );
        }
        if(!taskToInsertList.isEmpty()) {
            insert taskToInsertList;
        }
    }*/
    
//--------------------------------------------------------------------------
    /*if (Trigger.isBefore && Trigger.isUpdate) {
        for (Account acc_i : Trigger.new) {
            if(acc_i.Phone != Trigger.oldMap.get(acc_i.Id).Phone) {
                acc_i.Description += ' Phone = ' + acc_i.Phone;
                acc_i.Description += String.isNotBlank(acc_i.Phone) ? acc_i.Phone : ' ';
            }
        }
    }*/
    
//--------------------------------------------------------------------------
   /* if (Trigger.isBefore && Trigger.isDelete) {
		// Prevent the deletion of accounts if they have related opportunities.
        for (Account account_i : [
            SELECT Id FROM Account
            WHERE Id IN (SELECT AccountId FROM Opportunity) 
            AND Id IN :Trigger.old
        ]) {
            Trigger.oldMap.get(account_i.Id).addError(
                'Cannot delete account with related opportunities.');
        }
    }*/
    
    
    
}