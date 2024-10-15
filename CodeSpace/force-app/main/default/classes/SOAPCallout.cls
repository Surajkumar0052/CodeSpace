public class SOAPCallout {
    
    public static void hitAPI(){
        try{
            ContentVersion cvObj = [SELECT Id, ContentDocument.Title, VersionData FROM ContentVersion WHERE Id = '0685i00000JHN2EAAX'];
            String base64PDF = EncodingUtil.base64Encode(cvObj.VersionData);
            System.debug('base64PDF --> ' + base64PDF);
            
            String reqBody = '<Header>' + 
                '<Authenticate_Info xmlns="http://www.Insurer.com/webservices/">' + 
                '<UserName>IRDAUSER</UserName>' + 
                '<Password>IRDAUSER</Password>' + 
                '<EntityId>999999999</EntityId>' + 
                '</Authenticate_Info>' + 
                '</Header>' + 
                '<Body>' +
                '<UploadAttachment xmlns="http://www.Insurer.com/webservices/">' + 
                '<bytFile>' + base64PDF + '</bytFile>' + 
                '<IRDA_Token_Number>10-20-000000</IRDA_Token_Number>' + 
                '<fileName>' + cvObj.ContentDocument.Title + '</fileName>' + 
                '<isFRRDoc>1</isFRRDoc>' + 
                '</UploadAttachment>' + 
                '</Body>';
            
            // Step 2: Create a SOAP request envelope with the Blob embedded
            /*String soapEnvelope = '<?xml version="1.0" encoding="utf-8"?>' +
                '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="YOUR_SOAP_NAMESPACE">' +
                '   <soapenv:Header/>' +
                '   <soapenv:Body>' +
                '       <ser:POST>' +
                '           <pdfContent>' + base64PDF + '</pdfContent>' +
                '       </ser:POST>' +
                '   </soapenv:Body>' +
                '</soapenv:Envelope>'; */
            
            
            // Step 3: Make the SOAP callout with the request envelope
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://igmsuat.irdai.gov.in:8443');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/xml');
            req.setBody(reqBody);
            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('Response --> ' + res.getStatusCode() + 'and response body --> ' + res.getBody() );
            
        }
        catch(Exception e){
            System.debug('Error stack trace --> ' + e.getStackTraceString());
            System.debug('Error message --> ' + e.getMessage() + ' in line number --> ' + e.getLineNumber());
        }
        
    }   
    
    
}