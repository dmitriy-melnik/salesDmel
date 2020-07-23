@isTest
public class CheckUserProfileTest {

    public static final String STANDARD_USERNAME = 'test.standard.user@test.com';
    public static final String SYSTEM_ADMIN_USERNAME = 'test.system.admin@test.com';

    @TestSetup
    static void setupTestData() {

        Map<String, Id> profileNameToIdMap = new Map<String, Id>();
        List<Profile> profileList = [
                SELECT Id, Name
                FROM Profile
                WHERE Name IN ('System Administrator', 'Standard User')
        ];
        for (Profile profile_i : profileList) {
            if (!profileNameToIdMap.containsKey(profile_i.Name)) {
                profileNameToIdMap.put(profile_i.Name, profile_i.Id);
            }
        }

        User testSystemAdmin = new User(
                ProfileId = profileNameToIdMap.get('System Administrator'),
                FirstName = 'Randomius',
                LastName = 'Admin',
                Email = 'test.system@test.com',
                Username = SYSTEM_ADMIN_USERNAME,
                Alias = 'alias',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US',
                TimeZoneSidKey = 'Europe/Berlin'
        );

        User testStandardUser = new User(
                ProfileId = profileNameToIdMap.get('Standard User'),
                FirstName = 'Randomius',
                LastName = 'Standard',
                Email = 'test.standard@test.com',
                Username = STANDARD_USERNAME,
                Alias = 'alias',
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US',
                TimeZoneSidKey = 'Europe/Berlin'
        );

        insert new List<User>{testSystemAdmin, testStandardUser};
    }

    @IsTest
    static void dependOnProfileAdminTest() {
        User testSystemAdmin = [SELECT Id FROM User WHERE Username = :SYSTEM_ADMIN_USERNAME LIMIT 1];

        System.runAs(testSystemAdmin) {

            CheckUserProfile.dependOnProfile();

        }
    }

    @IsTest
    static void dependOnProfileStandardTest() {
        User testStandardUser = [SELECT Id FROM User WHERE Username = :STANDARD_USERNAME LIMIT 1];

        System.runAs(testStandardUser) {
            CheckUserProfile.dependOnProfile();
        }
    }
}