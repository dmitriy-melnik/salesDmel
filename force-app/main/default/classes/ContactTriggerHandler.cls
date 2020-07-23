public with sharing class ContactTriggerHandler {

    public static void handleBeforeDelete(List<Contact> contacts) {
        preventDelete(contacts);
    }

    public static void preventDelete(List<Contact> contacts) {

        for (Contact contact_i : [SELECT Id FROM Contact
                                    WHERE Id IN (SELECT ContactId FROM Case WHERE IsClosed = FALSE)
                                    AND Id IN :contacts]) {

            Trigger.oldMap.get(contact_i.Id).addError(Label.Contact_Delete_Error_Label);

        }

    }
}
//'Contact cannot be closed when a related Case is still open.'

/*
SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Contact)

SELECT Id FROM Case WHERE CreatedDate > LAST_N_DAYS:45 AND ContactId IN
(SELECT Id FROM Contact
WHERE FirstName != NUll
AND LastName != NULL
AND Birthdate != NULL)

after insert - // ! before insert
after update - // ! before update

trigger CaseTrigger on Case (before update) {
    for(Case case : Trigger.new) {
        if (Trigger.oldMap.get(case.Id).Status != Trigger.newMap.get(case.Id).Status) {
            //do some logic
        }
    }
}

I can compare that "Trigger.oldMap.get(case.Id).Status != Trigger.newMap.get(case.Id).Status". "case" from the loop "for(Case case : Trigger.new)"

With sharing - means that user sharing rules apply to the class. Without sharing do not attach user saring rules to the class.

Id, Name, Owner

LastName

--

Test.start() and Test.stop() are used for asynchronous apex. They help to ensure that all asynchronous transactions finished. So after Test.stop() you can use System.asserts.
 
before update, before insert - // ! after

Component event

true, false




 */