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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package core
{
    import library.ASTUce.framework.TestCase;

    public class bitTest extends TestCase
    {
        public function bitTest(name:String="")
        {
            super(name);
        }
        
        public function testToBinaryString():void
        {
            var b0:bit  = new bit(  0 );
            var b1:bit  = new bit(  1 );
            var b2:bit  = new bit(  2 );
            var b3:bit  = new bit(  3 );
            var b4:bit  = new bit(  4 );
            var b5:bit  = new bit(  5 );
            var b6:bit  = new bit(  6 );
            var b7:bit  = new bit(  7 );
            var b8:bit  = new bit(  8 );
            var b9:bit  = new bit(  9 );
            var b10:bit = new bit( 10 );
            var b11:bit = new bit( 11 );
            var b12:bit = new bit( 12 );
            var b13:bit = new bit( 13 );
            var b14:bit = new bit( 14 );
            var b15:bit = new bit( 15 );
            
            
            assertEquals( "0000", b0.toString() );
            assertEquals( "0001", b1.toString() );
            assertEquals( "0010", b2.toString() );
            assertEquals( "0011", b3.toString() );
            assertEquals( "0100", b4.toString() );
            assertEquals( "0101", b5.toString() );
            assertEquals( "0110", b6.toString() );
            assertEquals( "0111", b7.toString() );
            assertEquals( "1000", b8.toString() );
            assertEquals( "1001", b9.toString() );
            assertEquals( "1010", b10.toString() );
            assertEquals( "1011", b11.toString() );
            assertEquals( "1100", b12.toString() );
            assertEquals( "1101", b13.toString() );
            assertEquals( "1110", b14.toString() );
            assertEquals( "1111", b15.toString() );
        }
        
        public function testToDecimalString():void
        {
            var b0:bit  = new bit(  0 );
            var b1:bit  = new bit(  1 );
            var b2:bit  = new bit(  2 );
            var b3:bit  = new bit(  3 );
            var b4:bit  = new bit(  4 );
            var b5:bit  = new bit(  5 );
            var b6:bit  = new bit(  6 );
            var b7:bit  = new bit(  7 );
            var b8:bit  = new bit(  8 );
            var b9:bit  = new bit(  9 );
            var b10:bit = new bit( 10 );
            
            
            assertEquals( "0b", b0.toString(10) );
            assertEquals( "1b", b1.toString(10) );
            assertEquals( "2b", b2.toString(10) );
            assertEquals( "3b", b3.toString(10) );
            assertEquals( "4b", b4.toString(10) );
            assertEquals( "5b", b5.toString(10) );
            assertEquals( "6b", b6.toString(10) );
            assertEquals( "7b", b7.toString(10) );
            assertEquals( "8b", b8.toString(10) );
            assertEquals( "9b", b9.toString(10) );
            assertEquals( "10b", b10.toString(10) );
            
        }
        
        public function testToHexadecimalString():void
        {
            var b15:bit = new bit( 15 );
            var b15_2:bit = new bit( 0xf );
            var b16:bit   = new bit( 16 );
            var b1024:bit = new bit( 1024 );
            
            assertEquals( "0x0f", b15.toString(16) );
            assertEquals( "0x0f", b15_2.toString(16) );
            assertEquals( "0x10", b16.toString(16) );
            assertEquals( "0x0400", b1024.toString(16) );
        }
        
        public function testParse():void
        {
            var b0:bit    = bit.parse( "0101" );
            var b1:bit    = bit.parse( "10000000" );
            var b2:bit    = bit.parse( "100000000000" );
            var b2_1:bit    = bit.parse( "2048", 10 );
            var b2_2:bit    = bit.parse( "0x0800", 16 );
            
            assertEquals( 5, b0 );
            assertEquals( "0101", b0.toString() );
            
            assertEquals( 128, b1 );
            assertEquals( "10000000", b1.toString() );
            
            assertEquals( 2048, b2 );
            assertEquals( "100000000000", b2.toString() );
            assertEquals( "0x0800", b2.toString(16) );
            
            assertEquals( 2048, b2_1 );
            assertEquals( "100000000000", b2_1.toString() );
            assertEquals( "0x0800", b2_1.toString(16) );
            
            assertEquals( 2048, b2_2 );
            assertEquals( "100000000000", b2_2.toString() );
            assertEquals( "0x0800", b2_2.toString(16) );
        }
        
        public function testShift():void
        {
            var b0:bit = new bit( 15 );
            
            assertEquals( "1111", b0.toString() );
            
            var a:uint = b0.shift();
            assertEquals( 1, a );
            assertEquals( "0111", b0.toString() );
            
            var b:uint = b0.shift();
            assertEquals( 1, b );
            assertEquals( "0011", b0.toString() );
            
            var c:uint = b0.shift();
            assertEquals( 1, c );
            assertEquals( "0001", b0.toString() );
            
            var d:uint = b0.shift();
            assertEquals( 1, d );
            assertEquals( "0000", b0.toString() );
        }
        
        public function testShift2():void
        {
            var b0:bit = new bit( 8 );
            var b1:bit = new bit( 1 );
            
            assertEquals( "1000", b0.toString() );
            
            var a:uint = b0.shift();
            assertEquals( 1, a );
            assertEquals( "0000", b0.toString() );
            
            var b:uint = b0.shift();
            assertEquals( 0, b );
            assertEquals( "0000", b0.toString() );
            
            var c:uint = b0.shift();
            assertEquals( 0, c );
            assertEquals( "0000", b0.toString() );
            
            var d:uint = b0.shift();
            assertEquals( 0, d );
            assertEquals( "0000", b0.toString() );
            
            
            assertEquals( "0001", b1.toString() );
            
            var a_:uint = b1.shift();
            assertEquals( 1, a_ );
            assertEquals( "0000", b1.toString() );
            
        }
        
        public function testPop():void
        {
            var b0:bit = new bit( 15 );
            
            assertEquals( "1111", b0.toString() );
            
            var a:uint = b0.pop();
            assertEquals( 1, a );
            assertEquals( "0111", b0.toString() );
            
            var b:uint = b0.pop();
            assertEquals( 1, b );
            assertEquals( "0011", b0.toString() );
            
            var c:uint = b0.pop();
            assertEquals( 1, c );
            assertEquals( "0001", b0.toString() );
            
            var d:uint = b0.pop();
            assertEquals( 1, d );
            assertEquals( "0000", b0.toString() );
        }
        
        public function testPop2():void
        {
            var b0:bit = new bit( 8 );
            var b1:bit = new bit( 1 );
            
            assertEquals( "1000", b0.toString() );
            
            var a:uint = b0.pop();
            assertEquals( 0, a );
            assertEquals( "0100", b0.toString() );
            
            var b:uint = b0.pop();
            assertEquals( 0, b );
            assertEquals( "0010", b0.toString() );
            
            var c:uint = b0.pop();
            assertEquals( 0, c );
            assertEquals( "0001", b0.toString() );
            
            var d:uint = b0.pop();
            assertEquals( 1, d );
            assertEquals( "0000", b0.toString() );
            
            
            
            assertEquals( "0001", b1.toString() );
            
            var a_:uint = b1.pop();
            assertEquals( 1, a_ );
            assertEquals( "0000", b1.toString() );
            
            var b_:uint = b1.pop();
            assertEquals( 0, b_ );
            assertEquals( "0000", b1.toString() );
        }
        
        public function testPush():void
        {
            var a:bit = new bit( 1 );
                a.push( 1 );
            
            var b:bit = new bit( 5 );
                b.push( 5 );
            
            var c:bit = new bit( 5 );
                c.push( 1, 5, 1 );
            
            assertEquals( 17, a.valueOf() );
            assertEquals( "00010001", a.toString() );
            
            assertEquals( 85, b );
            assertEquals( "01010101", b.toString() );
            
            assertEquals( 20817, c );
            assertEquals( "0101000101010001", c.toString() );
        }
        
        public function testRotateLeft():void
        {
            var b:bit = new bit(8);
            
            assertEquals( "1000", b.toString() );
            
            b.rotateLeft();
            assertEquals( "0001", b.toString() );

            b.rotateLeft();
            assertEquals( "0010", b.toString() );
            
            b.rotateLeft();
            assertEquals( "0100", b.toString() );
            
            b.rotateLeft();
            assertEquals( "1000", b.toString() );
        }
        
        public function testRotateLeft8bits():void
        {
            var b:bit = new bit(8);
            
            assertEquals( "1000", b.toString() );
            
            b.rotateLeft(1,8);
            assertEquals( "00010000", b.toString() );

            b.rotateLeft(1,8);
            assertEquals( "00100000", b.toString() );
            
            b.rotateLeft(1,8);
            assertEquals( "01000000", b.toString() );
            
            b.rotateLeft(1,8);
            assertEquals( "10000000", b.toString() );
            
            b.rotateLeft(1,8);
            assertEquals( "0001", b.toString() );
        }

        public function testRotateLeft16bits():void
        {
            var b:bit = new bit(8);
            
            assertEquals( "1000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "00010000", b.toString() );

            b.rotateLeft(1,16);
            assertEquals( "00100000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "01000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "10000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "000100000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "001000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "010000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "100000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "0001000000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "0010000000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "0100000000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "1000000000000000", b.toString() );
            
            b.rotateLeft(1,16);
            assertEquals( "0001", b.toString() );
        }
        
        public function testRotateLeft32bits():void
        {
            var b:bit = new bit(8);
            
            assertEquals( "1000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "00010000", b.toString() );

            b.rotateLeft(1,32);
            assertEquals( "00100000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "01000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "10000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "000100000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "001000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "010000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "100000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0001000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0010000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0100000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "1000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "00010000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "00100000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "01000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "10000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "000100000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "001000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "010000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "100000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0001000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0010000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0100000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "1000000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "00010000000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "00100000000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "01000000000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "10000000000000000000000000000000", b.toString() );
            
            b.rotateLeft(1,32);
            assertEquals( "0001", b.toString() );
        }
        
        public function testRotateRight():void
        {
            var b:bit = new bit(8);
            
            assertEquals( "1000", b.toString() );
            
            b.rotateRight();
            assertEquals( "0100", b.toString() );

            b.rotateRight();
            assertEquals( "0010", b.toString() );
            
            b.rotateRight();
            assertEquals( "0001", b.toString() );
            
            b.rotateRight();
            assertEquals( "1000", b.toString() );
        }
        
        public function testRotateLeftHexadecimal():void
        {
            var b:bit = new bit( 0x1234 );
            
            assertEquals( "0x1234", b.toString(16) );
            
            b.rotateLeft(4);
            assertEquals( "0x2341", b.toString(16) );
            
            b.rotateLeft(4);
            assertEquals( "0x3412", b.toString(16) );
            
            b.rotateLeft(4);
            assertEquals( "0x4123", b.toString(16) );
            
            b.rotateLeft(4);
            assertEquals( "0x1234", b.toString(16) );
        }

        public function testRotateRightHexadecimal():void
        {
            var b:bit = new bit( 0x1234 );
            
            assertEquals( "0x1234", b.toString(16) );
            
            b.rotateRight(4);
            assertEquals( "0x4123", b.toString(16) );
            
            b.rotateRight(4);
            assertEquals( "0x3412", b.toString(16) );
            
            b.rotateRight(4);
            assertEquals( "0x2341", b.toString(16) );
            
            b.rotateRight(4);
            assertEquals( "0x1234", b.toString(16) );
        }
        
        public function testLength():void
        {
            var b0:bit = bit.parse( "0000" );
            var b1:bit = bit.parse( "0001" );
            var b2:bit = bit.parse( "0010" );
            var b3:bit = bit.parse( "0100" );
            var b4:bit = bit.parse( "1000" );
            var b31:bit = bit.parse( "1000000000000000000000000000000" );
            var bmax:bit = bit.parse( "10000000000000000000000000000000" );
            var bmax2:bit = new bit( uint.MAX_VALUE );
            
            assertEquals( 0, b0.length );
            assertEquals( 1, b1.length );
            assertEquals( 2, b2.length );
            assertEquals( 3, b3.length );
            assertEquals( 4, b4.length );
            assertEquals( 31, b31.length );
            assertEquals( 32, bmax.length );
            assertEquals( 32, bmax2.length );
        }
        
        public function testGet():void
        {
            var b:bit = bit.parse( "10011000" );
            
            assertEquals( 0, b.get( 0 ) );
            assertEquals( 0, b.get( 1 ) );
            assertEquals( 0, b.get( 2 ) );
            assertEquals( 1, b.get( 3 ) );
            assertEquals( 1, b.get( 4 ) );
            assertEquals( 0, b.get( 5 ) );
            assertEquals( 0, b.get( 6 ) );
            assertEquals( 1, b.get( 7 ) );
        }
        
        public function testSet():void
        {
            var b:bit = bit.parse( "10011000" );
            
            b.set( 0 );
            assertEquals( "10011001", b.toString() );
            
            b.set( 1 );
            assertEquals( "10011011", b.toString() );
            
            b.set( 2 );
            assertEquals( "10011111", b.toString() );
            
            b.set( 5 );
            assertEquals( "10111111", b.toString() );
            
            b.set( 6 );
            assertEquals( "11111111", b.toString() );
        }
        
        public function testUnset():void
        {
            var b:bit = bit.parse( "10011000" );
            
            b.unset( 3 );
            assertEquals( "10010000", b.toString() );
            
            b.unset( 4 );
            assertEquals( "10000000", b.toString() );
            
            b.unset( 7 );
            assertEquals( "0000", b.toString() );
        }
        
        public function testToggle():void
        {
            var b:bit = bit.parse( "1001" );
            
            b.toggle( 0 );
            assertEquals( "1000", b.toString() );
            
            b.toggle( 3 );
            assertEquals( "0000", b.toString() );
            
            b.toggle( 1 );
            assertEquals( "0010", b.toString() );
            
            b.toggle( 2 );
            assertEquals( "0110", b.toString() );
        }
        
        public function testReverse():void
        {
            var b:bit = bit.parse( "10011000" );
            var b2:bit = bit.parse( "0001" );
            
            b.reverse();
            assertEquals( "00011001", b.toString() );
            
            b2.reverse();
            assertEquals( "1000", b2.toString() );
        }
        
    }
}