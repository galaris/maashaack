package system.terminals
{
    /**
    * The TraceConsole is the default console based on the <code>trace()</code> function.
    * 
    * <p>
    * You can not <code>read()</code> or <code>readLine()</code>.
    * </p>
    */
    public final class TraceConsole implements InteractiveConsole
    {
        private var _buffer:String;
        
        public function TraceConsole()
        {
            _buffer = "";
        }
        
        private final function _fastFormat( format:String, ...args ):String
        {
            if( (format == null) || (format == "") )
            {
                return "";
            }
            
            var len:uint = args.length;
            var a:Array;
            
            if( (len == 1) && (args[0] is Array) )
            {
                a   = args[0] as Array;
                len = a.length;
            }
            else
            {
                a = args;
            }
            
            var i:uint;
            for( i=0; i < len; i++ )
            {
                format = format.replace( new RegExp( "\\{"+i+"\\}", "g" ), a[i] );
            }
            
            return format;
        }
        
        private final function _format( messages:Array ):String
        {
            if( messages.length == 0 )
            {
                return "";
            }
            
            var msg:String;
            var format:String;
            
            if( messages[0] is String )
            {
                format = String( messages.shift() );
                msg = _fastFormat( format, messages );
            }
            else
            {
                msg = messages.join( "" );
            }
            
            return msg;
        }
        
        public final function read():String
        {
            return "";
        }
        
        public final function readLine():String
        {
            return "";
        }
        
        public final function write( ...messages ):void
        {
            _buffer += _format( messages );
        }
        
        public final function writeLine( ...messages ):void
        {
            var msg:String = _buffer + _format( messages );
            output( msg );
            _buffer = "";
        }
        
    }
}