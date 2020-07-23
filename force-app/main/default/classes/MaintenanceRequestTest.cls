@IsTest
public class MaintenanceRequestTest {  
    
    static List<Case> caseListForTest = new List<Case>();

    public static List<Case> createData(Integer numOfCases, Integer numOfProducts, Integer numOfVehicles, String type) {
        
        List<Case> caseList = new List<Case>();
        List<Product2> prodList = new List<Product2>();
        List<Work_Part__c> wpList = new List<Work_Part__c>();
        
        Vehicle__c vehicle = new Vehicle__c();
        vehicle.Name = 'Test Vehicle';
        insert vehicle;
        
        //products
        for (Integer i = 0; i < numOfProducts; i++) {
            Product2 product = new Product2();
            product.Name = 'Test Product ' + i;
            
            if(i != 0) {
                product.Maintenance_Cycle__c = i;
            }
            
            product.Replacement_Part__c = true;
            prodList.add(product);
        }
        insert prodList;
        
        //cases
        for (Integer i = 0; i < numOfCases; i++) {
            Case case1 = new Case();
            
            case1.Status = 'New';
            case1.Origin = 'web';
            
            if(math.mod(i, 2) == 0){
                case1.Type = 'Routine Maintenance';
            }          
            else {
                case1.Type = 'Repair'; 
            }
            
            case1.Subject='Routine Maintenance of Vehicle' + i;
            case1.Vehicle__c = vehicle.Id;
            
            if(i < numOfProducts) {
             	case1.Equipment__c = prodList.get(i).ID;   
            }             
            else {
                case1.Equipment__c = prodList.get(0).ID;
            }
            
            caseList.add(case1);
        }
		insert caseList;  
        
        //--
        for (Integer i = 0; i < numOfProducts; i++) {
             Work_Part__c wp = new Work_Part__c();
             wp.Equipment__c = prodlist.get(i).Id   ; 
             wp.Maintenance_Request__c = caseList.get(i).id;
             wplist.add(wp) ;
        }
        
        insert wpList;
        
        return caseList;
    }
    
    
    @IsTest
    public static void testMaintenanceHelper(){
        
        Test.startTest();
		caseListForTest = createData(200, 2,2, 'Repair');  
        
        for(Case case_i : caseListForTest) {
            case_i.Status = 'Closed';
        }
        update caseListForTest;
        Test.stopTest();
        
        Case caseForAssert = [SELECT Id FROM Case WHERE Type = 'Routine Maintenance'];
        
        System.assertEquals('Routine Maintenance of Vehicle', caseForAssert.Subject);
    }
}