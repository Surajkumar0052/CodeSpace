/**
 * @description       : 
 * @author            : Suraj Kumar
 * @group             : 
 * @last modified on  : 12-04-2023
 * @last modified by  : Suraj Kumar
**/
public class YoutubeResponseWrapper{
    public String kind;	
    public String etag;	
    public String nextPageToken;	
    public String regionCode;	
    public cls_pageInfo pageInfo;
    public cls_items[] items;
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
        public String channelId;	
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
        public cls_default default_x;
        public cls_medium medium;
        public cls_high high;
    }
    class cls_default {
        public String url;	
    }
    class cls_medium {
        public String url;	
    }
    class cls_high {
        public String url;	
    }
    public static YoutubeResponseWrapper parse(String json){
        return (YoutubeResponseWrapper) System.JSON.deserialize(json, YoutubeResponseWrapper.class);
    }
}