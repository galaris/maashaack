
package system.reflection
    {
    
    [ExcludeClass]
    public class _TypeInfo implements TypeInfo
        {
        
        private var _type:*;
        
        public function _TypeInfo( o:* )
            {
            _type = o;
            }
        
        public function canConvertTo( o:Class ):Boolean
            {
            return (_type as o) != null;
            }
        
        public function isSubtypeOf( o:Class ):Boolean
            {
            return _type is o;
            }
        
        }
    }

