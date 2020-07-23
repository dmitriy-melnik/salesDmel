public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String str) {
        
        List<List<sObject>> searchList = [FIND :str IN NAME FIELDS 
                   RETURNING Contact(Name),Lead(FirstName)];
        System.debug(searchList);
        
        return searchList;
        
      }
}