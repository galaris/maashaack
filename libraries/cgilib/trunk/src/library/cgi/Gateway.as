package library.cgi
{
    public interface Gateway
    {
        function enter():void;
        function execute( request:Request ):Response;
    }
}