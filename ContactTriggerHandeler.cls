public class ContactTriggerHandeler {
    
    public static void createandcheck(List<Contact>con){        //Assignment 1 - 1
        List<Contact>conList=[Select Id,Name,Email,Phone from Contact];
        for(Contact cc:con){
            for(Contact cc2:conList){
                if(cc.Email==cc2.Email){
                    cc.Email.addError('Duplicate Email Found');
                    break;
                }
                else if(cc.Phone==cc2.Phone){
                     cc.Phone.addError('Duplicate Phone Found');
                     break;
                }
            }
        }
    }
    public static void createContactRelation(List<Contact>con){  //Assignment 1 - 4
       List<Contact>conList=new List<Contact>();
        for(Contact c1:con){
            if(c1.Contact_Relationship__c){
                conList.add(c1);
            }
        }
        List<Contacts_Relationships__c>req=new List<Contacts_Relationships__c>();
        for(Contact c2:conList){
            Contacts_Relationships__c cr=new Contacts_Relationships__c();
            cr.Contact__c=c2.Id;
            req.add(cr);
        }
        if(req.size()>0){
            insert req;
        }
        
    }
    public static void updateNumberOfContact(List<Contact>conList){  //Assignment 1 - 5 pt 1
        Set<Id>AccId=new Set<Id>();
        for(Contact con:conList){
            If(con.AccountId!=NULL){
            AccId.add(con.AccountId);
            }
        }
        List<Account>AccWithCon=[select Id,Number_Of_Contacts__c, (Select id from Contacts) from Account where Id IN:AccId];
        List<Account>reqtoupdate=new List<Account>();
        for(Account acc:AccWithCon){
            List<Contact>c1=acc.Contacts;
            Decimal ans=c1.size();
            acc.Number_Of_Contacts__c=ans;
            reqtoupdate.add(acc);
            
        }
        update reqtoupdate;
    }
    public static void updateNumberOfContactondelete(List<Contact>conList){  //Assignment 1 - 5 pt 2
        Set<Id>AccId=new Set<Id>();
        for(Contact con:conList){
            If(con.AccountId!=NULL){
            AccId.add(con.AccountId);
            }
        }
        List<Account>AccWithCon=[select Id,Number_Of_Contacts__c, (Select id from Contacts) from Account where Id IN:AccId];
        List<Account>reqtoupdate=new List<Account>();
        for(Account acc:AccWithCon){
            List<Contact>c1=acc.Contacts;
            Decimal ans=c1.size();
            acc.Number_Of_Contacts__c=ans; //Assignment 1 - 5
            acc.NumberofLocations__c=ans;  // Assignment 2- 4
            reqtoupdate.add(acc);
            
        }
        update reqtoupdate;
    }
}