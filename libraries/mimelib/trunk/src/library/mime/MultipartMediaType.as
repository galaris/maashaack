package library.mime
{
    public class MultipartMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function MultipartMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "multipart", 0x600000 );
            
            _value      = value;
            _subtype    = subtype;
            _extensions = [];
            
            if( extensions ) { _extensions = extensions; }
        }
        
        public function get subtype():String { return _subtype; }
        
        public function get extension():String
        {
            if( _extensions ) { return _extensions[0]; }
            return "";
        }
        
        public function get extensions():Array
        {
            if( _extensions ) { return _extensions; }
            return [];
        }
        
        public function toString():String { return type + "/" + _subtype; }
        
        public function valueOf():int { return category + _value; }
        
        public static const alternative:MultipartMediaType   = new MultipartMediaType(  1, "alternative" );
        public static const appledouble:MultipartMediaType   = new MultipartMediaType(  2, "appledouble" );
        public static const byteranges:MultipartMediaType    = new MultipartMediaType(  3, "byteranges" );
        public static const digest:MultipartMediaType        = new MultipartMediaType(  4, "digest" );
        public static const encrypted:MultipartMediaType     = new MultipartMediaType(  5, "encrypted" );
        public static const example:MultipartMediaType       = new MultipartMediaType(  6, "example" );
        public static const form_data:MultipartMediaType     = new MultipartMediaType(  7, "form-data" );
        public static const header_set:MultipartMediaType    = new MultipartMediaType(  8, "header-set" );
        public static const mixed:MultipartMediaType         = new MultipartMediaType(  9, "mixed" );
        public static const parallel:MultipartMediaType      = new MultipartMediaType( 10, "parallel" );
        public static const related:MultipartMediaType       = new MultipartMediaType( 11, "related" );
        public static const report:MultipartMediaType        = new MultipartMediaType( 12, "report" );
        public static const signed:MultipartMediaType        = new MultipartMediaType( 13, "signed" );
        public static const voice_message:MultipartMediaType = new MultipartMediaType( 14, "voice-message" );
        
    }
}