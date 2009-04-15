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
            //
        }
        
        /**
         * The dynamic tree.
         */
        public var dynTree:Array ;
        
        /**
         * Largest code with non zero frequency.
         */
        public var maxCode:int ;
        
        /**
         * The corresponding static tree.
         */
        public var staticDesc:StaticTree ;
        
        /**
         * Reverse the first len bits of a code, using straightforward code (a faster method would use a table) IN assertion: 1 <= len <= 15
         * @param code the value to invert
         * @param len its bit length
         */
        public static function biReverse( code:int, len:int ):int
        {
            var res:int = 0 ;
            do
            {
                res |= code & 1 ;
                code >>>=1 ;
                res <<= 1 ;
            } 
            while(--len>0) ;
            return res >>> 1 ;
        }
        
        /** 
         * Construct one Huffman tree and assigns the code bit strings and lengths.
         * <p>Update the total bit length for the current block.</p>
         * <p>IN assertion: the field freq is set for all tree elements.</p>
         * <p>OUT assertions: the fields len and code are set to the optimal bit length 
         * and corresponding code. The length opt_len is updated; staticLength is also updated if stree is not null. The field maxCode is set.</p>
         */
        public function build( s:Deflate ):void
        {
            
            var tree:Array  = dynTree ;
            
            var stree:Array = staticDesc.staticTree ;
            var elems:int   = staticDesc.elements ;
            
            var n:int ;
            var m:int ;
            
            var maxCode:int = -1 ;
            var node:int ;

            // Construct the initial heap, with least frequent element in
            // heap[1]. The sons of heap[n] are heap[2*n] and heap[2*n+1].
            // heap[0] is not used.
            s.heapLen = 0 ;
            s.heapMax = HEAP_SIZE ;

            for(n=0; n<elems; n++) 
            {
                if(tree[n*2] != 0) 
                {
                    s.heap[++s.heapLen] = maxCode = n ;
                    s.depth[n]          = 0 ;
                }
                else
                {
                    tree[n*2+1] = 0 ;
                }
            }
            
            // The pkzip format requires that at least one distance code exists,
            // and that at least one bit should be sent even if there is only one
            // possible code. So to avoid special checks later on we force at least
            // two codes of non zero frequency.
            while ( s.heapLen < 2 ) 
            {
                node = s.heap[++s.heapLen] = maxCode < 2 ? ++maxCode : 0 ;
                tree[node*2] = 1 ;
                s.depth[node] = 0 ;
                s.optLength-- ;
                if (stree!=null) 
                {
                    s.staticLength -= stree[node*2+1] ;
                }
                // node is 0 or 1 so it does not have extra bits
            }
            
            this.maxCode = maxCode ;
            
            // The elements heap[heap_len/2+1 .. heap_len] are leaves of the tree,
            // establish sub-heaps of increasing lengths:
            
            for( n = s.heapLen / 2 ; n >= 1 ; n-- )
            {
              s.pqDownHeap(tree, n);
            }
            
            // Construct the Huffman tree by repeatedly combining the least two frequent nodes.
            
            node = elems ; // next internal node of the tree
            
            do
            {
                n = s.heap[1] ; // n = node of least frequency
                
                s.heap[1] = s.heap[ s.heapLen-- ] ;
                
                s.pqDownHeap(tree, 1) ;
                 
                m = s.heap[1] ; // m = node of next least frequency
                 
                s.heap[--s.heapMax] = n ; // keep the nodes sorted by frequency
                s.heap[--s.heapMax] = m ;
                
                // Creates a new node father of n and m
                 
                tree[node*2] = 0xffff & (tree[n*2] + tree[m*2]);
                
                s.depth[node] = 255 & (Math.max(s.depth[n],s.depth[m])+1);
                
                tree[n*2+1] = tree[m*2+1] = 0xffff & node;
                
                // and insert the new node in the heap
                s.heap[1] = node++ ;
                s.pqDownHeap(tree, 1) ;
            }
            while( s.heapLen >= 2 ) ;
            
            s.heap[--s.heapMax] = s.heap[1] ;
            
            // At this point, the fields freq and dad are set. We can now generate the bit lengths.
            
            generatesBitlength( s ) ;
            
            // The field len is now set, we can generate the bit codes
            generatesCodes(tree, maxCode, s.blCount) ;
            
        }
        
        /**
         * Mapping from a distance to a distance code. dist is the distance - 1 and 
         *  must not have side effects. _dist_code[256] and _dist_code[257] are never used.
         */
        public static function dCode( dist:int ):int
        {
            return ((dist) < 256 ? DIST_CODE[dist] : DIST_CODE[256+((dist)>>>7)]);
        }
        
        /**
         * Generates the codes for a given tree and bit counts (which need not be optimal).
         * <p>IN assertion  : the array blCount contains the bit length statistics for the given tree and the field len is set for all tree elements.</p>
         * <p>OUT assertion : the field code is set for all tree elements of non zero code length.</p> 
         * @param tree The tree to decorate
         * @param maxCode Largest code with non zero frequency.
         * @param blCount Number of codes at each bit length.
         */
        public static function generatesCodes( tree:Array , maxCode:int, blCount:Array ):void
        {
            var bits:int ;
            var n:int ;
            var next:Array = new Array( MAX_BITS + 1 ) ; // next code value for each bit length
            var code:int = 0 ;
            for ( bits = 1 ; bits <= MAX_BITS ; bits++ ) 
            {
                next[bits] = code = 0xffff & ( (code + blCount[bits-1]) << 1 ) ;
            }
            var len:int ;
            for ( n = 0 ;  n <= maxCode ; n++ ) 
            {
                len = tree[n*2+1] ;
                if (len == 0) 
                {
                    continue;
                }
                tree[n*2] = 0xffff & (biReverse(next[len]++, len)); // reverse the bits
            }
        }

        
        /**
         * Computes the optimal bit lengths for a tree and update the total bit length for the current block.
         * <p>IN assertion: the fields freq and dad are set, heap[heap_max] and above are the tree nodes sorted by increasing frequency.</p>
         * <p>OUT assertions: the field len is set to the optimal bit length, the  array blCount contains the frequencies for each bit length.</p>
         * <p>The length opt_len is updated; static_len is also updated if stree is not null.</p>
         */
        public function generatesBitlength( s:Deflate ):void
        {
            var tree:Array  = dynTree ;
            
            var stree:Array   = staticDesc.staticTree ;
            var extra:Array   = staticDesc.extraBits;
            var base:int      = staticDesc.extraBase;
            var maxLength:int = staticDesc.maxLength;
            
            var h:int ;
            var n:int ;
            var m:int ;
            var bits:int ;
            var xbits:int ;
            var f:int ;
            var overflow:int ; // number of elements with bit length too large
            
            for ( bits = 0 ; bits <= MAX_BITS ; bits++ )
            {
                s.blCount[bits] = 0 ;
            }
            
            // In a first pass, compute the optimal bit lengths (which may Overflow in the case of the bit length tree).
            
            tree[ s.heap[ s.heapMax ] * 2 + 1 ] = 0 ; // root of the heap
            
            for( h = s.heapMax + 1 ; h < HEAP_SIZE ; h++ )
            {
                n    = s.heap[h] ;
                bits = tree[ tree[n*2+1] * 2 + 1 ] + 1 ;
                if ( bits > maxLength )
                { 
                    bits = maxLength ; 
                    overflow++ ; 
                }
                tree[n*2+1] = 0xffff & bits ;
                
                // We overwrite tree[n*2+1] which is no longer needed

                if (n > maxCode) continue ;  // not a leaf node

                s.blCount[bits]++ ;
                xbits = 0 ;
                
                if (n >= base) 
                {
                    xbits = extra[n-base] ;
                }
                
                f = tree[n*2] ;
                
                s.optLength += f * (bits + xbits) ;
                if (stree!=null) 
                {
                    s.staticLength += f * (stree[n*2+1] + xbits) ;
                }
            }
            
            if (overflow == 0) 
            {
                return ;
            }
            
            // This happens for example on obj2 and pic of the Calgary corpus
            // Find the first bit length which could increase:
            do 
            {
                bits = maxLength - 1 ;
                while( s.blCount[bits] == 0 ) 
                {
                    bits-- ;
                }
                s.blCount[bits]--      ; // move one leaf down the tree
                s.blCount[bits+1] += 2 ; // move one overflow item as its brother
                s.blCount[maxLength]-- ;
                // The brother of the overflow item also moves one step up,
                // but this does not affect bl_count[max_length]
                overflow -= 2 ;
            }
            while (overflow > 0);
            
            for ( bits = maxLength ; bits != 0 ; bits-- ) 
            {
                n = s.blCount[bits] ;
                while (n != 0) 
                {
                    m = s.heap[--h] ;
                    if (m > maxCode) 
                    {
                    	continue ;
                    }
                    if (tree[m*2+1] != bits) 
                    {
                        s.optLength  += (uint(bits) - uint(tree[m*2+1]))*uint(tree[m*2]);
                        tree[m*2+1] = 0xffff&bits;
                    }
                    n--;
                }
            }
        }

        ////// constants
        
        /**
         * The BASE_LENGTH table.
         */
        public static const BASE_LENGTH:Array = 
        [
             0,  1,  2,   3,   4,   5,   6,   7, 8, 10, 12, 14, 16, 20, 24, 28, 32, 40, 48, 56,
            64, 80, 96, 112, 128, 160, 192, 224, 0
        ];
        
        /**
         * The BASE_DIST table.
         */
        public static const BASE_DIST:Array = 
        [
             0 ,    1 ,      2 ,     3 ,     4 ,     6 ,     8 ,    12 ,    16 ,     24 ,
            32 ,   48 ,     64 ,    96 ,   128 ,   192 ,   256 ,   384 ,   512 ,    768 ,
          1024 , 1536 ,   2048 ,  3072 ,  4096 ,  6144 ,  8192 , 12288 , 16384 ,  24576
        ];
  
        public static const BL_ORDER:Array =
        [
            16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15
        ];
        
        /**
         * The buffer size.
         */
        public static const BUFFER_SIZE:int = 8 * 2 ;
        
        /**
         * The DIST_CODE table.
         */
        public static const DIST_CODE:Array = 
        [
            0,  1,  2,  3,  4,  4,  5,  5,  6,  6,  6,  6,  7,  7,  7,  7,  8,  8,  8,  8,
            8,  8,  8,  8,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
            11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
            12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13,
            13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13,
            13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
            14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
            14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
            14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15,
            15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
            15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
            15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,  0,  0, 16, 17,
            18, 18, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22,
            23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
            24, 24, 24, 24, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
            26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26,
            26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27,
            27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
            27, 27, 27, 27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
            28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
            28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
            28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
            29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
            29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
            29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29
        ];
          
        /**
         * Ssee definition of array distCode.
         */
        public static const DIST_CODE_LEN:int = 512 ;
        
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
         * The LENGTH_CODE table.
         */
        public static const LENGTH_CODE:Array =
        [
            0,  1,  2,  3,  4,  5,  6,  7,  8,  8,  9,  9, 10, 10, 11, 11, 12, 12, 12, 12,
            13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16,
            17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19,
            19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
            21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22,
            22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23,
            23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
            24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
            25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
            25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 26, 26,
            26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26,
            26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
            27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28
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
        public static const REPZ_11_138:int = 18 ; 
        
        protected static const BL_CODES:int = 19 ;
        
        protected static const D_CODES:int = 30 ;

        protected static const HEAP_SIZE:int = 2 * L_CODES + 1 ;
        
        protected static const LITERALS:int = 256 ;
        
        protected static const LENGTH_CODES:int = 29 ;
        
        protected static const L_CODES:int = LITERALS + 1 + LENGTH_CODES ;
        
        protected static const MAX_BITS:int = 15 ;
    
    }}