public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        // ToDo: complete this method to make the callout (using @future) to the
        // REST endpoint and update equipment on hand.
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        
        List<Product2> equipList = new List<Product2>();
        if(res.getStatusCode()==200){
           List< Object> result =(List<object>)JSON.deserializeUntyped(res.getBody());    
           for(Object prodMap: result){
               Map<String,Object> prod = (Map<String,Object>)prodMap;
                Product2 newprod = new Product2();
                System.debug('product external id: '+ (String)prod.get('_id'));
                newprod.ExternalId=(String)prod.get('_id');
                newprod.Replacement_Part__c=true;
                newprod.Cost__c=(Decimal)prod.get('cost');
                newprod.Current_Inventory__c=(Decimal)prod.get('quantity');
                newprod.Lifespan_Months__c=(Double)prod.get('lifespan');
                newprod.Name=(String)prod.get('name');
                newprod.Maintenance_Cycle__c=(Integer)prod.get('maintenanceperiod');
                newprod.ExternalId=(String)prod.get('sku');
                equipList.add(newprod);
            }
            //System.debug('product list: '+ JSON.serializePretty(equipList));
            //System.debug('product list size: '+ equipList.size());
        Database.insert(equipList);
            System.debug('product list: '+ JSON.serializePretty([SELECT ExternalID FROM Product2]));
        }  
        
        
    }
}