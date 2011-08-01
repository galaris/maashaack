package library.cgi
{
    public class TextResponse implements Response
    {
        private var _content:String;
        
        public function TextResponse( content:String = "" )
        {
            _content = content;
        }
        
        public function get content():String { return _content; }
        public function set content( value:String ):void { _content = value; }
        
        public function output():void
        {
            print( "Content-type: text/plain" );
            print( "" );
            print( content );
        }
    }
}