public class AccountTriggerHandeler {
		
    public static void beforeInsert(Map<Id,Account>Newd,Map<Id,Account>Old){
        List<Account>req=new List<Account>();
        for(Account acc:Newd.values()){
            if(old.get(acc.id).OwnerId!=acc.OwnerId){
                req.add(acc);
                
            }
            
        }
        AccountTriggerHelper.updatesale(req);
        
    }
    public static void beforeIn(List<Account>tn){
        List<Account>req=new List<Account>();
        for(Account acc:tn){
            if(acc.sales_Rep__c==null){
                req.add(acc);
                
            }
            
        }
        AccountTriggerHelper.updatesale(req);
        
    }
     public static void afterupdate(Map<Id,Account>oldval,List<Account>accval){
        List<Account>re=new List<Account>();
        for(Account a:accval){
            if(a.BillingStreet!=oldval.get(a.Id).BillingStreet || a.BillingCountry!=oldval.get(a.Id).BillingCountry || a.BillingState!=oldval.get(a.Id).BillingState ||oldval.get(a.Id).BillingPostalCode!=a.BillingPostalCode || a.BillingCity!=a.BillingCity){
                re.add(a);
                
            }
            
        }
       AccountTriggerHelper.updateContact(re);
    }
    public static void afterinsert(List<Account>accList){  //Assignment 2 - 1
        List<Account>Monthly=new List<Account>();
        List<Account>Annual=new List<Account>();
        for(Account acc:accList){
            if(acc.Type_of_Subscription__c=='Monthly'){
                Monthly.add(acc);
            }
            if(acc.Type_of_Subscription__c=='Annual'){
                Annual.add(acc);
            }
        }
        if(Monthly.size()>0 || Annual.size()>0){
        AccountTriggerHelper.afterinsertcreatesubs(Monthly,Annual);
        }
    }
    public static void afterinsertCreatecontact(List<Account>accList){
        List<Account>req=new List<Account>();
        for(Account acc:accList){
            if(acc.NumberofLocations__c!=0){
                req.add(acc);
            }
        }
       
        AccountTriggerHelper.insertcontacts(req);
        
    }
}