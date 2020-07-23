public with sharing class LessonSendPdfExtension {

    public Lesson__c lesson { get; set; }
    public String email {get; set;}

    public LessonSendPdfExtension(ApexPages.StandardController stdController) {
        this.lesson = (Lesson__c) stdController.getRecord();

        this.lesson = [
                SELECT Id, Name, StartDateTime__c, EndDateTime__c, Course__c, Teacher__c
                FROM Lesson__c
                WHERE Id = :this.lesson.Id
                LIMIT 1
        ];
    }

    public PageReference sendEmail() {
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{email});
        mail.setPlainTextBody('Test message');

        PageReference pagePDF = Page.LessonAttendeePdf;
        pagePDF.getParameters().put('id', lesson.Id);

        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.FileName = 'Test.pdf';
        attachment.ContentType = 'application/pdf';
        attachment.Body = Test.isRunningTest()
                ? Blob.valueOf('Test Blob String')
                : pagePDF.getContentAsPDF();
        mail.setFileAttachments(new List<Messaging.EmailFileAttachment>{attachment});

        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);

        return null;
    }
}