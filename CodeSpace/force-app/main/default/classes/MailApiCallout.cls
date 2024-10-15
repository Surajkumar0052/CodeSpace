public class MailApiCallout {
    @AuraEnabled
    public static String sendMail( String email, String subject, String body ) {
        try{
            /* Getting record using SOQL
            EmailAPI_Handler__mdt emailAPI = [SELECT ID, From__c, Name__c, Header_Parameters__c, Endpoint__c, Method__c, Username__c, Password__c 
                                              FROM EmailAPI_Handler__mdt WHERE DeveloperName = 'mailjet']; */
            
            // Getting record using metaData method
            EmailAPI_Handler__mdt emailAPI = EmailAPI_Handler__mdt.getInstance('mailjet');

            RequestHeader objRequestHeader = parseRequestHeader(emailAPI.Header_Parameters__c);
            system.debug('objRequestHeader '+objRequestHeader);
            
            Http h = new Http();
            
            // body to pass in post request
           
            String requestBody = '';
            requestBody += '{"Messages":[{"From":{"Email":" ' + emailAPI.From__c + ' ","Name":" ' + emailAPI.Name__c + ' "},"To":[{';
            requestBody += '"Email" : ' + '"' + email + '"';
            requestBody += ',"Name":"You"}],';
            requestBody += '"Subject":"' + subject + '",';
            requestBody += '"TextPart":"' + body + '"}]}';
            
            // Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
            
            System.debug('Request JSON : ' + requestBody);
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(emailAPI.Endpoint__c);
            req.setMethod(emailAPI.Method__c);
            req.setHeader('Authorization', objRequestHeader.Authorization);
            req.setHeader('Content-Type', objRequestHeader.ContentType);
            req.setBody(requestBody);
            
            // Send the post request
            
            HttpResponse res = h.send(req);
            System.debug('Body : ' + res.getBody());
            return res.getStatus();
            
        }
        catch(exception e){
            System.debug('Error : ' + e.getMessage());
            return e.getMessage();
        }       
    }
    
    public class RequestHeader{
        public String Authorization;
        public String ContentType;
        
    }
    public static RequestHeader parseRequestHeader(String json){
        return (RequestHeader) System.JSON.deserialize(json, RequestHeader.class);
    }
    
}