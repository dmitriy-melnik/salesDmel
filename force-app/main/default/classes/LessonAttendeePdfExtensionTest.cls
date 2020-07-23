@IsTest
private class LessonAttendeePdfExtensionTest {

    @TestSetup
    static void setupTestData() {
        Id studentRTId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Student').getRecordTypeId();
        Id teacherRTId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Teacher').getRecordTypeId();

        Contact testStudent = new Contact(
                RecordTypeId = studentRTId,
                LastName     = 'Test Student'
        );
        Contact testTeacher = new Contact(
                RecordTypeId = teacherRTId,
                LastName     = 'Test Teacher',
                Email		 = '54321@email.com'
        );
        insert new List<Contact>{testStudent, testTeacher};

        Course__c testCourse = new Course__c(
                Name = 'Test Course'
        );
        insert testCourse;

        Lesson__c testLesson = new Lesson__c(
                Name             = 'Test Lesson',
                Course__c        = testCourse.Id,
                StartDateTime__c = DateTime.now().addDays(2),
                EndDateTime__c   = DateTime.now().addDays(2).addHours(2),
                Teacher__c	     = testTeacher.Id
        );
        insert testLesson;

        LessonAttendee__c testLessonAttendee = new LessonAttendee__c(
                Lesson__c  = testLesson.Id,
                Student__c = testStudent.Id
        );
        insert testLessonAttendee;

    }

    @IsTest
    static void attendeePdfTest() {

        Lesson__c testLesson = [SELECT Id FROM Lesson__c LIMIT 1];

        Test.startTest();
        Apexpages.StandardController stdCtrl = new Apexpages.StandardController(testLesson);
        LessonAttendeePdfExtension extension = new LessonAttendeePdfExtension(stdCtrl);
        Test.stopTest();

        System.assertEquals(1, extension.lessonAttendeeList.size());
        System.assertEquals(1, extension.getLessonAttendeeMap().size());
    }

}