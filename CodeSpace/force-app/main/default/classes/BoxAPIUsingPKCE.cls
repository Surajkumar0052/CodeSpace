public with sharing class BoxAPIUsingPKCE {
    public static PageReference authenticate(){
        String endPoint = 'https://account.box.com/api/oauth2/authorize/?client_id=zjdjwqhdqkhxjjcknclihwqd&response_type=code&code_challenge_method=S256&code_challenge=';

        // Create Code Verifier

        String codeVerifier = 'ABCFRTYHTDT23567543TFCVFRDHVHGGH5653426GGTHDD543JBJF';

        // Encrypt Code Verifier

        Blob encryptedCodeVerfier = Crypto.generateDigest('SHA3-256', Blob.valueOf(codeVerifier));

        // Encode Code Verifier

        String afterEncoding = EncodingUtil.base64Encode(encryptedCodeVerfier); 

        endPoint += afterEncoding;
        return new PageReference(endPoint);

    }
}