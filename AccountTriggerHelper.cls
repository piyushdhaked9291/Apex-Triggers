public class AccountTriggerHelper {
    public static void updatesale(List<Account>req){
        for(Account acc:req){
            User u=[select Name from user where Id=:acc.OwnerId];
            acc.sales_Rep__c=u.Name;
           
        }
    }
    public static void updateContact(List<Account>re){
        List<Contact>toup=new List<Contact>();
        List<Account>r2=[select Id,Name,BillingCity,BillingPostalCode,BillingCountry,BillingStreet ,BillingState,(Select Id from Contacts) from Account Where Id IN:re];
        for(Account ac:r2){
            List<Contact>con=ac.Contacts;
            for(Contact c:con){
                c.MailingCity=ac.BillingCity;
                c.MailingPostalCode=ac.BillingPostalCode;
                c.MailingCountry=ac.BillingCountry;
                c.MailingStreet=ac.BillingStreet;
                c.MailingState=ac.BillingState;
             
                toup.add(c);
            }
        }
        update toup;
    }
    public static void afterinsertcreatesubs(List<Account>monthly,List<Account>annual){
        List<Subscription__c>toinsert=new List<Subscription__c>();
        if(monthly.size()>0){
            for(Account acc:monthly){
                Subscription__c sub=new Subscription__c();
                sub.Account__c=acc.Id;
                sub.Name='Gaana';
                sub.IsActive__c=True;
                sub.Type__c='Monthly';
                
                Subscription__c sub2=new Subscription__c();
                sub2.Account__c=acc.Id;
                sub2.Name='SonyLiv';
                sub2.IsActive__c=True;
                sub2.Type__c='Monthly';
                
                toinsert.add(sub);
                toinsert.add(sub2);
                
            }
        }
         List<Subscription__c>toinsert2=new List<Subscription__c>();
         if(annual.size()>0){
            for(Account acc1:annual){
                Subscription__c sub3=new Subscription__c();
                sub3.Account__c=acc1.Id;
                sub3.Name='Amazon Prime';
                sub3.IsActive__c=True;
                sub3.Type__c='Annual';
                
                Subscription__c sub4=new Subscription__c();
                sub4.Account__c=acc1.Id;
                sub4.Name='Hotstar';
                sub4.IsActive__c=True;
                sub4.Type__c='annual';
                
                Subscription__c sub5=new Subscription__c();
                sub5.Account__c=acc1.Id;
                sub5.Name='Spotify';
                sub5.IsActive__c=True;
                sub5.Type__c='annual';
                
                toinsert2.add(sub3);
                toinsert2.add(sub4);
                toinsert2.add(sub5);
                
            }
        }
        if(toinsert.size()>0){
            insert toinsert;
         }
        if(toinsert2.size()>0)
        {
            insert toinsert2;
        }   
        
    }
    public static void insertcontacts(List<Account>req){
        List<Contact>conList=new List<Contact>();
        for(Account acc :req){
            for(Integer i=Integer.valueOf(acc.NumberofLocations__c);i>0;i--){
                System.debug('Hello');
                Contact c=new Contact();
                c.LastName='NewForAccount'+i;
                c.AccountId=acc.Id;
                conList.add(c);
            }
        }
        insert conList;
    }
}