package library.cgi
{
    public class HTMLResponse implements Response
    {
        private var _content:Object;
        
        public function HTMLResponse( content:Object = null )
        {
            _content = content;
        }
        
        public function get content():Object { return _content; }
        public function set content( value:Object ):void { _content = value; }
        
        public function output():void
        {
            print( "Content-type: text/html" );
            print( "" );
            
            if( content != null )
            {
                if( content is XML )
                {
                    print( (content as XML).toXMLString() );
                }
                else
                {
                    print( String(content) );
                }
            }
            
        }

    }
}