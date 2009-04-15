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

    /**     * This class is used for compressing data.      */    public class Deflate 
    {
        /**
         * Creates a new Deflate instance.
         */
        public function Deflate()
        {
            depth.length = 2 * L_CODES + 1 ;
            dynLtree     = new Array( HEAP_SIZE * 2 ) ;
            dynDtree     = new Array( ( 2 * D_CODES  + 1 ) * 2 ) ; // distance tree
            blTree       = new Array( ( 2 * BL_CODES + 1 ) * 2 ) ; // Huffman tree for bit lengths
        }
        
        //////////////////// constants
        
        
        protected static const STORED:int = 0 ;
        protected static const FAST:int   = 1 ;
        protected static const SLOW:int   = 2 ;

        protected static const configs:Array = 
        [
            //          good | lazy |  nice |  chain |
             
            new Config(    0 ,    0 ,     0 ,      0 , STORED ) ,
            new Config(    4 ,    4 ,     8 ,      4 , FAST   ) ,
            new Config(    4 ,    5 ,    16 ,      8 , FAST   ) ,
            new Config(    4 ,    6 ,    32 ,     32 , FAST   ) ,
            
            new Config(    4 ,    4 ,    16 ,     16 , SLOW   ) ,
            new Config(    8 ,   16 ,    32 ,     32 , SLOW   ) ,
            new Config(    8 ,   16 ,   128 ,    128 , SLOW   ) ,
            new Config(    8 ,   32 ,   128 ,    256 , SLOW   ) ,
            new Config(   32 ,  128 ,   258 ,   1024 , SLOW   ) ,
            new Config(   32 ,  258 ,   258 ,   4096 , SLOW   )
        ];
        
        /**
         * Blocks flush performed.
         */
        protected static const BLOCK_DONE:int = 1 ; 
        
        /**
         * The size of the buffer.
         */
        protected static const BUFFER_SIZE:int = 8 * 2 ;
        
        /**
         * Finish started, need only more output at next deflate.
         */
        protected static const FINISH_STARTED:int = 2;
    
        /**
         * Finish done, accept no more input or output
         */
        protected static const FINISH_DONE:int = 3 ;
    
        /**
         * Preset dictionary flag in zlib header.
         */
        protected static const PRESET_DICT:int = 0x20 ;
        
        /**
         * The init state value.
         */
        protected static const INIT_STATE:int   =  42 ;
        
        /**
         * The busy state value.
         */
        protected static const BUSY_STATE:int   = 113 ;
        
        /**
         * The finish state value.
         */
        protected static const FINISH_STATE:int = 666 ;
        
        /**
         * The deflate compression method.
         */
        protected static const Z_DEFLATED:int = 8;
        
        
        protected static const STORED_BLOCK:int = 0 ;
        protected static const STATIC_TREES:int = 1 ;
        protected static const DYN_TREES:int    = 2 ;
        
        // The three kinds of block type
        
        /**
         * The binary value.
         */
        protected static const Z_BINARY:int  = 0 ;
        
        /**
         * The ascii value.
         */
        protected static const Z_ASCII:int   = 1 ;
        
        /**
         * The unknow value.
         */
        protected static const Z_UNKNOWN:int = 2 ;
        
        
        /**
         * Block not completed, need more input or more output.
         */
        protected static const NEED_MORE:int = 0 ; 
        
        /**
         * Repeat previous bit length 3-6 times (2 bits of repeat count).
         */
        protected static const REP_3_6:int=16; 
    
        /**
         * Repeat a zero length 3-10 times  (3 bits of repeat count).
         */
        protected static const REPZ_3_10:int=17; 
    
        /**
         * Repeat a zero length 11-138 times  (7 bits of repeat count).
         */
        protected static const REPZ_11_138:int=18; 
        
        protected static const MIN_MATCH:int=3;
        protected static const MAX_MATCH:int=258;
        protected static const MIN_LOOKAHEAD:int=(MAX_MATCH+MIN_MATCH+1);
    
        protected static const MAX_BITS:int     = 15 ;
        protected static const D_CODES:int      = 30 ;
        protected static const BL_CODES:int     = 19 ;
        protected static const LENGTH_CODES:int = 29 ;
        protected static const LITERALS:int     = 256 ;
        protected static const L_CODES:int      = LITERALS + 1 + LENGTH_CODES ;
        protected static const HEAP_SIZE:int    = 2 * L_CODES + 1 ;
    
        protected static const END_BLOCK:int = 256 ;
        
        public static function smaller( tree:Array , n:int, m:int, depth:ByteArray):Boolean
        {
            var tn2:int = tree[ n*2 ] ;
            var tm2:int = tree[ m*2 ] ;
            return (tn2<tm2 || (tn2==tm2 && depth[n] <= depth[m]));
        }
        
        ////////////////////
        
        /**
         * Number of codes at each bit length for an optimal tree.
         */
        public var blCount:Array=new Array( MAX_BITS + 1 ) ;
        
        /**
         * Desc for bit length tree.
         */
        public var blDesc:Tree = new Tree() ;
        
        /**
         * Huffman tree for bit lengths.
         */
        public var blTree:Array ; 
      
        /**
         * Window position at the beginning of the current output block. 
         * Gets negative when the window is moved backwards.
         */
        public var blockStart:int;
        
        /**
         * The data type : UNKNOWN, BINARY or ASCII.
         */
        public var dataType:int ;
      
        /**
         * Depth of each subtree used as tie breaker for trees of equal frequency.
         */
        public var depth:ByteArray = new ByteArray() ;
        
        /**
         * desc for distance tree.
         */
        public var dDesc:Tree = new Tree() ; 
        
        /**
         * Literal and length tree.
         */
        public var dynLtree:Array ; 
      
        /**
         * Distance tree.
         */
        public var dynDtree:Array ;
        
        /**
         * Use a faster search when the previous match is longer than this.
         */
        public var goodMatch:int ;
        
        /**
         * log2(hash_size)
         */
        public var hashBits:int ;
        
        /**
         *  hashSize - 1
         */ 
        public var hashMask:int ;
        
        /**
         * Number of bits by which insertedHash must be shifted at each input step. 
         * It must be such that after MIN_MATCH steps, the oldest byte no longer takes part in the hash key, that is:
         * hashShift * MIN_MATCH >= hashBits
         */
        public var hashShift:int;
        
        /**
         * Number of elements in hash table.
         */
        public var hashSize:int ;
        
        /**
         * Heads of the hash chains or NIL.
         */
        public var head:Array ;
        
        /**
         * Heap used to build the Huffman trees.
         * <p>The sons of heap[n] are heap[2*n] and heap[2*n+1]. heap[0] is not used.</p>
         * <p>The same heap array is used to build all trees.</p>
         */
        public var heap:Array = new Array( 2 * L_CODES + 1 ) ;
        
        /**
         * Number of elements in the heap.
         */
        public var heapLen:int ;
        
        /**
         * Element of largest frequency.
         */
        public var heapMax:int ;
      
        /**
         * Hash index of string to be inserted.
         */
        public var insertedHash:int ;
        
        /**
         *  The value of flush param for previous deflate call.
         */
        public var lastFlush:int ;
        
        /**
         * Index for literals or lengths.
         */
        public var lBuffer:int ;
        
        /**
         * Desc for literal tree.
         */
        public var lDesc:Tree = new Tree() ; 
        
        /**
         * Compression level (1..9)
         */
        public var level:int ;
        
        /**
         * Number of valid bytes ahead in window.
         */
        public var lookahead:int ; 
        /**
         * set if previous match exists
         */
        public var matchAvailable:int ; 
        
        /**
         * length of best match
         */
        public var matchLength:int ;
        
        /**
         * Start of matching string.
         */
        public var matchStart:int ;
        
        /**
         * To speed up deflation, hash chains are never searched beyond this length. 
         * A higher limit improves compression ratio but degrades the speed.
         */
        public var maxChainLength:int ;
    
        /**
         * Attempt to find a better match only when the current match is strictly smaller than this value. This mechanism is used only for compression levels >= 4.
         */
        public var maxLazyMatch:int;
        
        /**
         * The type of method used : STORED (for zip only) or DEFLATED.
         */
        public var method:int ; 
        
        /**
         * Stop searching when current match exceeds this.
         */
        public var niceMatch:int ;
        
        /**
         * Suppress zlib header and adler32.
         */ 
        public var noheader:int ;
        
        /**
         * Number of bytes in the pending buffer.
         */
        public var pending:int ;
        
        /**
         * Output still pending.
         */
        public var pendingBuffer:ByteArray ;
        
        /**
         * The size of the pending buffer.
         */
        public var pendingBufferSize:int ;
        
        /**
         * Next pending byte to output to the stream.
         */
        public var pendingOut:int ;
         
        /**
         * Link to older string with same hash index. To limit the size of this array to 64K, this link is maintained only for the last 32K strings. 
         * An index in this array is thus a window index modulo 32K.
         */
        public var prev:Array;
        
        /**
         * Length of the best match at previous step. 
         * Matches not greater than this are discarded. This is used in the lazy match evaluation. 
         */
        public var prevLength:int ;
        
        /**
         * Previous match.
         */
        public var prevMatch:int ;
        
        /**
         * As the name implies.
         */
        public var status:int ;
        
        /**
         * The pointer back to this zlib stream.
         */
        public var stream:ZStream ;
        
        /**
         * Start of string to insert.
         */
        public var strstart:int ; 
        
        /**
         * favor or force Huffman coding
         */ 
        public var strategy:int ;
        
        /**
         * log2(w_size)  (8..16)
         */
        public var wBits:int ;
        
        /**
         * This mask value is wSize - 1.
         */
        public var wMask:int ;
         
        /**
         * LZ77 window size (32K by default)
         */
        public var wSize:int ;
        
        /**
         * Sliding window. Input bytes are read into the second half of the window,
         * and move to the first half later to keep a dictionary of at least wSize bytes.
         * <p>With this organization, matches are limited to a distance of wSize-MAX_MATCH bytes, 
         * but this ensures that IO is always performed with a length multiple of the block size. 
         * Also, it limits the window size to 64K, which is quite useful on MSDOS.</p>
         */
        public var window:ByteArray;
    
        /**
         * Actual size of window: 2*wSize, except when the user input buffer is directly used as sliding window.
         */
        public var windowSize:int;
        
        
        
          // Size of match buffer for literals/lengths.  There are 4 reasons for
          // limiting lit_bufsize to 64K:
          //   - frequencies can be kept in 16 bit counters
          //   - if compression is not successful for the first block, all input
          //     data is still in the window so we can still emit a stored block even
          //     when input comes from standard input.  (This can also be done for
          //     all blocks if lit_bufsize is not greater than 32K.)
          //   - if compression is not successful for a file smaller than 64K, we can
          //     even emit a stored file instead of a stored block (saving 5 bytes).
          //     This is applicable only for zip (not gzip or zlib).
          //   - creating new Huffman trees less frequently may not provide fast
          //     adaptation to changes in the input data statistics. (Take for
          //     example a binary file with poorly compressible code followed by
          //     a highly compressible string table.) Smaller buffer sizes give
          //     fast adaptation but have of course the overhead of transmitting
          //     trees more frequently.
          //   - I can't count above 4
          public var litBuffersize:int;
        
          public var lastLit:int;      // running index in l_buf
        
          // Buffer for distances. To simplify the code, d_buf and l_buf have
          // the same number of elements. To use different lengths, an extra flag
          // array would be necessary.
          
          /**
           * index of pendigBuffer
           */
          public var dBuffer:int ; 
        
          public var optLength:int;        // bit length of current block with optimal trees
          public var staticLength:int;     // bit length of current block with static trees
          public var matches:int;        // number of string matches in current block
          public var lastEobLen:int;   // bit length of EOB code for last block
        
          // Output buffer. bits are inserted starting at the bottom (least
          // significant bits).
          public var biBuffer:int; // short
      
        /**
         * Number of valid bits in bi_buf.  All bits above the last valid bit are always zero.
         */
        public var biValid:int;

        /**
         * Initialize the trees.
         */
        public function initBlock():void
        {
        	var i:int ;
            for( i = 0; i < L_CODES ; i++ ) 
            {
                dynLtree[ i*2 ] = 0 ;
            }
            dynLtree[ END_BLOCK * 2 ] = 1 ;

            for( i = 0 ; i < D_CODES ; i++ ) 
            {
                dynDtree[ i*2 ] = 0;
            }

            for( i = 0 ; i < BL_CODES ; i++ )
            {
                blTree[ i*2 ] = 0 ;
            }

            optLength = staticLength = 0 ;
            lastLit   = matches      = 0 ;
        }

        /**
         * Initialize.
         */
        public function lmInit():void 
        {
            head[ hashSize - 1 ] = 0 ;
            for( var i:int ; i < hashSize - 1 ; i++ )
            {
                head[ i ] = 0 ;
            }
            
            // Set the default configuration parameters:
            var conf:Config = configs[level] as Config ;
            if ( conf != null )
            { 
                goodMatch      = conf.goodLength ;
                maxChainLength = conf.maxChain   ;
                maxLazyMatch   = conf.maxLazy    ;
                niceMatch      = conf.niceLength ;
            }
            
            blockStart     = 0 ;
            insertedHash   = 0 ;
            lookahead      = 0 ;
            matchAvailable = 0 ;
            strstart       = 0 ;
            windowSize     = 2 * wSize ;
            
            matchLength = prevLength = MIN_MATCH - 1 ;
        }
        
        /**
         * Restore the heap property by moving down the tree starting at node k, 
         * exchanging a node with the smallest of its two sons if necessary, stopping 
         * when the heap property is re-established (each father smaller than its two sons).
         * @param tree the tree to restore
         * @param k node to move down
         */
        public function pqDownHeap(tree:Array, k:int ):void
        {
            var v:int = heap[k];
            var j:int = k << 1;  // left son of k
            while (j <= heapLen) 
            {
                // Set j to the smallest of the two sons :
                if (j < heapLen && smaller( tree, heap[j+1] , heap[j] , depth) )
                {
                    j++;
                }
                // Exit if v is smaller than both sons
                if(smaller(tree, v, heap[j], depth)) 
                {
                    break;
                }
                // Exchange v with the smallest son
                heap[k] = heap[j] ;  
                k = j ;
                // And continue down the tree, setting j to the left son of k
                j <<= 1 ;
            }
            heap[k] = v;
          }    }}