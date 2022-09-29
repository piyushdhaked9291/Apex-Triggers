public class OpportunityTriggerHandeler {
    public static void afterupdate(Map<Id,Opportunity>old,List<Opportunity>oppo){      //Previous Assignment Question 
        List<Opportunity>req=new List<Opportunity>();
        for(Opportunity opp:oppo){
            if(opp.stageName=='Closed Won' && old.get(opp.Id).stageName!=opp.stageName){
                req.add(opp);
            }
        }
        List<Asset>tocre=new List<Asset>();
        for(Opportunity opp2 : req){
            List<OpportunityLineItem>oli=[select Name,Quantity,	Product2Id,Description from OpportunityLineItem where OpportunityId=:opp2.Id];
            for(OpportunityLineItem oli2:oli){
                Asset ass=new Asset();
                ass.AccountId=opp2.AccountId;
                ass.Quantity=oli2.Quantity;
                ass.Product2Id=oli2.Product2Id ;
                ass.Description=oli2.Description;
                ass.Name=oli2.Name;
                
                tocre.add(ass);
                
            }
            
        }
        insert tocre;
        
    }
    public static void afterupdateoppo(List<Opportunity>oppList){ //Assignment 1 - 2
        List<Task>taskList=new List<Task>();
        for(Opportunity opp1:oppList){
            Task t=new Task();
            t.OwnerId=opp1.OwnerId;
            t.Status='In Progress';
            taskList.add(t);
            
        }
        insert taskList;
    }
    public static void sendmail(Map<Id,Opportunity>old,List<Opportunity>oppo){ //Assignment 2-2
        List<Opportunity>req=new List<Opportunity>();
        for(Opportunity opp:oppo){
            if(opp.stageName=='Closed Won' && old.get(opp.Id).stageName!=opp.stageName){
                req.add(opp);
            }
        }
        if(req.size()>0){
        Set<Id>reqacc=new Set<Id>();
        Map<Id,String>togetname=new Map<Id,String>();
        for(Opportunity opp1:req){
            if(opp1.AccountId!=NULL){
                reqacc.add(opp1.AccountId);
                togetname.put(opp1.AccountId,opp1.Name);
            }
        }
         if(reqacc.size()>0){
        List<Account>allreqAccount=[select Id,(Select Id,Email,LastName from Contacts)from Account where Id IN:reqacc];
        OpportunityTriggerHelper.sendemailtocon(allreqAccount,togetname);
        }
       }
        
    }
    public static void deleting(Map<Id,Opportunity>old,List<Opportunity>oppo){  //Assignment 3 - 1
         List<Opportunity>req=new List<Opportunity>();
        for(Opportunity opp:oppo){
            if(opp.stageName=='Closed Lost' && old.get(opp.Id).stageName!=opp.stageName){
                req.add(opp);
            }
        }if(req.size()>0){
        List<Opportunity>reqTask=[select Id,Name,(Select Id from Tasks where Status!='Completed') from Opportunity where Id IN: req];
        List<Opportunity>reqquotes=[select Id,Name,(Select Id from Quotes) from Opportunity where Id IN: req];
        
        OpportunityTriggerHelper.deleteopen(reqTask,reqquotes);
        }
        
        
    }
    
    public static void countroleandstop(Map<Id,Opportunity>old,List<Opportunity>oppo){ //Assignment 3
         List<Opportunity>req=new List<Opportunity>();
        for(Opportunity opp:oppo){
            if(old.get(opp.Id).stageName!=opp.stageName){
                req.add(opp);
            }
        }
        if(req.size()>0){
            OpportunityTriggerHelper.Checkandcount2(req);
        }
}
}