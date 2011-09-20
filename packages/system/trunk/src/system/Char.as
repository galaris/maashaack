/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system
{
    import core.strings.whiteSpaceChars;

    /**
     * The Char class.
     * <p><b>Note:</b> Very basic implementation for now based on ASCII and so <a href='http://www.ietf.org/rfc/rfc20.txt'>http://www.ietf.org/rfc/rfc20.txt</a>
     * later we should connect it to <code>Unicode</code> class and Unicode cateogories or maybe do another CharUTF class.</p>
     */
    public class Char
    {
        private var _c:String;
        
        private static var _ch:Char = new Char( "" ); //char reused in static methods
        
        private static var _alphabetic:String = "abcdefghijklmnopqrstuvwxyz";
        //private static var _digit:String      = "0123456789";
        
        /**
         * The "null" unicode character.
         */
        public static const NUL:Char  = new Char( "\u0000" ) ;
        
        /**
         * The "start of heading" unicode character.
         */
        public static const SOH:Char  = new Char( "\u0001" ) ;
        
        /**
         * The "start of text" unicode character.
         */
        public static const STX:Char  = new Char( "\u0002" ) ;
        
        /**
         * The "end of test" unicode character.
         */        
        public static const ETX:Char  = new Char( "\u0003" );
        
        /**
         * The "end of transmission" unicode character.
         */        
        public static const EOT:Char  = new Char( "\u0004" );
        
        /**
         * The "enquiry" unicode character.
         */
        public static const ENQ:Char  = new Char( "\u0005" );
        
        /**
         * The "acknowledge" unicode character.
         */
        public static const ACK:Char  = new Char( "\u0006" );
        
        /**
         * The "bell" unicode character.
         */
        public static const BEL:Char  = new Char( "\u0007" );
        
        /**
         * The "backspace" unicode character.
         */
        public static const BS:Char   = new Char( "\u0008" );
        
        /**
         * The "horizontal tab" unicode character.
         */
        public static const TAB:Char  = new Char( "\u0009" );
        
        /**
         * The "NL line feed, new line" unicode character.
         */
        public static const LF:Char   = new Char( "\u000A" );
        
        /**
         * The "vertical tab" unicode character.
         */
        public static const VT:Char   = new Char( "\u000B" );
        
        /**
         * The "NP form feed, new page" unicode character.
         */
        public static const FF:Char   = new Char( "\u000C" );
        
        /**
         * The "carriage return" unicode character.
         */
        public static const CR:Char   = new Char( "\u000D" );
        
        /**
         * The "shift out" unicode character.
         */
        public static const SO:Char   = new Char( "\u000E" );
        
        /**
         * The "shift in" unicode character.
         */
        public static const SI:Char   = new Char( "\u000F" );
        
        /**
         * The "data link escape" unicode character.
         */
        public static const DLE:Char  = new Char( "\u0010" );
        
        /**
         * The "device control 1" unicode character.
         */
        public static const DC1:Char  = new Char( "\u0011" );
        
        /**
         * The "device control 2" unicode character.
         */
        public static const DC2:Char  = new Char( "\u0012" );
        
        /**
         * The "device control 3" unicode character.
         */
        public static const DC3:Char  = new Char( "\u0013" );
        
        /**
         * The "device control 4" unicode character.
         */
        public static const DC4:Char  = new Char( "\u0014" );
        
        /**
         * The "negative acknowledge" unicode character.
         */
        public static const NAK:Char  = new Char( "\u0015" );
        
        /**
         * The "synchronous idle" unicode character.
         */
        public static const SYN:Char  = new Char( "\u0016" );
        
        /**
         * The "end of transmission block" unicode character.
         */
        public static const ETB:Char = new Char( "\u0017" );
        
        /**
         * The "cancel" unicode character.
         */
        public static const CAN:Char = new Char( "\u0018" );
        
        /**
         * The "end of medium" unicode character.
         */
        public static const EM:Char  = new Char( "\u0019" );
        
        /**
         * The "substitute" unicode character.
         */
        public static const SUB:Char = new Char( "\u001A" );
        
        /**
         * The "escape" unicode character.
         */
        public static const ESC:Char = new Char( "\u001B" );
        
        /**
         * The "file separator" unicode character.
         */
        public static const FS:Char = new Char( "\u001C" );
        
        /**
         * The "group separator" unicode character.
         */
        public static const GS:Char   = new Char( "\u001D" );
        
        /**
         * The "record separator" unicode character.
         */
        public static const RS:Char   = new Char( "\u001E" );
        
        /**
         * The "unit separator" unicode character.
         */
        public static const US:Char   = new Char( "\u001F" );
        
        /**
         * The "DEL" unicode character.
         */
        public static const DEL:Char  = new Char( "\u007F" );
        
        
        /**
         * The "space" unicode character.
         */
        public static const space:Char = new Char( " " );
        
        /**
         * The "!" unicode character.
         */
        public static const exclamationPoint:Char = new Char( "!" );
        
        /**
         * The "\" unicode character.
         */
        public static const quotationMarks:Char = new Char( "\"" );
        
        /**
         * The "#" unicode character.
         */
        public static const numberSign:Char = new Char( "#" );
        
        /**
         * The "$" unicode character.
         */
        public static const dollarSign:Char = new Char( "$" );
        
        /**
         * The percent unicode character.
         */
        public static const percent:Char = new Char( "%" );
        
        /**
         * The ampersand unicode character.
         */
        public static const ampersand:Char = new Char( "&" );
        
        /**
         * The apostrophe unicode character.
         */
        public static const apostrophe:Char = new Char( "\'" );
        
        /**
         * The "" unicode character.
         */
        public static const openingParenthesis:Char = new Char( "(" );
        
        /**
         * The ")" unicode character.
         */
        public static const closingParenthesis:Char = new Char( ")" );
        
        /**
         * The asterisk closing single quotation mark, acute accent unicode character.
         */
        public static const asterisk:Char = new Char( "*" ) ;
        
        /**
         * The plus unicode character.
         */
        public static const plus:Char = new Char( "+" );
        
        /**
         * The comma unicode character.
         */
        public static const comma:Char = new Char( "," );
        
        /**
         * The minus (hyphen) unicode character.
         */
        public static const minus:Char = new Char( "-" );
        
        /**
         * The decimal point (period) unicode character.
         */
        public static const period:Char = new Char( "." );
        
        /**
         * The slash (slant) unicode character.
         */
        public static const slash:Char = new Char( "/" );
        
        /**
         * The colon ":" unicode character.
         */
        public static const colon:Char = new Char( ":" );
        
        /**
         * The semiColon ";" unicode character.
         */
        public static const semiColon:Char = new Char( ";" );
        
        /**
         * The lessThan "&lt;" unicode character.
         */
        public static const lessThan:Char = new Char( "<" );
        
        /**
         * The equals unicode character.
         */
        public static const equals:Char = new Char( "=" );
        
        /**
         * The greaterThen "&gt;" unicode character.
         */
        public static const greaterThen:Char = new Char( ">" );
        
        /**
         * The questionMark "?" unicode character.
         */
        public static const questionMark:Char = new Char( "?" );
        
        /**
         * The "" unicode character.
         */
        public static const commercialAt:Char = new Char( "@" );
        
        /**
         * The "" unicode character.
         */
        public static const openingBracket:Char = new Char( "[" );
        
        /**
         * The reverse slant "\\" unicode character.
         */
        public static const backslash:Char = new Char( "\\" ); 
        
        /**
         * The closing bracket "]" character.
         */
        public static const closingBracket:Char = new Char( "]" );
        
        /**
         * The circumflex "^" character.
         */
        public static const circumflex:Char = new Char( "^" );
        
        /**
         * The underline "_" character.
         */
        public static const underline:Char = new Char( "_" );
        
        /**
         * The grave accent "`" character.
         */
        public static const graveAccent:Char = new Char( "`" );
        
        /**
         * The opening brace "{" character.
         */
        public static const openingBrace:Char = new Char( "{" );
        
        /**
         * The vertical line "|" character.
         */
        public static const pipe:Char = new Char( "|" ); //
        
        /**
         * The closing brace "}" character.
         */
        public static const closingBrace:Char = new Char( "}" );
        
        /**
         * The "-" overline, general accent character.
         */
        public static const tilde:Char = new Char( "~" ); 
        
        
        /**
         * The Array representation of all ASCII controls characters.
         */
        public static var controls:Array = [ NUL, SOH, STX, ETX, EOT, ENQ, ACK, BEL,
                                              BS, TAB,  LF,  VT,  FF,  CR,  SO,  SI,
                                             DLE, DC1, DC2, DC3, DC4, NAK, SYN, ETB,
                                             CAN,  EM, SUB, ESC,  FS,  GS,  RS,  US,
                                             DEL ];
        
        /**
         * The Array representation of all ASCII symbols characters.
         */
        public static var symbols:Array  = [ space, exclamationPoint, quotationMarks, numberSign, dollarSign,
                                             percent, ampersand, apostrophe, openingParenthesis, closingParenthesis,
                                             asterisk, plus, comma, minus, period, slash, colon, semiColon,
                                             lessThan, equals, greaterThen, questionMark, commercialAt,
                                             openingBracket, backslash, closingBracket, circumflex, underline,
                                             graveAccent, openingBrace, pipe, closingBrace, tilde ];
        
        
        private static var _alphabetics:Array;
        private static var _alphabeticsUpper:Array;
        
        private static function _splitToChars( str:String, modifier:String = "toString" ):Array
        {
            var arr:Array = [];
            var i:int;
            var l:int = str.length ;
            for( i=0 ; i<l ; i++ )
            {
                arr.push( new Char( String( str[modifier]() ) , i ) );
            }
            
            return arr;
        }
        
        /**
        * The Array representation of all ASCII alphabetics characters
        */
        public static function get alphabetics():Array
        {
            if( _alphabetics )
            {
                return _alphabetics;
            }
            
            _alphabetics = _splitToChars( _alphabetic );
            
            return _alphabetics;
        }
        
        /**
        * The Array representation of all ASCII alphabetics characters (upper case).
        */
        public static function get alphabeticsUpper():Array
        {
            if( _alphabeticsUpper )
            {
                return _alphabeticsUpper;
            }
            
            _alphabeticsUpper = _splitToChars( _alphabetic, "toUpperCase" );
            
            return _alphabeticsUpper;
        }
        
        /**
         * Creates a new Char instance.
         * @param The String expression use to get a char.
         * @param The index of the character to get in the String (default 0).
         */
        public function Char( str:String = "" , index:uint = 0 )
        {
            _c = str.charAt( index );
        }
        
        /**
         * Determinates the code of the character.
         */
        public function get code():Number
        {
            return _c.charCodeAt( 0 );
        }
        
        /**
         * @private
         */
        public function set code( num:Number ):void
        {
            _c = String.fromCharCode( num );
        }
        
        /**
         * Determinates the value of the character.
         */
        public function get value():String
        {
            return _c;
        }
        
        /**
         * @private
         */
        public function set value( str:String ):void
        {
            _c = str.charAt( 0 );
        }
        
        /**
         * Returns the Char representation of the specified Number value.
         * @return the Char representation of the specified Number value.
         */
        public static function fromNumber( num:Number ):Char
        {
            return new Char( String.fromCharCode( num ) );
        }
        
        public static function isASCII( c:String, index:uint = 0, extended:Boolean = false ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isASCII( extended );
        }
        
        public static function isContained( c:String, index:uint = 0, charset:String = "" ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isContained( charset );
        }
        
        public static function isControl( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isControl();
        }
        
        /**
         * Indicates if the specified character is a digit character.
         */
        public static function isDigit( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isDigit();
        }
        
        /**
         * Indicates if the specified character is an hexadecimal digit character.
         */
        public static function isHexDigit( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isHexDigit();
        }
        
        /**
         * Indicates if the specified character is a letter.
         */
        public static function isLetter( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isLetter();
        }
        
        /**
         * Indicates if the specified character is a letter or a digit.
         */
        public static function isLetterOrDigit( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isLetterOrDigit();
        }
        
        /**
         * Indicates if the specified character is a lower case.
         */
        public static function isLower( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isLower();
        }
        
        /**
         * Indicates if the specified character is a symbol.
         */
        public static function isSymbol( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isSymbol();
        }
        
        /**
         * Indicates if the specified character is a unicode char.
         */
        public static function isUnicode( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isUnicode();
        }
        
        /**
         * Indicates if the specified character is a upper char.
         */
        public static function isUpper( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isUpper();
        }
        
        /**
         * Indicates if the specified character is a whitespace char.
         */
        public static function isWhiteSpace( c:String, index:uint = 0 ):Boolean
        {
            _ch.value = c.charAt( index );
            return _ch.isWhiteSpace();
        }
        
        /**
         * Indicates if the character is an ASCII character.
         * @param extended Indicates if the method test an extented ASCII character.
         */
        public function isASCII( extended:Boolean = false ):Boolean
        {
            var max:uint = 128;
            
            if( extended )
            {
                max = 255;
            }
            
            return code < max ;
        }
        
        /**
         * Indicates if the character is contained in a serie of chars (or charset)
         * @param charset a list of characters
         */
        public function isContained( charset:String ):Boolean
        {
            if( (charset == null) || (charset.length == 0) )
            {
                return false;
            }
            
            for( var i:int = 0; i< charset.length; i++ )
            {
                if( _c == charset.charAt( i ) )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        /**
         * Indicates if the character is a control representation.
         */
        public function isControl():Boolean
        {
            var l:int = controls.length;
            
            for( var i:int = 0; i < l ; i++ )
            {
                if( _c == controls[i].toString() )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        /**
         * Indicates if the character is a digit representation.
         */
        public function isDigit():Boolean
        {
            return ("0" <= _c) && (_c <= "9") ;
        }
        
        /**
         * Indicates if the character is a hexadecimal digit representation.
         */
        public function isHexDigit():Boolean
        {
            return isDigit() || (("A" <= _c) && (_c <= "F")) || (("a" <= _c) && (_c <= "f")) ;
        }
        
        /**
         * Indicates if the character is a uppercase or a lowercase letter.
         */
        public function isLetter():Boolean
        {
            return isUpper() || isLower();
        }
        
        /**
         * Indicates if the character is a letter or a digit.
         */
        public function isLetterOrDigit():Boolean
        {
            return isLetter() || isDigit();
        }
        
        /**
         * Indicates if the character is lowercase.
         */
        public function isLower():Boolean
        {
            return ("a" <= _c) && (_c <= "z");
        }
        
        /**
         * Indicates if the character is a symbol.
         */
        public function isSymbol():Boolean
        {
            var l:int = symbols.length;
            
            for( var i:int = 0; i<l ; i++ )
            {
                if( _c == symbols[i].toString() )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        /**
         * Indicates if the character is unicode.
         */
        public function isUnicode():Boolean
        {
            return _c.charCodeAt( 0 ) > 255;
        }
        
        /**
         * Indicates if the character is uppercase.
         */
        public function isUpper():Boolean
        {
            return ("A" <= _c) && (_c <= "Z");
        }
        
        /**
         * Indicates if the character is a whitespace.
         */
        public function isWhiteSpace():Boolean
        {
            /* note:
               when will do the unicode implementation
               we should refactore Strings
               to separate white spaces, separatores, etc.
            */
            var ws:Array = whiteSpaceChars;
            var l:int    = ws.length;
            for( var i:int ; i < l ; i++ )
            {
                if( _c == ws[i] )
                {
                    return true;
                }
            }
            return false;
        }
        
        /**
         * Converts the character in this code number representation.
         */
        public function toNumber():Number
        {
            return code;
        }
        
        /**
         * Converts the character in this hexadecimal code number representation.
         */
        public function toHexadecimal():String
        {
            var hex:String = code.toString( 16 );
            return (hex.length == 1) ? "0" + hex : hex ;
        }
        
        /**
         * Converts the character in this octal code number representation.
         */
        public function toOctal():String
        {
            var oct:String = code.toString( 8 );
            
            while( oct.length < 3 )
            {
                oct = "0"+oct;
            }
            
            return oct;
        }
        
        public function toLower():Char
        {
            return new Char( _c.toLowerCase() );
        }
        
        public function toUpper():Char
        {
            return new Char( _c.toUpperCase() );
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return _c;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function valueOf():String
        {
            return _c;
        }
        
    }
}

