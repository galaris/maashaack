package flash.errors
{
    /**
     * The DRMManager dispatches a DRMManagerError event to report errors.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.5
     */
    [API(CONFIG::AIR_1_5)]
    public class DRMManagerError extends Error
    {
        private var _subErrorID:int;
        
        public function DRMManagerError( message:String, id:int, subErrorID:int )
        {
            CFG::dbg{ trace( "new DRMManagerError( " + [message,id,subErrorID].join(", ") + " )" ); }
            super( message, id );
            this.name = "DRMManagerError";
            
            _subErrorID = subErrorID;
        }

        [API(CONFIG::AIR_1_5)]
        public function get subErrorID():int { return _subErrorID; }
        
        /* TODO:
           implement toString
        */
    }
}