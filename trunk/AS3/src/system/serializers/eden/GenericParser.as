/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  - Marc Alcaraz <ekameleon@gmail.com>
*/

package system.serializers.eden
    {
    
	/**
	 * The GenericParser static tool class.
	 */
    public class GenericParser
        {
        	
        /**
         * @private
         */
        private var _source:String;
        
		/**
		 * The current character to parse.
		 */
        public var  ch:String;
        
		/**
		 * The current parser position in the string expression to parse.
		 */
        public var  pos:uint;
        
		/**
		 * Indicates the String source representation of the parser (read-only).
		 */
        public function get source():String
            {
            return _source;
            }
        
		/**
		 * Indicates if the parser use the verbose mode.
		 */
        public static var verbose:Boolean = false;
        
		/**
		 * Creates a new GenericParser instance.
		 * @param source The string expression to parse.
		 */
        public function GenericParser( source:String )
            {
            _source = source;
            pos    = 0;
            ch     = "";
            }

		/**
		 * Debugs the parser if the verbose mode is <code class="prettyprint">true</code>.
		 */
        public function debug( str:String ):void
            {
            if( verbose )
                {
                trace( str );
                }
            }
        
		/**
		 * Returns the current char in the parse process.
		 * @return the current char in the parse process.
		 */
        public function getChar():String
            {
            return source.charAt( pos );
            }        
        
		/**
		 * Returns the char in the source to parse at the specified position.
		 * @return the char in the source to parse at the specified position.
		 */
        public function getCharAt( pos:uint ):String
            {
            return source.charAt( pos );
            }

		/**
		 * Returns the next character in the source of this parser.
		 * @return the next character in the source of this parser.
		 */
        public function next():String
            {
            ch = getChar();
            pos++;
            debug( "["+ch+"]" );
            return ch;
            }
        
		/**
		 * Indicates if the source parser has more char.
		 */
        public function hasMoreChar():Boolean
            {
            return pos <= (source.length-1);
            }

		/**
		 * The evaluate process.
		 * This method must be overriding.
		 */
        public function eval():*
            {
            return undefined;
            }
        
		/**
		 * Evaluates the passed-in source and returns the 
		 */
        public static function evaluate( source:String ):*
            {
            var parser:GenericParser = new GenericParser( source );
            return parser.eval();
            }
        
		/**
		 * Indicates if the specified character is an alpha (A-Z or a-z) character.
		 */
        public static function isAlpha( c:String ):Boolean
            {
            return (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z"));
            }
    
		/**
		 * Indicates if the specified character is an ASCII character.
		 */
        public static function isASCII( c:String ):Boolean
            {
            return c.charCodeAt( 0 ) <= 255;
            }
        
		/**
		 * Indicates if the specified character is a digit.
		 */
        public static function isDigit( c:String ):Boolean
            {
            return ("0" <= c) && (c <= "9");
            }
        
		/**
		 * Indicates if the specified character is a hexadecimal digit.
		 */
        public static function isHexDigit( c:String ):Boolean
            {
            return isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f"));
            }
        
		/**
		 * Indicates if the specified character is a unicode character.
		 */
        public static function isUnicode( c:String ):Boolean
            {
            return c.charCodeAt( 0 ) > 255;
            }
        
        }
    
    }

