public with sharing class YoutubeController {
    public String body {set;get;}
    public SuperItems[] dataList {set;get;}
    public void search() {
        try{
            // Instantiate Http
            Http http = new Http();
            
            // Instantiate Http Request
            HttpRequest request = new HttpRequest();
            request.setHeader('Accept', 'application/JSON');
            request.setMethod('GET');
            request.setEndPoint('callout:Youtube_API?part=snippet&key=' + System.label.YoutubeApiKey);
            
            // Instantiate Http Response
            HttpResponse response = http.send(request);
            body = response.getBody();
            
            YoutubeData responseWrapper = (YoutubeData)JSON.deserialize(body, YoutubeData.class);
            System.debug('kind --> ' + responseWrapper.kind); 

            dataList = new SuperItems[]{};
            
            for(Integer i=0 ; i < responseWrapper.items.size(); i++){
                dataList.add(new SuperItems(responseWrapper.items[i].snippet.title, responseWrapper.items[i].snippet.description, responseWrapper.items[i].snippet.thumbnails.medium.url, responseWrapper.items[i].snippet.publishedAt));
            }
            
        }
        catch(Exception e){
            System.debug('Error Message --> ' + e.getMessage() + ' in line --> ' + e.getLineNumber());
        }
        
    }
    
    public class SuperItems{
        public String title1 {set;get;}
        public String description1 {set;get;}
        public String url1 {set;get;}
        public String publishTime1 {set;get;}
        
        public SuperItems(String title, String description, String url, String publishTime){
            this.title1 = title;
            this.description1 = description;
            this.url1 = url;
            this.publishTime1 = publishTime;
        }
    }
    
    public class YoutubeData{
        public String kind;
        public String etag;
        public String nextPageToken;
        public String regionCode;
        public cls_pageInfo pageInfo;
        public cls_items[] items;
        
    }
    
    class cls_pageInfo {
        public Integer totalResults;
        public Integer resultsPerPage;
    }
    class cls_items {
        public String kind;
        public String etag;
        public cls_id id;
        public cls_snippet snippet;
    }
    class cls_id {
        public String kind;
        public String videoId;
    }
    class cls_snippet {
        public String publishedAt;
        public String channelId;
        public String title;
        public String description;	
        public cls_thumbnails thumbnails;
        public String channelTitle;	
        public String liveBroadcastContent;
        public String publishTime;
    }
    class cls_thumbnails {
        public cls_default defaultx;
        public cls_medium medium;
        public cls_high high;
    }
    class cls_default {
        public String url;	
        public Integer width;
        public Integer height;	
    }
    class cls_medium {
        public String url;
        public Integer width;
        public Integer height;	
    }
    class cls_high {
        public String url;
        public Integer width;
        public Integer height;
    }
}