public with sharing class LessonAttendeePdfExtension {

    public Lesson__c lesson { get; set; }
    public Course__c course { get; set; }
    public Contact teacher { get; set; }
    public String startDate { get; set; }
    public String endDate { get; set; }

    public Map<Integer, LessonAttendee__c> lessonAttendeeMap = new Map<Integer, LessonAttendee__c>();
    public List<LessonAttendee__c> lessonAttendeeList { get; set; }
    public Set<Integer> lessonAttendeeKeySet { get; set; }

    public Map<Integer, LessonAttendee__c> getLessonAttendeeMap() {
        return this.lessonAttendeeMap;
    }

    public LessonAttendeePdfExtension(ApexPages.StandardController stdController) {
        this.lesson = (Lesson__c) stdController.getRecord();

        this.lesson = [
                SELECT Id, Name, StartDateTime__c, EndDateTime__c, Course__c, Teacher__c
                FROM Lesson__c
                WHERE Id = :this.lesson.Id
                LIMIT 1
        ];

        this.lessonAttendeeList = [
                SELECT Id, Student__r.Name, WillBeAbsent__c
                FROM LessonAttendee__c
                WHERE Lesson__c = :this.lesson.Id
        ];

        if (lessonAttendeeList != null && lessonAttendeeList.size() > 0) {
            for (Integer i = 0; i < lessonAttendeeList.size(); i++) {

                lessonAttendeeMap.put(i + 1, lessonAttendeeList[i]);
            }
            lessonAttendeeKeySet = lessonAttendeeMap.keySet();
        }

        this.startDate = lesson.StartDateTime__c.format('yyyy/MM/dd hh:mm:ss');

        this.endDate = lesson.EndDateTime__c.format('yyyy/MM/dd hh:mm:ss'); 

        this.course = [SELECT Id, Name FROM Course__c WHERE Id = :lesson.Course__c LIMIT 1];

        this.teacher = [SELECT Id, Name FROM Contact WHERE Id = :lesson.Teacher__c LIMIT 1];

    }

}