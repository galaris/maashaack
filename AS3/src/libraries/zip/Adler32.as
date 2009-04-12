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

/*
This program is based on zlib-1.1.3, so all credit should go authors
Jean-loup Gailly(jloup@gzip.org) and Mark Adler(madler@alumni.caltech.edu)
and contributors of zlib.
*/

package libraries.zip 
{    import flash.utils.ByteArray;    
    /**
     * Adler-32 is a modification of the Fletcher checksum.      * The <a href="http://en.wikipedia.org/wiki/Adler-32">Adler-32</a> checksum is part of the widely-used zlib compression library, as both were developed by Mark Adler.  
     * A "rolling checksum" version of Adler-32 is used in the rsync utility.     */    public final class Adler32 
    {

        /**
         * Creates a new Adler32 instance.
         */
        public function Adler32()
        {
            //
        }

        /**
         * The largest prime smaller than 65536
         */
        public static const BASE:int = 65521 ;

        /**
         * The largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1
         */
        public static const NMAX:int = 5552 ;

        /**
         * Resets the Adler32 value.
         */
        public function reset():void
        {
            _value = 1 ;
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
         * @param adler The adler basic value.
         * @param buffer the buffer ByteArray object which contains the datas.
         * @param index The index to begin the buffering.
         * @param len The length value to limit the buffering.
         */
        public function update( adler:uint, buffer:ByteArray , index:int , len:int ):void 
        {
            if ( buffer == null )
            {
                _value = 1 ;	
            }
            var s1:uint = adler & 0xFFFF ;
            var s2:uint = (adler >> 16) & 0xFFFF ;
            var k:int;
            while(len > 0) 
            {
                k = len < NMAX ? len : NMAX ;
                len -= k ;
                while( k >= 16 )
                {
                    s1 += buffer[index++] & 0xFF ; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF ; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF ; 
                    s2 += s1 ;
                    s1 += buffer[index++] & 0xFF ; 
                    s2 += s1 ;
                    s1 += buffer[index++] & 0xFF ; 
                    s2 += s1 ;
                    s1 += buffer[index++] & 0xFF ; 
                    s2 += s1 ;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    s1 += buffer[index++] & 0xFF; 
                    s2 += s1;
                    k -= 16;
                }
                if(k != 0)
                {
                    do
                    {
                        s1 += buffer[index++] & 0xFF ; 
                        s2 += s1 ;
                    }
                    while( --k != 0 ) ;
                }
                s1 %= BASE ;
                s2 %= BASE ;
            }
            _value = (s2 << 16) | s1 ;
        }

        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():uint
        {
            return _value ;
        }

        /**
         * @private
         */
        private var _value:uint = 1 ;    }}