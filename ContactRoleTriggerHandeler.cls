public class ContactRoleTriggerHandeler {
    public static void updatefield(List<OpportunityContactRole>ocr){
        Set<Id>oppId=new Set<Id>();
        for(OpportunityContactRole ocr1:ocr){
            if(ocr1.OpportunityId!=NULL){
            oppId.add(ocr1.OpportunityId);
            }
        }
        if(oppId.size()>0){
        List<Opportunity>reqopp=[select Id,No_of_Contact_Roles__c,(Select Id from OpportunityContactRoles) from Opportunity where Id IN:oppId];
        ContactRoleTriggerHelper.updadtenoofcontactrole(reqopp);
        }
    
    }
    
    public static void updatefieldaatdel(List<OpportunityContactRole>ocr){
        Set<Id>oppId=new Set<Id>();
        for(OpportunityContactRole ocr1:ocr){
            if(ocr1.OpportunityId!=NULL){
            oppId.add(ocr1.OpportunityId);
            }
        }
        if(oppId.size()>0){
        List<Opportunity>reqopp=[select Id,No_of_Contact_Roles__c,(Select Id from OpportunityContactRoles) from Opportunity where Id IN:oppId];
        ContactRoleTriggerHelper.updadtenoofcontactrole(reqopp);
        }
    }
}