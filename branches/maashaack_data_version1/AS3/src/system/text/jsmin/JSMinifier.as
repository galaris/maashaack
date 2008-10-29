
package system.text.jsmin 
{
    import system.text.parser.GenericParser;                

    /**
     * http://fmarcia.info/jsmin/fulljsmin.js
     * @author eKameleon
     */
    public class JSMinifier 
    {
    	
    	/**
    	 * Creates a new JSMinifier instance.
    	 */
    	public function JSMinifier( comment:String , input:String=null , level:int=2 )
    	{
            if ( input == null )
            {
                input      = comment ;
                comment    = "" ;
                this.level = JSMinifierLevel.NORMAL ;	
            }
            else
            {
                this.level = level ;	
            }   	
    	}
    	
        /**
         * The current character to parse.
         */
        public var ch:String;    	
    	
    	/**
    	 * The level of the minimizer.
    	 */
    	public function get level():int
    	{
    		return _level ;
    	}
    	
    	/**
    	 * @private
    	 */
    	public function set level( value:int ):void
    	{
    		_level = ( value < 1 || value > 3 ) ? JSMinifierLevel.NORMAL : value ;  
    	}
    	
        /**
         * The current parser position in the string expression to parse.
         */
        public var  pos:uint;    	
    	
        /**
         * Indicates the String representation of the source to parse (read-only).
         */
        public function get source():String
        {
            return _source;
        }    
        
        /**
         * Eval the source and returns the serialized object.
         */
        public function eval():*
        {
            var value:* = "" ;
            while( hasMoreChar() )
            {
                if( ! GenericParser.isAlpha( ch ) )
                {
                    next( );
                }
            }
            return value;
        }        	
    	
        /**
         * Evaluate the specified string source value with the parser.
         */
        public static function evaluate( comment:String, input:String=null , level:int=2 ):*
        {
            var parser:JSMinifier = new JSMinifier( comment, input, level );
            return parser.eval( ) ;
        }    	
    	
        /**
         * Returns the current char in the parse process.
         * @return the current char in the parse process.
         */
        protected function getChar():String
        {
            return _source.charAt( pos );
        }      	
    	
        /**
         * Indicates if the source parser has more char.
         */
        protected function hasMoreChar():Boolean
        {
            return pos <= (source.length - 1);
        }    	
        
        /**
         * Returns the next character in the source of this parser.
         * @return the next character in the source of this parser.
         */
        protected function next():String
        {
            ch = getChar( );
            pos++;
            return ch;
        }        
        
        /**
         * Returns the next character without getting it.
         * @return the next character without getting it.
         */
        protected function peek():String 
        {
            // TODO _theLookahead = get();
            return _theLookahead ;
        }
        
    	/**
    	 * @private 
    	 */
    	// private static const EOF:int = -1;
    	
    	/**
    	 * @private
    	 */
    	private var _level:int ;
    
        /**
         * @private
         */
        private var _source:String ;
        
        /**
         * @private
         */
        private var _theLookahead:String ;    
    	
    }
}
