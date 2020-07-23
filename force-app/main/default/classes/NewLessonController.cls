public with sharing class NewLessonController {
    
    @AuraEnabled
    public static Lesson__c obtainLessonInitData(Id courseId) {
        
        Lesson__c newLesson = new Lesson__c(
        	Course__c = courseId,
            StartDateTime__c = DateTime.now()
        );
        newLesson.EndDateTime__c = DateTime.now().addHours(2);

        List<Course__c> courses = [SELECT Id, Name, (SELECT Id, Name FROM Course_Staff1__r WHERE Staff_Type__c = 'Primary')
                                    FROM Course__c
                                    WHERE Id = :courseId];


        if(!courses.isEmpty()) {
            newLesson.Teacher__c = courses[0].Course_Staff1__r[0].Id;
        }

        return newLesson;
    }
}