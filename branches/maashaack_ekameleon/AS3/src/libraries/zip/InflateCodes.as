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
    /**     * The InflateCodes class.     */    public class InflateCodes 
    {
        /**
         * Creates a new InflateCodes instance. 
         */
        public function InflateCodes()
        {
            
        }
        
        /**
         * dtree bits decoder per branch.
         */
        public var dbits:int ;
        
        /**
         * distance back to copy from.
         */
        public var dist:int ; 
        
        /**
         * distance tree
         */
        public var dtree:Array ;
        
        /**
         * Distance tree index.
         */
        public var dtreeIndex:int ;
         
        /**
         * bits to get for extra
         */
        public var get:int ;
        
        /**
         * ltree bits decoded per branch
         */
        public var lbits:int ; 
        
        /**
         * The literal value.
         */
        public var lit:int ;
        
        /**
         * literal/length/eob tree
         */
        public var ltreeIndex:int ;
        
        /**
         * literal/length/eob tree.
         */
        public var ltree:Array ; 

        /**
         * The mode dependent information.
         */
        public var len:int ;
        
        /**
         * current inflate codes mode.
         */
        public var mode:int;
        
        /**
         * Bits needed.
         */
        public var need:int ; 
                
        /**
         * Pointer into tree.
         */
        public var tree:Array ;
         
        /**
         * The tree index value.
         */
        public var treeIndex:int ;
        
        /**
         * Initialize the instance.
         */
        public function init (bl:int, bd:int, tl:Array, tlIndex:int, td:Array, tdIndex:int ):void
        {
            mode       = START     ;
            lbits      = bl & 0xFF ;
            dbits      = bd & 0xFF ;
            ltree      = tl        ;
            ltreeIndex = tlIndex   ;
            dtree      = td        ;
            dtreeIndex = tdIndex   ;
            tree       = null      ;
        }
        
        ///////////// constants
        
        /**
         * The inflate mask tab.
         */
        public static const INFLATE_MASK:Array = 
        [
            0x00000000 , 0x00000001 , 0x00000003 , 0x00000007 , 0x0000000F ,
            0x0000001F , 0x0000003F , 0x0000007F , 0x000000FF , 0x000001FF ,
            0x000003FF , 0x000007FF , 0x00000FFF , 0x00001FFF , 0x00003FFF ,
            0x00007FFF , 0x0000FFFF
        ];
        
        /**
         * [nothing] set up for LEN.
         */
        public static const START:int = 0 ; 
        
        /**
         * [input] Gets length/literal/eob next.
         */
        public static const LEN:int = 1 ;
        
        /**
         * [input] Getting length extra (have base).
         */
        public static const LENEXT:int = 2 ;
        
        /**
         * [input] Get distance next.
         */
        public static const DIST:int = 3 ;
        
        /**
         * [input] Getting distance extra.
         */
        public static const DISTEXT:int = 4 ;
        
        /**
         * [output] Copying bytes in window, waiting for space.
         */
        public static const COPY:int = 5 ; 
        
        /**
         * [output] Got literal, waiting for output space.
         */
        public static const LIT:int = 6 ;
        
        /**
         * [output] Got eob, possibly still output waiting.
         */
        public static const WASH:int = 7 ;
        
        /**
         * [nothing] Got eob and all data flushed.
         */
        public static const END:int = 8 ;
        
        /**
         * [nothing] Got error.
         */
        public static const BADCODE:int = 9 ;
        
    }    }