package library.mime
{
    public class ModelMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function ModelMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "model", 0x500000 );
            
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
        
        public static const example:ModelMediaType       = new ModelMediaType(  1, "example" );
        public static const iges:ModelMediaType          = new ModelMediaType(  2, "iges" );
        public static const mesh:ModelMediaType          = new ModelMediaType(  3, "mesh" );
        public static const collada:ModelMediaType       = new ModelMediaType(  4, "vnd.collada+xml", ["dae"] );
        public static const flatland_3dml:ModelMediaType = new ModelMediaType(  5, "vnd.flatland.3dml", ["3dml", "3dm"] );
        public static const vrml:ModelMediaType          = new ModelMediaType(  6, "vrml" );
        
    }
}