package library.cgi
{
    import C.stdlib.getenv;
    
    public function get AUTH_TYPE():String { return getenv( "AUTH_TYPE" ); }
    
    public function get CONTENT_LENGTH():String { return getenv( "CONTENT_LENGTH" ); }
    
    public function get CONTENT_TYPE():String { return getenv( "CONTENT_TYPE" ); }
    
    public function get GATEWAY_INTERFACE():String { return getenv( "GATEWAY_INTERFACE" ); }
    
    public function get PATH_INFO():String { return getenv( "PATH_INFO" ); }
    
    public function get PATH_TRANSLATED():String { return getenv( "PATH_TRANSLATED" ); }
    
    public function get QUERY_STRING():String { return getenv( "QUERY_STRING" ); }
    
    public function get REMOTE_ADDR():String { return getenv( "REMOTE_ADDR" ); }
    
    public function get REMOTE_HOST():String { return getenv( "REMOTE_HOST" ); }
    
    public function get REMOTE_IDENT():String { return getenv( "REMOTE_IDENT" ); }
    
    public function get REMOTE_USER():String { return getenv( "REMOTE_USER" ); }
    
    public function get REQUEST_METHOD():String { return getenv( "REQUEST_METHOD" ); }
    
    public function get SCRIPT_NAME():String { return getenv( "SCRIPT_NAME" ); }
    
    public function get SERVER_NAME():String { return getenv( "SERVER_NAME" ); }
    
    public function get SERVER_PORT():String { return getenv( "SERVER_PORT" ); }
    
    public function get SERVER_PROTOCOL():String { return getenv( "SERVER_PROTOCOL" ); }
    
    public function get SERVER_SOFTWARE():String { return getenv( "SERVER_SOFTWARE" ); }
    
    
    
}