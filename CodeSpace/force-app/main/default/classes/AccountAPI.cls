@RestResource(urlMapping='/Account/Contacts/*')
global class AccountAPI {
    // https://instance.salesforce.com/services/apexrest/Account/Contacts/0012GFT23478GHTDVF

    @HttpGet
    global static Account getAccount(){
        RestRequest req = RestContext.request;

        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        Account acc = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id =: accountId ];
        return acc;
    }
    
}