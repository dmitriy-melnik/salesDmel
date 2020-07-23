@IsTest
public class TestRestrictContactByName {

    @IsTest
    public static void testRestriction() {
        Contact contact = new Contact(
        	LastName = 'INVALIDNAME'
        );
        
        insert contact;
        
        System.assertEquals(null, [SElECT Id FROM Contact 
                                   WHERE LastName = 'INVALIDNAME']);
    }
    
}