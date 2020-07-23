global class ContactBirthdayScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Contact> contacts = [
                SELECT Id, Email, LastName
                FROM Contact
                WHERE Birthdate = TODAY
        ];

        if (!contacts.isEmpty()) {
            List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>();
            for(Contact contact : contacts) {
                if(contact.Email != null) {
                    emailsList.add(
                            generateEmail(contact)
                    );
                }
            }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailsList);
        }
    }

    private Messaging.SingleEmailMessage generateEmail(Contact contact) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {contact.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Happy birthday');
        mail.setPlainTextBody(contact.LastName);
        return mail;
    }

}

/*
ContactBirthdayScheduler c = new ContactBirthdayScheduler();

String sch = '0 0 9 1/1 * ? *';
String jodId = System.schedule('Contact Birthday', sch, c);*/