package library.cgi
{
    import C.stdlib.getenv;
    
    //HTTP_
    public function get HTTP_ACCEPT():String { return getenv( "HTTP_ACCEPT" ); }
    
    public function get HTTP_ACCEPT_CHARSET():String { return getenv( "HTTP_ACCEPT_CHARSET" ); }
    
    public function get HTTP_ACCEPT_ENCODING():String { return getenv( "HTTP_ACCEPT_ENCODING" ); }
    
    public function get HTTP_ACCEPT_LANGUAGE():String { return getenv( "HTTP_ACCEPT_LANGUAGE" ); }
    
    public function get HTTP_CONNECTION():String { return getenv( "HTTP_CONNECTION" ); }
    
    public function get HTTP_COOKIE():String { return getenv( "HTTP_COOKIE" ); }
    
    public function get HTTP_HOST():String { return getenv( "HTTP_HOST" ); }
    
    public function get HTTP_USER_AGENT():String { return getenv( "HTTP_USER_AGENT" ); }
    
    //System
    public function get COMSPEC():String { return getenv( "COMSPEC" ); }
    
    public function get DOCUMENT_ROOT():String { return getenv( "DOCUMENT_ROOT" ); }
    
    public function get HOME():String { return getenv( "HOME" ); }
    
    public function get PATH():String { return getenv( "PATH" ); }
    
    public function get PATHEXT():String { return getenv( "PATHEXT" ); }
    
    public function get TERM():String { return getenv( "TERM" ); }
    
    public function get WINDIR():String { return getenv( "WINDIR" ); }
    
    public function get SYSTEMROOT():String { return getenv( "SYSTEMROOT" ); }
    
    //misc
    public function get REMOTE_PORT():String { return getenv( "REMOTE_PORT" ); }
    
    public function get REQUEST_URI():String { return getenv( "REQUEST_URI" ); }
    
    public function get SCRIPT_FILENAME():String { return getenv( "SCRIPT_FILENAME" ); }
    
    public function get SERVER_ADDR():String { return getenv( "SERVER_ADDR" ); }
    
    public function get SERVER_ADMIN():String { return getenv( "SERVER_ADMIN" ); }
    
    public function get SERVER_SIGNATURE():String { return getenv( "SERVER_SIGNATURE" ); }
    
}