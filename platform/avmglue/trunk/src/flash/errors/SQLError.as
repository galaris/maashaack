package flash.errors
{
    /**
     * A SQLError instance provides detailed information about a failed operation.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLError extends Error
    {
        private var _operation:String;
        private var _details:String;
        private var _detailID:int;
        private var _detailArguments:Array;
        
        public function SQLError( operation:String, details:String = "", message:String = "", id:int = 0,
                                  detailID:int = -1, detailArgs:Array = null )
        {
            CFG::dbg{ trace( "new SQLError( " + [operation,details,message,id,detailID,detailArgs].join(", ") + " )"; }
            super( message, id );
            this.name = "SQLError";
            
            if( !detailArgs )
            {
                detailArgs = [];
            }

            _operation       = operation;
            _details         = details;
            _detailID        = detailID;
            _detailArguments = detailArgs;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get operation():String { return _operation; }
        
        [API(CONFIG::AIR_1_0)]
        public function get details():String { return _details; }
        
        [API(CONFIG::AIR_1_0)]
        public function get detailID():int { return _detailID; }
        
        [API(CONFIG::AIR_1_0)]
        public function get detailArguments():Array { return _detailArguments; }
        
        /* TODO:
           implement toString
        */
        
    }
}