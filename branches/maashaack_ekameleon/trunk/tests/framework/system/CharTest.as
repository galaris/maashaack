
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
    import buRRRn.ASTUce.framework.TestCase;

    import core.strings.whiteSpaceChars;

    public class CharTest extends TestCase
    {
        public function CharTest( name:String = "" )
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var str:String = "hello";
            var c0:Char = new Char( str );
            var c1:Char = new Char( str, 1 );
            var c2:Char = new Char( str, 2 );
            var c3:Char = new Char( str, 3 );
            var c4:Char = new Char( str, 4 );
            
            assertEquals( "h", c0 );
            assertEquals( "e", c1 );
            assertEquals( "l", c2 );
            assertEquals( "l", c3 );
            assertEquals( "o", c4 );
            
        }
        
        public function testIsASCII():void
        {
            
            var c0:Char = new Char( "A" );
            var c1:Char = Char.fromNumber( 220 );
            
            assertTrue(  c0.isASCII() );
            assertTrue(  c0.isASCII( true ) );
            assertFalse( c1.isASCII() );
            assertTrue(  c1.isASCII( true ) );
            
            assertTrue( Char.isASCII( "A" ) );
            assertTrue( Char.isASCII( "A", 0, true ) );
            
            assertFalse( Char.isASCII( c1.toString() ) );
            assertTrue( Char.isASCII( c1.toString(), 0, true ) );
            
        }
        
        public function testIsControl():void
        {
            var str:String = Char.controls.join("");
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isControl() );
                assertTrue( Char.isControl( str, i ) );
            }
            
        }
        
        public function testIsDigit():void
        {
            var str:String = "0123456789";
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isDigit() );
                assertTrue( Char.isDigit( str, i ) );
            }
            
        }
        
        public function testIsHexDigit():void
        {
            var str:String = "0123456789ABCDEFabcdef";
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isHexDigit() );
                assertTrue( Char.isHexDigit( str, i ) );
            }
            
        }
        
        public function testIsLower():void
        {
            var str:String = "abcdefghijklmnopqrstuvwxyz";
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isLower() );
                assertTrue( Char.isLower( str, i ) );
            }
        }
        
        public function testIsSymbol():void
        {
            var str:String = Char.symbols.join("");
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isSymbol() );
                assertTrue( Char.isSymbol( str, i ) );
            }
        }
        
        public function testIsUpper():void
        {
            var str:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isUpper() );
                assertTrue( Char.isUpper( str, i ) );
            }
        }
        
        public function testIsLetter():void
        {
            var c0:Char = new Char( "A" );
            var c1:Char = new Char( "s" );
            var c2:Char = new Char( "3" );
            
            assertTrue( c0.isLetter() );
            assertTrue( c1.isLetter() );
            assertFalse( c2.isLetter() );
            
            var str:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isLetter() );
                assertTrue( Char.isLetter( str, i ) );
            }
            
        }
        
        public function testIsLetterOrDigit():void
        {
            var str:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isLetterOrDigit() );
                assertTrue( Char.isLetterOrDigit( str, i ) );
            }
            
        }
        
        public function testIsWhiteSpace():void
        {
            var str:String = whiteSpaceChars.join("");
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isWhiteSpace() );
                assertTrue( Char.isWhiteSpace( str, i ) );
            }
        }
        
        public function testIsUnicode():void
        {
            var str:String = "αβγδεζηθικλμνξοπ";
            for( var i:int = 0; i < str.length; i++ )
            {
                assertTrue( new Char( str, i ).isUnicode() );
                assertTrue( Char.isUnicode( str, i ) );
            }
        }
        
        public function testToNumber():void
        {
            assertEquals( 27, Char.ESC.toNumber() );
            assertEquals( 31, Char.US.toNumber() );
        }
        
        public function testToHexadecimal():void
        {
            assertEquals( "1b", Char.ESC.toHexadecimal() );
            assertEquals( "1f", Char.US.toHexadecimal() );
        }
        
        public function testToOctal():void
        {
            assertEquals( "033", Char.ESC.toOctal() );
            assertEquals( "037", Char.US.toOctal() );
        }
        
    }
}