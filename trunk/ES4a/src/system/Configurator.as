

package system
    {
    
    public class Configurator implements ISerializable
        {
        protected var _config:Object;
        
        public function Configurator( config:Object )
            {
            _config = {};
            load( config );
            }
        
        public function load( config:Object ):void
            {
            for( var member:String in config )
                {
                _config[member] = config[member]
                }
            }
        
        public function toSource( indent:int = 0 ):String
            {
            return Serializer.serialize( _config );
            }
        
        public function toString():String
            {
            return toSource();
            }
        
        }
    
    }

