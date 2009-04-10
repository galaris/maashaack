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

package libraries.zip 
{    import flash.utils.ByteArray;                    

    /**     * The implementation of the <a href="http://en.wikipedia.org/wiki/Cyclic_redundancy_check">CRC (Cyclic Redundancy Check)</a>. 
     * This algorithm is used in the GZIP file format specification version 4.3 defines in the RFC 1952.
     */    public final class CRC32 
    {
        /**
         * Creates a new CRC32 instance.
         */
        public function CRC32( buffer:ByteArray = null )
        {
            if ( buffer != null )
            {
                update( buffer ) ;
            }
        }
        
        /**
         * Resets the CRC value.
         */
        public function reset():void
        {
            _value = 0 ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return String(valueOf()) ;
        }

        /**
         * Adds the complete byte array to the data checksum.
         * @param buffer the buffer ByteArray object which contains the datas.
         */
        public function update( buffer:ByteArray ):void 
        {
            if ( buffer == null )
            {
                reset() ;
            }
            var off:uint = 0 ;
            var len:uint = buffer.length ;
            var c:uint = ~_value ;
            while(--len > -1 ) 
            {
                c = _crcTable[(c ^ buffer[off++]) & 0xFF] ^ (c >>> 8) ;
            }
            _value = ~c;
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():uint
        {
            return _value & 0xFFFFFFFF ;
        }

        /**
         * @private
         */
        private var _value:uint ;
        
        /**
         * @private
         */
        private static var _crcTable:Array = new Array(256) ;
        
        /////////// init the CRC table
        
        private static function __initCRCTable__():void
        {
            var i:int  ;
            var k:int  ;
            var c:uint ;
            for ( i = 0 ; i<256 ; i++ )
            {
                c = i ;
                for ( k = 0 ; k < 8 ; k++ )
                {
                    c = ( (c & 1) != 0 ) ? ( 0xEDB88320 ^ ( c >>> 1 ) ) : ( c >>> 1 ) ;
                }
                _crcTable[i] = c ;
            }
        }
        
        __initCRCTable__() ;
        
        //////////    }}