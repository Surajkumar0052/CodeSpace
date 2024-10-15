trigger CreateOpp on Account (after insert) {
   List<Account> accounts = Trigger.new;  // List of new accounts which are saved to account
   CreateOpportunity.create(accounts);
}