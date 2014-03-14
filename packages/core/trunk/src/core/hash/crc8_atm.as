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
  Portions created by the Initial Developers are Copyright (C) 2006-2014
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

package core.hash
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    
    /**
     * A class to compute the CRC-8/ATM checksum of a data stream.
     */
    public final class crc8_atm
    {
        
        private static var lookup:Vector.<uint> = make_crc_table();
        
        private static function make_crc_table():Vector.<uint>
        {
            var table:Vector.<uint> = new Vector.<uint>();
            
            var c:uint;
            var i:uint;
            var j:uint;
            
            for( i=0; i < 256; i++ )
            {
                c = i;
                for( j=0; j < 8; j++ )
                {
                    if( (c & 0x80) != 0 )
                    {
                        c = 0xff & ((c << 1) ^ _poly);
                    }
                    else
                    {
                        c <<= 1;
                    }
                }
                table[i] = c;
            }
            
            return table;
        }
        
        // ---- CONFIG ----
        
        private static var _poly:uint = 0x07;
        private static var _init:uint = 0x00;
        
        // ---- CONFIG ----
        
        private var _crc:uint;
        private var _length:uint;
        private var _endian:String;
        
        /**
         * Creates a CRC-8 object. 
         */
        public function crc8_atm()
        {
            _length = 0xff;
            _endian = Endian.BIG_ENDIAN;
            reset();
        }
        
        /**
         * Returns the byte order for the CRC;
         * either Endian.BIG_ENDIAN for "Most significant bit first"
         * or Endian.LITTLE_ENDIAN for "Least significant bit first".
         * 
         * see: http://en.wikipedia.org/wiki/Computation_of_CRC#Bit_ordering_.28Endianness.29
         */
        public function get endian():String { return _endian; }
        
        /**
         * Returns the length the CRC;
         */
        public function get length():uint { return _length; }
        
        /**
         * Updates the CRC-8 with a specified array of bytes.
         * 
         * @param bytes The ByteArray object
         * @param offset (default = 0) -- A zero-based index indicating the position into the array to begin reading.
         * @param length (default = 0) -- An unsigned integer indicating how far into the buffer to read (if 0, the length of the ByteArray is used).
         */
        public function update( bytes:ByteArray, offset:uint = 0, length:uint = 0 ):void
        {
            if( length == 0 ) { length = bytes.length; }
        
            bytes.position = offset;
            
            var i:uint;
            var c:uint;
            var crc:uint = _length & (_crc);
            
            for( i = offset; i < length; i++ )
            {
                c    = uint( bytes[ i ] );
                crc  = lookup[(crc ^ c) & 0xff];
            }
            
            _crc = crc;
        }
        
        /**
         * Resets the CRC-8 to its initial value. 
         */
        public function reset():void
        {
            _crc = _init;
        }
        
        /**
         * Returns the primitive value type of the CRC-8 object (unsigned integer).
         * 
         * @return a 8bits digest
         */
        public function valueOf():uint
        {
            return _crc;
        }
        
        /**
         * Returns the string representation of the CRC-8 value.
         * 
         * @param radix (default = 16) -- Specifies the numeric base (from 2 to 36) to use for the uint-to-string conversion. If you do not specify the radix parameter, the default value is 16.
         * @return The numeric representation of the CRC-8 object as a string.
         */ 
        public function toString( radix:Number = 16 ):String
        {
            return _crc.toString( radix );
        }
    
    }
}