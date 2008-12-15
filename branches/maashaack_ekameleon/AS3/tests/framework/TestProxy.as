
package  
{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;    

    /**
     * Test the Proxy class.
     */
    public dynamic class TestProxy extends Proxy 
    {

        public function TestProxy()
        {
        }
        
        public var o:Object ;
        
        flash_proxy override function deleteProperty( name:* ):Boolean
        {
            if ( name in o )
            {
                return delete o[name] ;	
            }
            return false ;
        }
        
        flash_proxy override function callProperty( name:* , ...rest:Array ):*
        {
            if ( name in o )
            {
            	if ( o[name] is Function )
            	{
            		return o[name].apply(o, rest) ;  	
            	}
            	else
            	{
            		return o[name] ;
            	}
            }
        }
    }
}
