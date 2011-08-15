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

/* note:
this test should move to system.text.parser
but we can keep it here for now
 */
package system.serializers.eden
{
    import library.ASTUce.framework.*;

    import core.chars.isASCII;
    import core.chars.isAlpha;
    import core.chars.isDigit;
    import core.chars.isHexDigit;
    import core.chars.isUnicode;

    import system.text.parser.GenericParser;
    
    public class GenericParserTest extends TestCase
    {
        public function GenericParserTest( name:String = "" )
        {
            super(name);
        }
        
        public function testLoop():void
        {
            var gp:GenericParser = new GenericParser("hello");
            var loop:Array = ["h", "e", "l", "l", "o"];
            var i:int = 0;
            while( gp.hasMoreChar() )
            {
                assertEquals(gp.next(), loop[i]);
                i++;
            }
            assertFalse(gp.hasMoreChar());
        }
        
        public function testAlpha():void
        {
            var i:int ;
            var l:int ;
            var alpha:Array = (_alpha + _alphaUp).split("");
            var nonalpha:Array = (_digit + _greekLetter + _specialChar).split("");
            
            l = alpha.length ;
            for( i = 0 ; i < l ; i++ )
            {
                assertTrue(isAlpha(alpha[i]), alpha[i] + " is not Alpha");
            }
            
            l = nonalpha.length ;
            for( i = 0 ; i < l ; i++ )
            {
                assertFalse(isAlpha(nonalpha[i]), nonalpha[i] + " is Alpha");
            }
        }
        
        public function testASCII():void
        {
            var ascii:Array = (_alpha + _alphaUp + _digit + _specialChar).split("");
            var nonascii:Array = (_greekLetter).split("");
            
            for( var i:int = 0;i < ascii.length;i++ )
            {
                assertTrue(isASCII(ascii[i]), ascii[i] + " is not ASCII");
            }
            
            for( var j:int = 0;j < nonascii.length;j++ )
            {
                assertFalse(isASCII(nonascii[j]), nonascii[j] + " is ASCII");
            }
        } 
        
        public function testDigit():void
        {
            var digit:Array = _digit.split("");
            var nondigit:Array = (_alpha + _specialChar).split("");
            
            for( var i:int = 0;i < digit.length;i++ )
            {
                assertTrue(isDigit(digit[i]), digit[i] + " is not Digit");
            }
            
            for( var j:int = 0;j < nondigit.length;j++ )
            {
                assertFalse(isDigit(nondigit[j]), nondigit[j] + " is Digit");
            }
        }
        
        public function testHexDigit():void
        {
            var hexdigit:Array = (_hex + _hexUp).split("");
            var nonhexdigit:Array = (_alpha.split(_alphaHex).join("") + _alphaUp.split(_alphaHex.toUpperCase()).join("")).split("");
            
            for( var i:int = 0;i < hexdigit.length;i++ )
            {
                assertTrue(isHexDigit(hexdigit[i]), hexdigit[i] + " is not HexDigit");
            }
            
            for( var j:int = 0;j < nonhexdigit.length;j++ )
            {
                assertFalse(isHexDigit(nonhexdigit[j]), nonhexdigit[j] + " is HexDigit");
            }
        }
        
        public function testUnicode():void
        {
            var unicode:Array = (_unicodeSample + _greekLetter).split("");
            var nonunicode:Array = (_alpha + _alphaUp + _digit).split("");
            
            for( var i:int = 0;i < unicode.length;i++ )
            {
                assertTrue(isUnicode(unicode[i]), unicode[i] + " is not Unicode");
            }
            
            for( var j:int = 0;j < nonunicode.length;j++ )
            {
                assertFalse(isUnicode(nonunicode[j]), nonunicode[j] + " is Unicode");
            }
        }
        
        private var _alpha:String = "abcdefghijklmnopqrstuvwxyz";
        private var _alphaUp:String = _alpha.toUpperCase();
        private var _digit:String = "0123456789";
        private var _alphaHex:String = "abcdef";
        private var _hex:String = _digit + _alphaHex;
        private var _hexUp:String = _digit + _alphaHex.toUpperCase();
        private var _specialChar:String = "&~#\"\'{([-|`_\\^@)]=+¨^¤%*,?;.:/!§<>ª¹²³";
        // private var _specialLetter:String  = "éèçà€¥$£©®™";
        private var _greekLetter:String = "αβγδεζηθικλμνξοπ";
        private var _unicodeSample:String = "▀▄█▌▐░▒▓■□▲►▼◄☺☻♀♂♠♣♥♦";
    }
}
