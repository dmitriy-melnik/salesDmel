public class ContactSearch {
    public static Contact[] searchForContacts(String str1, String str2) {
        Contact[] result = [SELECT ID,FirstName,LastName FROM Contact 
                            WHERE LastName = :str1 AND MailingPostalCode = :str2];
        return result;
    }

}