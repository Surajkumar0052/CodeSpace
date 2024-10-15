trigger LeadTrigger on Lead (before insert) {
     List<Lead> leads = Trigger.new;
    for(Lead ld : leads){
      /*  if(ld.Industry == 'Banking'){
            ld.Rating = 'Hot';
            ld.LeadSource = 'Web';
        }
        else{
            ld.Rating = 'Warm';
            ld.LeadSource = 'Email';
        } */
        
        
        if(ld.LeadSource == 'Web' && String.isBlank(ld.Email)){
            ld.addError('Please fill Email field');
        }
        
    }
}