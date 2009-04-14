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
{
    /**     * The Tree class.     */    public class Tree 
    {
        /**
         * Creates a new Tree instance.
         */
        public function Tree()
        {
            
        }
        
        ////// constants
        
        public static const BL_ORDER:Array =
        [
            16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15
        ];
        
        /**
         * End of block literal code.
         */
        public static const END_BLOCK:int = 256 ;
         
        /**
         * Extra bits for each bit length code.
         */
        public static const EXTRA_BL_BITS:Array =
        [
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,7
        ];
        
        /**
         * Extra bits for each distance code.
         */
        public static const EXTRA_DBITS:Array =
        [
            0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13
        ];
        
        /**
         * Extra bits for each length code.
         */
        public static const EXTRA_LBITS:Array =
        [
            0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0
        ];
        
        /**
         * Bit length codes must not exceed MAX_BL_BITS bits.
         */
        public static const MAX_BL_BITS:int = 7 ; 
        
        /**
         * Repeat previous bit length 3-6 times (2 bits of repeat count).
         */
        public static const REP_3_6:int = 16 ; 
        
        /**
         * Repeat a zero length 3-10 times (3 bits of repeat count).
         */
        public static const REPZ_3_10:int = 17 ; 

        /**
         * Repeat a zero length 11-138 times (7 bits of repeat count).
         */
        public static const REPZ_11_138:int = 18 ;     }}