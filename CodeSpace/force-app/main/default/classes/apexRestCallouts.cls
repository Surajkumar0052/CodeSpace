public class apexRestCallouts {
    public static void getData(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        req.setMethod('GET');
        
        HttpResponse resp = http.send(req);
        if(resp.getStatusCode() == 200){
            Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(resp.getBody());
            List<Object> animals = (List<Object>)resMap.get('animals');
            for( Object animal : animals){
                System.debug('Animal : ' + animal);
            }
        }
    }
    
    public static void postData(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Set the body as a JSON object
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }
}