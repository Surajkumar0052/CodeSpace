public class AccountController {
    public List<Account> accList {get; set;}
    public AccountController(){
        accList = [SELECT Id, Name, Rating, Industry FROM Account WHERE Name!=Null AND Rating!=Null AND Industry!=Null LIMIT 10];
        System.debug('accList : ' + accList);
    }
    
    
    @AuraEnabled( cacheable = true )
    public static List< Account > fetchAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Industry, Rating
            FROM Account WHERE Name LIKE :key
            LIMIT 20 
        ];
        
    }
    
    @AuraEnabled
    public static List<Account> searchAccounts(String searchKey) {
        List<List<Sobject>> accountSearchResults = [
            FIND :searchKey
            IN ALL FIELDS
            RETURNING Account(Name, Industry, Rating)
            LIMIT 20
        ];
        if (!accountSearchResults.isEmpty()) {
            return (Account[]) accountSearchResults[0];
        }
        return new List<Account>();
    }
    
    
}