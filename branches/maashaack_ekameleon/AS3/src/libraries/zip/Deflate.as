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
            
        }
        
        /**
         * Output still pending.
         */
        public var pendingBuffer:ByteArray ;
        
        /**
         * The size of the pending buffer.
         */
        public var pendingBufferSize:int ;
        
        public var pending_out:int;      // next pending byte to output to the stream
        public var pending:int;          // nb of bytes in the pending buffer
        
        /**
         * As the name implies.
         */
        public var status:int ;
        
        /**
         * The pointer back to this zlib stream.
         */
        public var stream:ZStream ;
        
         
        public var noheader:int;         // suppress zlib header and adler32
        
        public var dataType:int;       // UNKNOWN, BINARY or ASCII
      
        public var method:int;          // STORED (for zip only) or DEFLATED
        
        public var lastFlush:int;       // value of flush param for previous deflate call
        
        public var wBits:int;           // log2(w_size)  (8..16)
        public var wMask:int;           // w_size - 1
        public var wSize:int;           // LZ77 window size (32K by default)
        
      // Sliding window. Input bytes are read into the second half of the window,
      // and move to the first half later to keep a dictionary of at least wSize
      // bytes. With this organization, matches are limited to a distance of
      // wSize-MAX_MATCH bytes, but this ensures that IO is always
      // performed with a length multiple of the block size. Also, it limits
      // the window size to 64K, which is quite useful on MSDOS.
      // To do: use the user input buffer as sliding window.
        public var window:ByteArray;
    
      public var window_size:int;
      // Actual size of window: 2*wSize, except when the user input buffer
      // is directly used as sliding window.
    
      public var /*short[]*/ prev:Array;
      // Link to older string with same hash index. To limit the size of this
      // array to 64K, this link is maintained only for the last 32K strings.
      // An index in this array is thus a window index modulo 32K.
    
      public var /*short[]*/ head:Array; // Heads of the hash chains or NIL.
    
      public var ins_h:int;          // hash index of string to be inserted
      public var hash_size:int;      // number of elements in hash table
      public var hash_bits:int;      // log2(hash_size)
      public var hash_mask:int;      // hash_size-1
    
      // Number of bits by which ins_h must be shifted at each input
      // step. It must be such that after MIN_MATCH steps, the oldest
      // byte no longer takes part in the hash key, that is:
      // hash_shift * MIN_MATCH >= hash_bits
      public var hash_shift:int;
    
      // Window position at the beginning of the current output block. Gets
      // negative when the window is moved backwards.
    
      public var block_start:int;
    
      public var match_length:int;           // length of best match
      public var prev_match:int;             // previous match
      public var match_available:int;        // set if previous match exists
      public var strstart:int;               // start of string to insert
      public var match_start:int;            // start of matching string
      public var lookahead:int;              // number of valid bytes ahead in window
    
      // Length of the best match at previous step. Matches not greater than this
      // are discarded. This is used in the lazy match evaluation.
      public var prev_length:int;
    
      // To speed up deflation, hash chains are never searched beyond this
      // length.  A higher limit improves compression ratio but degrades the speed.
      public var max_chain_length:int;
    
      // Attempt to find a better match only when the current match is strictly
      // smaller than this value. This mechanism is used only for compression
      // levels >= 4.
      public var max_lazy_match:int;
    
      // Insert new strings in the hash table only if the match length is not
      // greater than this length. This saves time but degrades compression.
      // max_insert_length is used only for compression levels <= 3.
    
      public var level:int;    // compression level (1..9)
      public var strategy:int; // favor or force Huffman coding
    
      // Use a faster search when the previous match is longer than this
      public var good_match:int;
    
      // Stop searching when current match exceeds this
      public var nice_match:int;
    
      public var /*short[]*/ dyn_ltree:Array;       // literal and length tree
      public var /*short[]*/ dyn_dtree:Array;       // distance tree
      public var /*short[]*/ bl_tree:Array;         // Huffman tree for bit lengths
    
      public var l_desc:Tree=new Tree();  // desc for literal tree
      public var d_desc:Tree=new Tree();  // desc for distance tree
      public var bl_desc:Tree=new Tree(); // desc for bit length tree
    
      // number of codes at each bit length for an optimal tree
      public var /*short[]*/ bl_count:Array=new Array(MAX_BITS+1);
    
      // heap used to build the Huffman trees
      public var /*int[]*/ heap:Array=new Array(2*L_CODES+1);
    
      public var heap_len:int;               // number of elements in the heap
      public var heap_max:int;               // element of largest frequency
      // The sons of heap[n] are heap[2*n] and heap[2*n+1]. heap[0] is not used.
      // The same heap array is used to build all trees.
    
      // Depth of each subtree used as tie breaker for trees of equal frequency
      public var depth:ByteArray =new ByteArray() ;
    
      public var l_buf:int;               // index for literals or lengths */
    
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
      public var lit_bufsize:int;
    
      public var last_lit:int;      // running index in l_buf
    
      // Buffer for distances. To simplify the code, d_buf and l_buf have
      // the same number of elements. To use different lengths, an extra flag
      // array would be necessary.
    
      public var d_buf:int;         // index of pendig_buf
    
      public var opt_len:int;        // bit length of current block with optimal trees
      public var static_len:int;     // bit length of current block with static trees
      public var matches:int;        // number of string matches in current block
      public var last_eob_len:int;   // bit length of EOB code for last block
    
      // Output buffer. bits are inserted starting at the bottom (least
      // significant bits).
      public var bi_buf:int; // short
      
      /**
       * Number of valid bits in bi_buf.  All bits above the last valid bit are always zero.
       */
      public var biValid:int;
      
      // constants
      
      // block not completed, need more input or more output
      private static const NEED_MORE:int = 0 ; 
    
      // block flush performed
      private static const BLOCK_DONE:int = 1 ; 
    
      // finish started, need only more output at next deflate
      private static const FINISH_STARTED:int=2;
    
      // finish done, accept no more input or output
      private static const FINISH_DONE:int=3;
    
      // preset dictionary flag in zlib header
      private static const PRESET_DICT:int=0x20;
    
      private static const INIT_STATE:int=42;
      private static const BUSY_STATE:int=113;
      private static const FINISH_STATE:int=666;
    
      // The deflate compression method
      private static const Z_DEFLATED:int=8;
    
      private static const STORED_BLOCK:int=0;
      private static const STATIC_TREES:int=1;
      private static const DYN_TREES:int=2;
    
      // The three kinds of block type
      private static const Z_BINARY:int  = 0 ;
      private static const Z_ASCII:int   = 1 ;
      private static const Z_UNKNOWN:int = 2 ;
    
      private static const BUFFER_SIZE:int=8*2;
    
      // repeat previous bit length 3-6 times (2 bits of repeat count)
      private static const REP_3_6:int=16; 
    
      // repeat a zero length 3-10 times  (3 bits of repeat count)
      private static const REPZ_3_10:int=17; 
    
      // repeat a zero length 11-138 times  (7 bits of repeat count)
      private static const REPZ_11_138:int=18; 
    
      private static const MIN_MATCH:int=3;
      private static const MAX_MATCH:int=258;
      private static const MIN_LOOKAHEAD:int=(MAX_MATCH+MIN_MATCH+1);
    
      private static const MAX_BITS:int=15;
      private static const D_CODES:int=30;
      private static const BL_CODES:int=19;
      private static const LENGTH_CODES:int=29;
      private static const LITERALS:int=256;
      private static const L_CODES:int=(LITERALS+1+LENGTH_CODES);
      private static const HEAP_SIZE:int=(2*L_CODES+1);
    
      private static const END_BLOCK:int=256;
    }}