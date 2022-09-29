public class ContactRoleTriggerHelper {
    public static void updadtenoofcontactrole(List<Opportunity>oppo){
        List<Opportunity>ans=new List<Opportunity>();
        for(Opportunity opp:oppo){
            List<OpportunityContactRole>oc=opp.OpportunityContactRoles;
            decimal ans1=oc.size();
            opp.No_of_Contact_Roles__c=ans1;
            ans.add(opp);
            
        }
        if(ans.size()>0){
            update ans;
        }
        
    }
}