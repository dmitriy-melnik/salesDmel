public with sharing class CheckUserProfile {

    public static final String PROFILE_SYSTEM_ADMIN = 'System Administrator';

    public static void dependOnProfile() {
        Profile userProfile = [
                SELECT Id, Name
                FROM Profile
                WHERE Id = :UserInfo.getProfileId()
        ];

        if (userProfile.Name == PROFILE_SYSTEM_ADMIN) {
          insertAccount(PROFILE_SYSTEM_ADMIN);
        } else {
            insertAccount('NONE ADMIN');
        }

    }

    private static void insertAccount(String name) {
        insert new Account(
                Name = name
        );
    }



}