@IsTest
private class ContactTriggerHandlerTest {

    @IsTest
    static void preventDeleteTest() {
        Contact contact = new Contact(
                LastName = 'Pechckin'
        );
        insert contact;

        List<Case> caseList = new List<Case>{
                new Case(Status = 'Working', ContactId = contact.Id),
                new Case(Status = 'Working', ContactId = contact.Id)
        };
        insert caseList; 

        try {
            delete contact;
            System.assert(false, 'Exception was expected');
        } catch (Exception ex) {
            System.assert(ex.getMessage().containsIgnoreCase(Label.Contact_Delete_Error_Label));
        }

    }
}