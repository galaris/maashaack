package library.cgi
{
    import avmplus.System;
    
    import flash.utils.ByteArray;
    
    public class CGIRequest implements Request
    {
        private var _method:String;
        private var _arguments:Object;
        private var _contentType:String;
        private var _queryString:String;
        private var _postData:ByteArray;
        
        public function CGIRequest()
        {
            _ctor();
        }
        
        private function _ctor():void
        {
            _method      = REQUEST_METHOD;
            _contentType = CONTENT_TYPE;
            _queryString = QUERY_STRING;
            _arguments   = {};
            
            var len:int = int(CONTENT_LENGTH)
            
            if( len > 0 )
            {
                _postData = System.stdinRead( len );
                _arguments = _argsFromQueryString();
            }
            else
            {
                _postData = new ByteArray();
            }
        }
        
        private function _argsFromQueryString():Object
        {
            if( (_queryString != null) && (_queryString.length > 0) )
            {
                return _argsFrom( _queryString );
            }
            
            return _argsFrom( "" );
        }
        
        private function _argsFromPostData():Object
        {
            if( (_postData != null) && (_postData.length > 0) )
            {
                var pos:uint = _postData.position;
                
                _postData.position = 0;
                var value:String = _postData.readUTFBytes( _postData.length );
                _postData.position = pos;
                
                return _argsFrom( value );
            }
            
            return _argsFrom( "" );
        }
        
        private function _argsFrom( value:String ):Object
        {
            var args:Object = {};
            
            if( value.length > 0 )
            {
                var pairs:Array = value.split( "&" );
                for each( var pair:String in pairs )
                {
                    var keyvalue:Array = pair.split( "=" );
                    if( keyvalue.length == 2 )
                    {
                        args[ keyvalue[0] ] = keyvalue[1];
                    }
                }
            }
            
            return args;
        }
        
        public function get method():String { return _method; }
        
        public function get arguments():Object { return _arguments; }
        
        public function get contentType():String { return _contentType; }
        
        public function get queryString():String { return _queryString; }
        
        public function get postData():ByteArray { return _postData; }
        
        public function createArgsFromQueryString():void
        {
            _arguments = _argsFromQueryString();
        }
        
        public function createArgsFromPostData():void
        {
            _arguments = _argsFromPostData();
        }
        
    }
}