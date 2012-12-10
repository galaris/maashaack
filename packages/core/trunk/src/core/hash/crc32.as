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

package core.hash
{
    import flash.utils.ByteArray;
    
    /**
     * A class to compute the CRC-32 checksum of a data stream.
     */
    public final class crc32
    {
        
        private static var lookup:Vector.<uint>;
        
        private static function make_crc_table():void
        {
            lookup = new Vector.<uint>();
            
            var c:uint;
            var i:uint;
            var j:uint;
            
            for( i = 0; i <= 0xFF; i++ )
            {
                c = i;
                for( j = 0; j < 8; j++ )
                {
                    if( (c & 1) != 0 )
                    {
                        c = _poly ^ ( c >>> 1 );
                    }
                    else
                    {
                        c = ( c >>> 1 );
                    }
                }
                lookup[i] = c;
            }
        }
        
        // ---- CONFIG ----
        
        private static var _poly:uint = 0xedb88320; // reverse polynomial
        
        private var _initial:uint = 0xffffffff; // initial contents of LFBSR
        private var _out:uint     = 0xffffffff; // bits mask
        
        // ---- CONFIG ----
        
        private var _crc:uint;
        
        make_crc_table();
        
        /**
         * Creates a CRC-32 object. 
         */
        public function crc32()
        {
            _crc = _initial;
        }
        
        /**
         * Updates the CRC-32 with a specified array of bytes.
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
            var crc:uint = _crc;
            for( i = offset; i < length; i++ )
            {
                c   = uint( bytes[ i ] );
                crc = lookup[ (crc ^ c) & 0xff ] ^ (crc >>> 8);
            }
            
            _crc = uint( _crc ^ crc );
        }
        
        /**
         * Resets the CRC-32 to its initial value. 
         */
        public function reset():void
        {
            _crc = 0;
        }
        
        /**
         * Returns the primitive value type of the CRC-32 object (unsigned integer).
         * 
         * @return a 32bits digest 
         */
        public function valueOf():uint
        {
            return _crc & _out;
        }
        
        /**
         * Returns the string representation of the CRC-32 value.
         * 
         * @param radix (default = 16) -- Specifies the numeric base (from 2 to 36) to use for the uint-to-string conversion. If you do not specify the radix parameter, the default value is 16.
         * @return The numeric representation of the CRC-32 object as a string.
         */ 
        public function toString( radix:Number = 16 ):String
        {
            return _crc.toString( radix );
        }
    
    }
}