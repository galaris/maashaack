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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    import system.Strings;
    
    /**
    * Char class
    * 
    * note:
    * very basic implementation for now based on ASCII
    * and so http://www.ietf.org/rfc/rfc20.txt
    * later we should connect it to Unicode class and Unicode cateogories
    * or maybe do another CharUTF class
    */
    public class Char
    {
        private var _c:String;
        
        public static const NUL:Char  = new Char( "\u0000" ); //null
        public static const SOH:Char  = new Char( "\u0001" ); //start of heading
        public static const STX:Char  = new Char( "\u0002" ); //start of text
        public static const ETX:Char  = new Char( "\u0003" ); //end of test
        public static const EOT:Char  = new Char( "\u0004" ); //end of transmission
        public static const ENQ:Char  = new Char( "\u0005" ); //enquiry
        public static const ACK:Char  = new Char( "\u0006" ); //acknowledge
        public static const BEL:Char  = new Char( "\u0007" ); //bell
        public static const BS:Char   = new Char( "\u0008" ); //backspace
        public static const TAB:Char  = new Char( "\u0009" ); //horizontal tab
        public static const LF:Char   = new Char( "\u000A" ); //NL line feed, new line
        public static const VT:Char   = new Char( "\u000B" ); //vertical tab
        public static const FF:Char   = new Char( "\u000C" ); //NP form feed, new page
        public static const CR:Char   = new Char( "\u000D" ); //carriage return
        public static const SO:Char   = new Char( "\u000E" ); //shift out
        public static const SI:Char   = new Char( "\u000F" ); //shift in
        public static const DLE:Char  = new Char( "\u0010" ); //data link escape
        public static const DC1:Char  = new Char( "\u0011" ); //device control 1
        public static const DC2:Char  = new Char( "\u0012" ); //device control 2
        public static const DC3:Char  = new Char( "\u0013" ); //device control 3
        public static const DC4:Char  = new Char( "\u0014" ); //device control 4
        public static const NAK:Char  = new Char( "\u0015" ); //negative acknowledge
        public static const SYN:Char  = new Char( "\u0016" ); //synchronous idle
        public static const ETB:Char  = new Char( "\u0017" ); //end of transmission block
        public static const CAN:Char  = new Char( "\u0018" ); //cancel
        public static const EM:Char   = new Char( "\u0019" ); //end of medium
        public static const SUB:Char  = new Char( "\u001A" ); //substitute
        public static const ESC:Char  = new Char( "\u001B" ); //escape
        public static const FS:Char   = new Char( "\u001C" ); //file separator
        public static const GS:Char   = new Char( "\u001D" ); //group separator
        public static const RS:Char   = new Char( "\u001E" ); //record separator
        public static const US:Char   = new Char( "\u001F" ); //unit separator
        public static const DEL:Char  = new Char( "\u007F" ); //DEL
        
        public static const space:Char              = new Char( " " );
        public static const exclamationPoint:Char   = new Char( "!" );
        public static const quotationMarks:Char     = new Char( "\"" );
        public static const numberSign:Char         = new Char( "#" );
        public static const dollarSign:Char         = new Char( "$" );
        public static const percent:Char            = new Char( "%" );
        public static const ampersand:Char          = new Char( "&" );
        public static const apostrophe:Char         = new Char( "\'" );
        public static const openingParenthesis:Char = new Char( "(" );
        public static const closingParenthesis:Char = new Char( ")" );
        public static const asterisk:Char           = new Char( "*" ); //closing single quotation mark, acute accent
        public static const plus:Char               = new Char( "+" );
        public static const comma:Char              = new Char( "," );
        public static const minus:Char              = new Char( "-" ); //hyphen
        public static const period:Char             = new Char( "." ); //decimal point
        public static const slash:Char              = new Char( "/" ); //slant
        public static const colon:Char              = new Char( ":" );
        public static const semiColon:Char          = new Char( ";" );
        public static const lessThan:Char           = new Char( "<" );
        public static const equals:Char             = new Char( "=" );
        public static const greaterThen:Char        = new Char( ">" );
        public static const questionMark:Char       = new Char( "?" );
        public static const commercialAt:Char       = new Char( "@" );
        public static const openingBracket:Char     = new Char( "[" );
        public static const backslash:Char          = new Char( "\\" ); //reverse slant
        public static const closingBracket:Char     = new Char( "]" );
        public static const circumflex:Char         = new Char( "^" );
        public static const underline:Char          = new Char( "_" );
        public static const graveAccent:Char        = new Char( "`" );
        public static const openingBrace:Char       = new Char( "{" );
        public static const pipe:Char               = new Char( "|" ); //vertical line
        public static const closingBrace:Char       = new Char( "}" );
        public static const tilde:Char              = new Char( "~" ); //overline, general accent
        
        public static var controls:Array = [ NUL, SOH, STX, ETX, EOT, ENQ, ACK, BEL,
                                              BS, TAB,  LF,  VT,  FF,  CR,  SO,  SI,
                                             DLE, DC1, DC2, DC3, DC4, NAK, SYN, ETB,
                                             CAN,  EM, SUB, ESC,  FS,  GS,  RS,  US,
                                             DEL ];
        
        public static var symbols:Array  = [ space, exclamationPoint, quotationMarks, numberSign, dollarSign,
                                             percent, ampersand, apostrophe, openingParenthesis, closingParenthesis,
                                             asterisk, plus, comma, minus, period, slash, colon, semiColon,
                                             lessThan, equals, greaterThen, questionMark, commercialAt,
                                             openingBracket, backslash, closingBracket, circumflex, underline,
                                             graveAccent, openingBrace, pipe, closingBrace, tilde ];
        
        
        public function Char( str:String = "", index:uint = 0 )
        {
            _c = str.charAt( index );
        }
        
        
        public static function fromNumber( num:Number ):Char
        {
            return new Char( String.fromCharCode( num ) );
        }
        
        public static function isASCII( c:String, index:uint = 0, extended:Boolean = false ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isASCII( extended );
        }
        
        public static function isControl( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isControl();
        }
        
        public static function isDigit( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isDigit();
        }
        
        public static function isHexDigit( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isHexDigit();
        }
        
        public static function isLetter( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isLetter();
        }
        
        public static function isLetterOrDigit( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isLetterOrDigit();
        }
        
        public static function isLower( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isLower();
        }
        
        public static function isSymbol( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isSymbol();
        }
        
        public static function isUnicode( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isUnicode();
        }
        
        public static function isUpper( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isUpper();
        }
        
        public static function isWhiteSpace( c:String, index:uint = 0 ):Boolean
        {
            var ch:Char = new Char( c, index );
            return ch.isWhiteSpace();
        }
        
        public function isASCII( extended:Boolean = false ):Boolean
        {
            var max:uint = 128;
            
            if( extended )
            {
                max = 255;
            }
            
            return _c.charCodeAt( 0 ) < max;
        }
        
        public function isControl():Boolean
        {
            for( var i:int = 0; i<controls.length; i++ )
            {
                if( _c == controls[i].toString() )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        public function isDigit():Boolean
        {
            return ("0" <= _c) && (_c <= "9");
        }
        
        public function isHexDigit():Boolean
        {
            return isDigit() || (("A" <= _c) && (_c <= "F")) || (("a" <= _c) && (_c <= "f"));
        }
        
        public function isLetter():Boolean
        {
            return isUpper() || isLower();
        }
        
        public function isLetterOrDigit():Boolean
        {
            return isLetter() || isDigit();
        }
        
        public function isLower():Boolean
        {
            return ("a" <= _c) && (_c <= "z");
        }
        
        public function isSymbol():Boolean
        {
            for( var i:int = 0; i<symbols.length; i++ )
            {
                if( _c == symbols[i].toString() )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        public function isUnicode():Boolean
        {
            return _c.charCodeAt( 0 ) > 255;
        }
        
        public function isUpper():Boolean
        {
            return ("A" <= _c) && (_c <= "Z");
        }
        
        public function isWhiteSpace():Boolean
        {
            /* note:
               when will do the unicode implementation
               we should refactore Strings
               to separate white spaces, separatores, etc.
            */
            var ws:Array = Strings.whiteSpaceChars
            
            for( var i:int =0; i<ws.length; i++ )
            {
                if( _c == ws[i] )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        public function toNumber():Number
        {
            return _c.charCodeAt( 0 );
        }
        
        public function toHexadecimal():String
        {
            var hex:String = _c.charCodeAt( 0 ).toString( 16 );
            return (hex.length == 1) ? "0"+hex: hex;
        }
        
        public function toOctal():String
        {
            var oct:String = _c.charCodeAt( 0 ).toString( 8 );
            
            while( oct.length < 3 )
            {
                oct = "0"+oct;
            }
            
            return oct;
        }
        
        public function toString():String
        {
            return _c;
        }
        
        public function valueOf():String
        {
            return _c;
        }
        
    }
}

