trigger Lead_Contact on Lead (after insert) {
    List<Lead> leads = Trigger.new;
    Lead_Contact_Handler.create(leads);
}