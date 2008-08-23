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
    import buRRRn.ASTUce.framework.*;
    import system.serializers.eden.GenericParser;
    
    public class GenericParserTest extends TestCase
        {
        
        private var _alpha:String          = "abcdefghijklmnopqrstuvwxyz";
        private var _alphaUp:String        = _alpha.toUpperCase();
        private var _digit:String          = "0123456789";
        private var _alphaHex:String       = "abcdef";
        private var _hex:String            = _digit + _alphaHex;
        private var _hexUp:String          = _digit + _alphaHex.toUpperCase();
        private var _specialChar:String    = "&~#\"\'{([-|`_\\^@)]=+¨^¤%*,?;.:/!§<>ª¹²³";
        // private var _specialLetter:String  = "éèçà€¥$£©®™";
        private var _greekLetter:String    = "αβγδεζηθικλμνξοπ";
        private var _unicodeSample:String  = "▀▄█▌▐░▒▓■□▲►▼◄☺☻♀♂♠♣♥♦";
        //more ?
        
        public function GenericParserTest( name:String="" )
            {
            super( name );
            }
        
        public function testLoop():void
            {
            var gp:GenericParser = new GenericParser( "hello" );
            var loop:Array       = [ "h", "e", "l", "l", "o" ];
            
            var i:int = 0;
            while( gp.hasMoreChar() )
                {
                assertEquals( gp.next(), loop[i] );
                i++;
                }
            
            assertFalse( gp.hasMoreChar() );
            }
        
        public function testAlpha():void
            {
            var alpha:Array = (_alpha+_alphaUp).split("");
            var nonalpha:Array = (_digit+_greekLetter+_specialChar).split("");
            
            for( var i:int=0; i<alpha.length; i++ )
                {
                assertTrue( GenericParser.isAlpha( alpha[i] ), alpha[i] + " is not Alpha" );
                }
            
            for( var j:int=0; j<nonalpha.length; j++ )
                {
                assertFalse( GenericParser.isAlpha( nonalpha[j] ), nonalpha[j] + " is Alpha" );
                }
            
            }
        
        public function testASCII():void
            {
            var ascii:Array = (_alpha+_alphaUp+_digit+_specialChar).split("");
            var nonascii:Array = (_greekLetter).split("");
            
            for( var i:int=0; i<ascii.length; i++ )
                {
                assertTrue( GenericParser.isASCII( ascii[i] ), ascii[i] + " is not ASCII" );
                }
            
            for( var j:int=0; j<nonascii.length; j++ )
                {
                assertFalse( GenericParser.isASCII( nonascii[j] ), nonascii[j] + " is ASCII" );
                }
            
            }        
        
        public function testDigit():void
            {
            var digit:Array = _digit.split("");
            var nondigit:Array = (_alpha+_specialChar).split("");
            
            for( var i:int=0; i<digit.length; i++ )
                {
                assertTrue( GenericParser.isDigit( digit[i] ), digit[i] + " is not Digit" );
                }
            
            for( var j:int=0; j<nondigit.length; j++ )
                {
                assertFalse( GenericParser.isDigit( nondigit[j] ), nondigit[j] + " is Digit" );
                }
            
            }
        
        public function testHexDigit():void
            {
            var hexdigit:Array = (_hex+_hexUp).split("");
            var nonhexdigit:Array = (_alpha.split(_alphaHex).join("")+_alphaUp.split(_alphaHex.toUpperCase()).join("")).split("");
            
            for( var i:int=0; i<hexdigit.length; i++ )
                {
                assertTrue( GenericParser.isHexDigit( hexdigit[i] ), hexdigit[i] + " is not HexDigit" );
                }
            
            for( var j:int=0; j<nonhexdigit.length; j++ )
                {
                assertFalse( GenericParser.isHexDigit( nonhexdigit[j] ), nonhexdigit[j] + " is HexDigit" );
                }
            
            }
        
        public function testUnicode():void
            {
            var unicode:Array = (_unicodeSample+_greekLetter).split("");
            var nonunicode:Array = (_alpha+_alphaUp+_digit).split("");
            
            for( var i:int=0; i<unicode.length; i++ )
                {
                assertTrue( GenericParser.isUnicode( unicode[i] ), unicode[i] + " is not Unicode" );
                }
            
            for( var j:int=0; j<nonunicode.length; j++ )
                {
                assertFalse( GenericParser.isUnicode( nonunicode[j] ), nonunicode[j] + " is Unicode" );
                }
            
            }
        
        }
    
    }
