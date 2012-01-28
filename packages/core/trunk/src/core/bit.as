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
    /* note:
       the bit class is to mainpulate Numbers as bits
       it is not a bit type (that would be have only 0 or 1 as values)
       
       we then operates all bit manipulation on unsigned 32bits numbers
    */
    /**
     * The bit class allow you to manipulate the bits of an unsigned integer.
     * 
     * <p>
     * Practical infos to convert to bits, hex and decimal
     * 
     * <table class="innertable">
     * <tr><th><b>Hex</b></th><th><b>Dec</b></th><th><b>Binary</b></th></tr>
     * <tr><td>0</td><td>&#xA0;0</td><td>0000</td></tr>
     * <tr><td>1</td><td>&#xA0;1</td><td>0001</td></tr>
     * <tr><td>2</td><td>&#xA0;2</td><td>0010</td></tr>
     * <tr><td>3</td><td>&#xA0;3</td><td>0011</td></tr>
     * <tr><td>4</td><td>&#xA0;4</td><td>0100</td></tr>
     * <tr><td>5</td><td>&#xA0;5</td><td>0101</td></tr>
     * <tr><td>6</td><td>&#xA0;6</td><td>0110</td></tr>
     * <tr><td>7</td><td>&#xA0;7</td><td>0111</td></tr>
     * <tr><td>8</td><td>&#xA0;8</td><td>1000</td></tr>
     * <tr><td>9</td><td>&#xA0;9</td><td>1001</td></tr>
     * <tr><td>A</td><td>10</td><td>1010</td></tr>
     * <tr><td>B</td><td>11</td><td>1011</td></tr>
     * <tr><td>C</td><td>12</td><td>1100</td></tr>
     * <tr><td>D</td><td>13</td><td>1101</td></tr>
     * <tr><td>E</td><td>14</td><td>1110</td></tr>
     * <tr><td>F</td><td>15</td><td>1111</td></tr>
     * </table>
     * </p>
     */
    public class bit
    {
        private var _value:uint;
        
        public static const MAX:uint = 32;
        public static const MIN:uint = 0;
        
        public function bit( value:uint = 0 )
        {
            _value = value;
        }
        
        /**
         * Parses a string into bits.
         */
        public static function parse( value:String, radix:uint = 2 ):bit
        {
            var n:uint = parseInt( value, radix );
            return new bit( n );
        }
        
        /**
         * Returns the length of the bit(s).
         */
        public function get length():uint
        {
            /* note:
               yes we could reuse the toString() to get the length of the bits
               from the length of the string representation
               ----
               var b:String = toString( 2, false );
               return b.length;
               ----
               
               but here what happen on AS3/AVM side
               Number toString() redirect to AS3::toString()
               which redirect to private static native function _numberToString(n:Number, radix:int):String
               
               in avmplus
               Stringp NumberClass::_numberToString(double dVal, int radix)
               call MathUtils::convertDoubleToStringRadix(core, dVal, radix);
               
               and here we find
               http://hg.mozilla.org/tamarin-central/file/dab354bc047c/core/MathUtils.cpp#l806
               ----
                double uVal = MathUtils::floor(value);
                
                while (uVal != 0)
                {
                    double j = uVal;
                    uVal = MathUtils::floor(uVal / radix);
                    j -= (uVal * radix);
                    
                    *src-- = (wchar)((j < 10) ? ((int)j + '0') : ((int)j + ('a' - 10)));
                    
                    AvmAssert(src > tmp);
                }
               ----
               
               in our case we don't need  the string representation but just the count of the bits,
               so we can just implement the loop above ourself, also we don't want to deal with
               different radix so we can harcode 2
               and do other minor optimizations
               instead of doing 'n / 2', we can do 'n >> 1'
               and instead of doing 'n * 2', we can do 'n << 1'
               and yeah we don't need the math.floor() because we're dealing with unsigned integers
               
               I didn't make intensive benchmarck but the following should be much faster than the toString() method
            */
            if( _value > 0x7fffffff )
            {
                return MAX;
            }
            
            var n:uint   = _value;
            var len:uint = 0;
            var j:uint;
            
            while( n != 0 )
            {
                j = n;
                //n = Math.floor( n / 2 );
                n >>= 1;
                //j -= n * 2;
                j -= n << 1;
                len++;
            }
            
            return len;
        }
        
        /**
         * Returns the hexadecimal length of the bit(s).
         * 
         * <p>
         * bit length in hexadecimal are multiple of 4,
         * for ex:
         * the number 1 gives 0001 bits
         * and will have a length of 1 (1 bit)
         * and a hexlength of 4 (4 bits)
         * </p>
         */
        public function get hexlength():uint
        {
            var len:uint = length;
            
            while( len%4 != 0 )
            {
                len++;
            }
            
            return len;
        }
        
        /**
         * Gets the bit at the index position.
         */
        public function get( index:uint ):uint
        {
            return (_value & (1 << index)) >>> index;
        }
        
        /**
        * Sets the bit at the index position.
        */
        public function set( index:uint ):void
        {
            _value |= 1 << index;
        }
        
        /**
         * Clears the bit at the index position.
         */
        public function unset( index:uint ):void
        {
            _value &= ~(1 << index);
        }
        
        /**
         * Toggles the bit at the index position.
         */
        public function toggle( index:uint ):void
        {
            _value ^= 1 << index;
        }
        
        /**
         * Clears all the bits.
         */
        public function clear():void
        {
            _value = 0;
        }
        
        /**
         * Removes the last bit and returns it.
         */
        public function pop():uint
        {
            var v:uint = get(0);
            _value >>>= 1;
            return v;
        }
        
        /**
         * Adds one or more bits to the current bit.
         */
        public function push( ...bits ):void
        {
            /* note:
               a push() does not add the number, it add the bits of the number
               
               a = new bit( 1 ); //0001
               a.push( 1 );      //0001 0001
               
               b = new bit( 5 ); //0101
               b.push( 5 );      //0101 0101
               
               c = new bit( 5 ); //0101
               b.push( 1, 5, 1 );//0101 0001 0101 0001
            */
            
            /* note:
               this was the old way of doing it
               by using string represnetation and string parsing
               
            var i:uint;
            var ar:Array = [ toString() ];
            
            for( i=0; i<bits.length; i++ )
            {
                ar.push( new bit( bits[i] ).toString() );
            }
            
            var b:bit = bit.parse( ar.join(""), 2 );
            _value = b.valueOf();
            */
            
            var i:uint;
            var b:bit;
            for( i=0; i<bits.length; i++ )
            {
                b = new bit( bits[i] );
                _value <<= b.hexlength;
                _value  += bits[i];
            }
        }
        
        /**
         * Removes the first bit and returns it.
         */
        public function shift():uint
        {
            var v:uint = get( length-1 );
            unset( length-1 );
            
            return v;
        }
        
        /**
         * Reverse the order of bits.
         */
        public function reverse( mask:uint = 0 ):void
        {
            var len:uint;
            
            if( mask == 0 )
            {
                len = hexlength;
            }
            else
            {
                len = mask;
            }
            
            var r:uint = _value;
            r = ((r >> 1) & 0x55555555) | ((r & 0x55555555) << 1);
            r = ((r >> 2) & 0x33333333) | ((r & 0x33333333) << 2);
            r = ((r >> 4) & 0x0f0f0f0f) | ((r & 0x0f0f0f0f) << 4);
            r = ((r >> 8) & 0x00ff00ff) | ((r & 0x00ff00ff) << 8);
            r = (r >> 16) | (r << 16);
            
            _value = r >>> (MAX - len);
        }
        
        /**
         * Rotates the bit on the left by an amount of bits (default 1)
         * over a mask (default 0).
         * 
         * <p>
         * When the mask is 0, we take the minimum length of the bit
         * 
         * for ex:
         * var b:bit = new bit( 8 ); //1000
         * b.rotateLeft();           //0001
         * 
         * But you can force the mask to be any value from 0 to 32
         * 
         * for ex:
         * var b:bit = new bit( 8 ); //    1000
         * b.rotateLeft( 1, 8);      //00010000
         * 
         * here we rotated 1 bit to the left over a 8bits mask
         * </p>
         */
        public function rotateLeft( bits:uint = 1, mask:uint = 0 ):void
        {
            var len:uint;
            
            if( mask == 0 )
            {
                len = hexlength;
            }
            else
            {
                len = mask;
            }
            
            var left:uint = _value >>> (len-bits);
            var clear:uint = (MAX - len) + bits;
            
            _value <<=  clear;
            _value >>>= clear;
                
            _value = (_value << bits) | left;
        }
        
        /**
         * Rotates the bit on the right by an amount of bits (default 1)
         * over a mask (default 0).
         */
        public function rotateRight( bits:uint = 1, mask:uint = 0 ):void
        {
            var len:uint;
            
            if( mask == 0 )
            {
                len = hexlength;
            }
            else
            {
                len = mask;
            }
            
            var right:uint = _value << (MAX - bits);
                right   >>>= (MAX - len);
            
            _value = (_value >>> bits ) | right;
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():uint
        {
            return _value;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString( radix:Number = 2, padding:Boolean = true ):String
        {
            var s:String = _value.toString( radix );
            
            switch( radix )
            {
                case 16:
                while( padding && (s.length%2 != 0) )
                {
                    s = "0" + s;
                }
                s = "0x"+s ;
                break;
                
                case 10:
                s += "b";
                break;
                
                case 2:
                default:
                while( padding && (s.length%4 != 0) )
                {
                    s = "0" + s;
                }
            }
            
            return s;
        }
        
    }
}