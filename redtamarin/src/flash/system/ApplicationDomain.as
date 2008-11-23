package flash.system
{
    import avmplus.Domain;
    
    public class ApplicationDomain
    {
        private var _parentDomain:ApplicationDomain;
        
        private var _root:Domain;
        
        public function ApplicationDomain( parentDomain:ApplicationDomain = null )
        {
            _parentDomain = parentDomain;
        }
        
        private static var _rootDomain:ApplicationDomain;
        
        public static function get currentDomain():ApplicationDomain
        {
            if( !_rootDomain )
            {
                _rootDomain = new ApplicationDomain();
                _rootDomain.setDomain( Domain.currentDomain );
            }
            
            return _rootDomain;
        }
        
        public function setDomain( dom:Domain ):void
        {
            _root = dom;
        }
        
        public function get parentDomain():ApplicationDomain
        {
            return _parentDomain;
        }
        
        public function getDefinition( name:String ):Object
        {
            return _root.getClass( name ) as Object;
        }
        
        public function hasDefinition( name:String ):Boolean
        {
            if( _root.getClass( name ) != null )
            {
                return true;
            }
            
            return false;
        }
        
    }
    
}