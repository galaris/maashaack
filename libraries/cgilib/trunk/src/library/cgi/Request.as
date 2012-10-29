package library.cgi
{
    import flash.utils.ByteArray;
    
    public interface Request
    {
        function get method():String;
        function get arguments():Object;
        function get contentType():String;
        function get queryString():String;
        function get postData():ByteArray;
        
        function createArgsFromQueryString():void;
        function createArgsFromPostData():void;
    }
}