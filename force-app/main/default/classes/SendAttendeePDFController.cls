public class SendAttendeePDFController {
    
    @AuraEnabled
    public static void sendPDFByEmail(Id lessonId, String email) {
        Lesson__c lesson = [SELECT Id, Name FROM Lesson__c WHERE Id = :lessonId];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{email});
        mail.setPlainTextBody('Test message');
          
        PageReference pagePDF = Page.LessonExamplePdf; 
        pagePDF.getParameters().put('id', lessonId);  
        
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.FileName = lesson.Name + '.pdf';
        attachment.ContentType = 'application/pdf';
        attachment.Body = Test.isRunningTest()
                        ? Blob.valueOf('Test Blob String')
                     : pagePDF.getContentAsPDF();
        mail.setFileAttachments(new List<Messaging.EmailFileAttachment>{attachment});
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);
    }

}