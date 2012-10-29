package library.cgi
{
    public class CommonGatewayInterface implements Gateway
    {
        public function CommonGatewayInterface()
        {
            
        }
        
        public function enter():void
        {
            var request:Request = new CGIRequest();
            
            var response:Response = execute( request );
            
            if( response != null )
            {
                response.output();
            }
            else
            {
                var err:Response = new TextResponse( "CGI error" );
                err.output();
            }
            
        }
        
        public function execute( request:Request ):Response
        {
            return null;
        }
        
    }
}