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
    /**
     * The InflateTree class.
     */
    public class InflateTree 
    {
        
        /**
         * Creates a new InflateTree instance.
         */
        public function InflateTree()
        {
            //
        }
        
        /**
         * Bit length count table.
         */
        public var c:Array ; 
        
        /**
         * Hufts used in space.
         */
        public var hn:Array ;
        
        /**
         * Table entry for structure assignment
         */
        public var r:Array ; 
        
        /**
         * Table stack.
         */
        public var u:Array ; 
         
        /**
         * Work area for huft build. 
         */
        public var v:Array ;
        
        /**
         * Bit offsets, then code stack
         */
        public var x:Array ; 

        /**
         * Inflate the bits of the trees.
         * @param c 19 code lengths
         * @param bb bits tree desired/actual depth
         * @param tb bits tree result
         * @param hp space for trees
         * @param z for messages
         */
        public function bits( c:Array, bb:Array, tb:Array, hp:Array, z:ZStream ):int
        {
            var result:int ;
            _initWorkArea(19) ;
            hn[0] = 0 ;
            result = _huftBuild(c, 0, 19, 19, null, null, tb, bb, hp, hn, v) ;
            if(result == Z_DATA_ERROR)
            {
                z.msg = "oversubscribed dynamic bit lengths tree";
            }
            else if(result == Z_BUF_ERROR || bb[0] == 0)
            {
                z.msg = "incomplete dynamic bit lengths tree" ;
                result = Z_DATA_ERROR ;
            }
            return result ;
        }
        
        /**
         * Inflate trees dynamic.
         * @param nl Number of literal/length codes.
         * @param nd Number of distance codes.
         * @param c That many (total) code lengths.
         * @param bl Literal desired/actual bit depth.
         * @param bd Distance desired/actual bit depth.
         * @param tl Literal/length tree result.
         * @param td Distance tree result.
         * @param hp Space for trees.
         * @param z For messages.
         */
        public function dynamics( nl:int , nd:int, c:Array , bl:Array , bd:Array , tl:Array , td:Array , hp:Array, z:ZStream ):int
        {
            var result:int;
            _initWorkArea(288); // build literal/length tree
            hn[0] = 0 ;
            result = _huftBuild(c, 0, nl, 257, cpLens, cpLext, tl, bl, hp, hn, v);
            if (result != Z_OK || bl[0] == 0)
            {
                if(result == Z_DATA_ERROR)
                {
                    z.msg = "oversubscribed literal/length tree";
                }
                else if (result != Z_MEM_ERROR)
                {
                    z.msg = "incomplete literal/length tree";
                    result = Z_DATA_ERROR;
                }
            }
            return result;
        }

        /**
         * Given a list of code lengths and a maximum table size, make a set of tables to decode that set of codes.
         * @param b The code lengths in bits (all assumed <= BMAX).
         * @param bindex The index of the code.
         * @param n Number of codes (assumed <= 288).
         * @param s Number of simple-valued codes (0..s-1).
         * @param d List of base values for non-simple codes.
         * @param e List of extra bits for non-simple codes.
         * @param t Result: starting table.
         * @param m Maximum lookup bits, returns actual.
         * @param hp Space for trees.
         * @param hn Hufts used in space.
         * @param v Working area: values in order of bit length.
         * @return Return 
         * Z_OK on success, 
         * Z_BUF_ERROR if the given code set is incomplete (the tables are still built in this case), 
         * Z_DATA_ERROR if the input is invalid (an over-subscribed set of lengths), or 
         * Z_MEM_ERROR if not enough memory.
         * @private
         */
        private function _huftBuild( b:Array, bindex:int, n:int, s:int, d:Array, e:Array, t:Array, m:Array, hp:Array , hn:Array , v:Array ):int
        {
            var    a:int ; // counter for codes of length k
            var    f:int ; // i repeats in table every f entries
            var    g:int ; // maximum code length
            var    h:int ; // table level
            var    i:int ; // counter, current code
            var    j:int ; // counter
            var    k:int ; // number of bits in current code
            var    l:int ; // bits per table (returned in m)
            var mask:int ; // (1 << w) - 1, to avoid cc -O bug on HP
            var    p:int ; // pointer into c[], b[], or v[]
            var    q:int ; // points to current table
            var    w:int ; // bits before this table == (l * h)
            var   xp:int ; // pointer into x
            var    y:int ; // number of dummy codes added
            var    z:int ; // number of entries in current table 
            
            // Generate counts for each bit length
            
            p = 0 ;
            i = n ;
            
            do 
            {
                c[ b[ bindex+p] ]++ ; 
                p++ ; 
                i-- ; // assume all entries <= BMAX
            }
            while( i != 0 ) ;
            
            if(c[0] == n) // null input--all zero length codes
            {
                t[0] = -1   ;
                m[0] = 0    ;
                return Z_OK ;
            }

            // Find minimum and maximum length, bound *m by those
            
            l = m[0] ;
            
            for (j = 1; j <= BMAX; j++)
            {
                if(c[j]!=0) break;
            }
            
            k = j ; // minimum code length
            
            if( l < j )
            {
                l = j;
            }
            
            for (i = BMAX; i!=0; i--)
            {
                if( c[i]!=0 ) 
                {
                    break ;
                }
            }
            
            g = i ; // maximum code length
            
            if( l > i )
            {
                l = i ;
            }
            m[0] = l ;
            
            // Adjust last length count to fill out codes, if needed
            for ( y = 1 << j ; j < i ; j++ , y <<= 1 )
            {
                if ((y -= c[j]) < 0)
                {
                    return Z_DATA_ERROR ;
                }
            }
            
            if ((y -= c[i]) < 0)
            {
                return Z_DATA_ERROR ;
            }
            c[i] += y ;

            // Generates starting offsets into the value table for each length
            
            x[1] = j = 0 ;
            p  = 1 ;  
            xp = 2 ;
            
            // note that i == g from above
            
            while ( --i!=0 ) 
            {
                x[xp] = (j += c[p]);
                xp++ ;
                p++ ;
            }
            
            // Makes a table of values in order of bit lengths
            
            i = 0 ; 
            p = 0 ;
            do 
            {
                if ( (j = b[ bindex + p ] ) != 0 )
                {
                    v[ x[ j ]++ ] = i;
                }
                p++;
            }
            while ( ++i < n ) ;
            
            n = x[g] ; // set n to length of v
            
            // Generates the Huffman codes and for each, make the table entries
            
            x[0] = i =  0 ; // first Huffman code is zero
            p        =  0 ; // grab values in bit order
            h        = -1 ; // no tables yet--level -1
            w        = -l ; // bits decoded == (l * h)
            u[0]     =  0 ; // just to keep compilers happy
            q        =  0 ; // ditto
            z        =  0 ; // ditto
            
            // Go through the bit lengths (k already is bits in shortest code)
            
            for ( ; k <= g ; k++ )
            {
                a = c[k] ;
                while ( a--!=0 )
                {
                    // here i is the Huffman code of length k bits for value *p
                    // make tables up to required level
                    while (k > w + l)
                    {
                        h++   ;
                        w += l; // previous table always l bits
                        // compute minimum size table less than or equal to l bits
                        z = g - w;
                        z = (z > l) ? l : z ; // table size upper limit
                        // try a k-w bit table too few codes for k-w bit table
                        if( ( f=1 << (j=k-w)) > a+1 )
                        {     
                            f -= a + 1 ; // deduct codes from patterns left
                            xp = k ;
                            if( j < z )
                            {
                                while (++j < z) // try smaller tables up to z bits
                                {
                                    if( (f <<= 1) <= c[++xp] )
                                    {
                                        break ; // enough codes to use up j bits
                                    }
                                    f -= c[xp] ; // else deduct codes from patterns
                                }
                            }
                        }
                        z = 1 << j ; // table entries for j-bit table
                        
                        // allocate new table
                        
                        if (hn[0] + z > MANY )
                        {
                            return Z_DATA_ERROR ; // overflow of MANY
                        }
                        u[h] = q = /*hp+*/ hn[0] ; // DEBUG
                        hn[0] += z;
                        
                        // connect to last table, if there is one
                        
                        if(h!=0)
                        {
                            x[h] = i       ; // save pattern for backing up
                            r[0] = 255 & j ; // bits in this table
                            r[1] = 255 & l ; // bits to dump before this table
                            j    = i >>> (w - l) ;
                            r[2] = int(q - u[h-1] - j) ; // offset to this table
                            arrayCopy(r, 0, hp, (u[h-1]+j)*3, 3); // connect to last table
                        }
                        else
                        {
                            t[0] = q ; // first table is returned result
                        }
                    }
                    
                    // set up table entry in r
                    
                    r[1] = 255&(k - w) ;
                    if (p >= n)
                    {
                        r[0] = 128 + 64 ;  // out of values--invalid code
                    }
                    else if (v[p] < s)
                    {
                        r[0] = 255 & ( v[p] < 256 ? 0 : 32 + 64 ) ; // 256 is end-of-block
                        r[2] = v[p++] ; // simple code is just the value
                    }
                    else
                    {
                       r[0] = 255 & ( e[v[p] - s ] + 16 + 64 ) ; // non-simple--look up in lists
                       r[2] = d[ v[p++] - s ] ;
                    }
                    
                    // fill code-like entries with r
                    f=1 << (k-w) ;
                    for (j=i>>>w;j<z;j+=f)
                    {
                        arrayCopy(r, 0, hp, (q+j)*3, 3) ;
                    }
                    
                    // backwards increment the k-bit code i
                    
                    for (j = 1 << (k - 1); (i & j)!=0; j >>>= 1)
                    {
                        i ^= j;
                    }
                    i ^= j;
                    
                    // backup over finished tables
                    
                    mask = (1 << w) - 1 ; // needed on HP, cc -O bug
                    
                    while ((i & mask) != x[h])
                    {
                        h-- ; // don't need to update q
                        w -= l;
                        mask = (1 << w) - 1;
                    }
                }
            }
            
            // Return Z_BUF_ERROR if we were given an incomplete table
            
            return y != 0 && g != 1 ? Z_BUF_ERROR : Z_OK;
        }
        
        /**
         * @private
         */
        private function _initWorkArea( vsize:int ):void
        {
            if( hn == null )
            {
                hn = new Array( 1 ) ;
                 v = new Array( vsize ) ;
                 c = new Array( BMAX + 1 ) ; 
                 r = new Array( 3 ) ;
                 u = new Array( BMAX ) ;
                 x = new Array( BMAX + 1 ) ;
            }
            if( v.length < vsize )
            { 
                v = new Array( vsize ) ; 
            }
            var i:int ;
            for( i = 0 ; i < vsize ; i++ )
            {
                v[i] = 0 ;
            }
            for( i = 0 ; i < BMAX + 1 ; i++ )
            {
                c[i] = 0 ;
            }
            for( i = 0 ; i<3 ; i++ )
            {
                r[i] = 0 ;
            }
            arrayCopy( c , 0 , u , 0 , BMAX     ) ;
            arrayCopy( c , 0 , x , 0 , BMAX + 1 ) ;
        }
        
        ////////////////// static
        
        /**
         * Maximum bit length of any code.
         * If BMAX needs to be larger than 16, then h and x[] should be uLong.
         */
        public static const BMAX:int = 15 ;
        
        /**
         * Extra bits for distance codes.
         */
        public static const cpDext:Array = 
        [ 
             0 ,  0 ,  0 ,  0 , 1 , 1 ,  2 ,  2 ,  3 ,  3 , 4 , 4 , 5 , 5 , 6 , 6 ,
             7 ,  7 ,  8 ,  8 , 9 , 9 , 10 , 10 , 11 , 11 ,
            12 , 12 , 13 , 13
        ];
        
        /**
         * Copy offsets for distance codes 0..29.
         */
        public static const cpDist:Array = 
        [ 
               1 ,     2 ,     3 ,     4 ,    5 ,    7 ,    9 ,   13 ,   17 ,   25 , 33 , 49 , 65 , 97 , 129 , 193 ,
             257 ,   385 ,   513 ,   769 , 1025,  1537 , 2049 , 3073 , 4097 , 6145,
            8193 , 12289 , 16385 , 24577
        ];
        
        /**
         * Copy lengths for literal codes 257..285.
         * Tables for deflate from PKZIP's appnote.txt.
         */
        public static const cpLens:Array = 
        [ 
             3 ,  4 ,  5 ,  6 ,  7 ,  8 ,  9 ,  10 ,  11 ,  13 ,  15 ,  17 ,  19 , 23 , 27 , 31,
            35 , 43 , 51 , 59 , 67 , 83 , 99 , 115 , 131 , 163 , 195 , 227 , 258 ,  0 ,  0
        ];
        
        
        /**
         * Extra bits for literal codes 257..285.
         * see note #13 above about 258
         */
        public static const cpLext:Array = 
        [ 
            0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 2 ,   2 ,   2 , 2 ,
            3 , 3 , 3 , 3 , 4 , 4 , 4 , 4 , 5 , 5 , 5 , 5 , 0 , 112 , 112  // 112==invalid
        ];
        
        /**
         * The default distance desired/actual bit depth.
         */
        public static const fixedBD:int = 5 ;
        
        /**
         * The default literal desired/actual bit depth.
         */
        public static const fixedBL:int = 9 ;
        
        /**
         * The default distance tree result. 
         */
        public static const fixedTD:Array = 
        [
            80 , 5 ,  1 , 87 , 5 ,  257 , 83 , 5 ,  17 ,  91 , 5 ,  4097 ,
            81 , 5 ,  5 , 89 , 5 , 1025 , 85 , 5 ,  65 ,  93 , 5 , 16385 ,
            80 , 5 ,  3 , 88 , 5 ,  513 , 84 , 5 ,  33 ,  92 , 5 ,  8193 ,
            82 , 5 ,  9 , 90 , 5 , 2049 , 86 , 5 , 129 , 192 , 5 , 24577 ,
            80 , 5 ,  2 , 87 , 5 ,  385 , 83 , 5 ,  25 ,  91 , 5 ,  6145 ,
            81 , 5 ,  7 , 89 , 5 , 1537 , 85 , 5 ,  97 ,  93 , 5 , 24577 ,
            80 , 5 ,  4 , 88 , 5 ,  769 , 84 , 5 ,  49 ,  92 , 5 , 12289 ,
            82 , 5 , 13 , 90 , 5 , 3073 , 86 , 5 , 193 , 192 , 5 , 24577
        ] ;
        
        /**
         * The default literal/length tree result.
         */
        public static const fixedTL:Array = 
        [
            96 , 7 , 256 , 0 , 8 ,  80 , 0 , 8 , 16 ,  84 , 8 , 115 ,
            82 , 7 ,  31 , 0 , 8 , 112 , 0 , 8 , 48 ,   0 , 9 , 192 ,
            80 , 7 ,  10 , 0 , 8 ,  96 , 0 , 8 , 32 ,   0 , 9 , 160 ,
             0 , 8 ,   0 , 0 , 8 , 128 , 0 , 8 , 64 ,   0 , 9 , 224 ,
            80 , 7 ,   6 , 0 , 8 ,  88 , 0 , 8 , 24 ,   0 , 9 , 144 ,
            83 , 7 ,  59 , 0 , 8 , 120 , 0 , 8 , 56 ,   0 , 9 , 208 ,
            81 , 7 ,  17 , 0 , 8 , 104 , 0 , 8 , 40 ,   0 , 9 , 176 ,
             0 , 8 ,   8 , 0 , 8 , 136 , 0 , 8 , 72 ,   0 , 9 , 240 ,
            80 , 7 ,   4 , 0 , 8 ,  84 , 0 , 8 , 20 ,  85 , 8 , 227 ,
            83 , 7 ,  43 , 0 , 8 , 116 , 0 , 8 , 52 ,   0 , 9 , 200 ,
            81 , 7 ,  13 , 0 , 8 , 100 , 0 , 8 , 36 ,   0 , 9 , 168 ,
             0 , 8 ,   4 , 0 , 8 , 132 , 0 , 8 , 68 ,   0 , 9 , 232 ,
            80 , 7 ,   8 , 0 , 8 ,  92 , 0 , 8 , 28 ,   0 , 9 , 152 ,
            84 , 7 ,  83 , 0 , 8 , 124 , 0 , 8 , 60 ,   0 , 9 , 216 ,
            82 , 7 ,  23 , 0 , 8 , 108 , 0 , 8 , 44 ,   0 , 9 , 184 ,
             0 , 8 ,  12 , 0 , 8 , 140 , 0 , 8 , 76 ,   0 , 9 , 248 ,
            80 , 7 ,   3 , 0 , 8 ,  82 , 0 , 8 , 18 ,  85 , 8 , 163 ,
            83 , 7 ,  35 , 0 , 8 , 114 , 0 , 8 , 50 ,   0 , 9 , 196 ,
            81 , 7 ,  11 , 0 , 8 ,  98 , 0 , 8 , 34 ,   0 , 9 , 164 ,
             0 , 8 ,   2 , 0 , 8 , 130 , 0 , 8 , 66 ,   0 , 9 , 228 ,
            80 , 7 ,   7 , 0 , 8 ,  90 , 0 , 8 , 26 ,   0 , 9 , 148 ,
            84 , 7 ,  67 , 0 , 8 , 122 , 0 , 8 , 58 ,   0 , 9 , 212 ,
            82 , 7 ,  19 , 0 , 8 , 106 , 0 , 8 , 42 ,   0 , 9 , 180 ,
             0 , 8 ,  10 , 0 , 8 , 138 , 0 , 8 , 74 ,   0 , 9 , 244 ,
            80 , 7 ,   5 , 0 , 8 ,  86 , 0 , 8 , 22 , 192 , 8 ,   0 ,
            83 , 7 ,  51 , 0 , 8 , 118 , 0 , 8 , 54 ,   0 , 9 , 204 ,
            81 , 7 ,  15 , 0 , 8 , 102 , 0 , 8 , 38 ,   0 , 9 , 172 ,
             0 , 8 ,   6 , 0 , 8 , 134 , 0 , 8 , 70 ,   0 , 9 , 236 ,
            80 , 7 ,   9 , 0 , 8 ,  94 , 0 , 8 , 30 ,   0 , 9 , 156 ,
            84 , 7 ,  99 , 0 , 8 , 126 , 0 , 8 , 62 ,   0 , 9 , 220 ,
            82 , 7 ,  27 , 0 , 8 , 110 , 0 , 8 , 46 ,   0 , 9 , 188 ,
             0 , 8 ,  14 , 0 , 8 , 142 , 0 , 8 , 78 ,   0 , 9 , 252 ,
            96 , 7 , 256 , 0 , 8 ,  81 , 0 , 8 , 17 ,  85 , 8 , 131 ,
            82 , 7 ,  31 , 0 , 8 , 113 , 0 , 8 , 49 ,   0 , 9 , 194 ,
            80 , 7 ,  10 , 0 , 8 ,  97 , 0 , 8 , 33 ,   0 , 9 , 162 ,
             0 , 8 ,   1 , 0 , 8 , 129 , 0 , 8 , 65 ,   0 , 9 , 226 ,
            80 , 7 ,   6 , 0 , 8 ,  89 , 0 , 8 , 25 ,   0 , 9 , 146 ,
            83 , 7 ,  59 , 0 , 8 , 121 , 0 , 8 , 57 ,   0 , 9 , 210 ,
            81 , 7 ,  17 , 0 , 8 , 105 , 0 , 8 , 41 ,   0 , 9 , 178 ,
             0 , 8 ,   9 , 0 , 8 , 137 , 0 , 8 , 73 ,   0 , 9 , 242 ,
            80 , 7 ,   4 , 0 , 8 ,  85 , 0 , 8 , 21 ,  80 , 8 , 258 ,
            83 , 7 ,  43 , 0 , 8 , 117 , 0 , 8 , 53 ,   0 , 9 , 202 ,
            81 , 7 ,  13 , 0 , 8 , 101 , 0 , 8 , 37 ,   0 , 9 , 170 ,
             0 , 8 ,   5 , 0 , 8 , 133 , 0 , 8 , 69 ,   0 , 9 , 234 ,
            80 , 7 ,   8 , 0 , 8 ,  93 , 0 , 8 , 29 ,   0 , 9 , 154 ,
            84 , 7 ,  83 , 0 , 8 , 125 , 0 , 8 , 61 ,   0 , 9 , 218 ,
            82 , 7 ,  23 , 0 , 8 , 109 , 0 , 8 , 45 ,   0 , 9 , 186 ,
             0 , 8 ,  13 , 0 , 8 , 141 , 0 , 8 , 77 ,   0 , 9 , 250 ,
            80 , 7 ,   3 , 0 , 8 ,  83 , 0 , 8 , 19 ,  85 , 8 , 195 ,
            83 , 7 ,  35 , 0 , 8 , 115 , 0 , 8 , 51 ,   0 , 9 , 198 ,
            81 , 7 ,  11 , 0 , 8 ,  99 , 0 , 8 , 35 ,   0 , 9 , 166 ,
             0 , 8 ,   3 , 0 , 8 , 131 , 0 , 8 , 67 ,   0 , 9 , 230 ,
            80 , 7 ,   7 , 0 , 8 ,  91 , 0 , 8 , 27 ,   0 , 9 , 150 ,
            84 , 7 ,  67 , 0 , 8 , 123 , 0 , 8 , 59 ,   0 , 9 , 214 ,
            82 , 7 ,  19 , 0 , 8 , 107 , 0 , 8 , 43 ,   0 , 9 , 182 ,
             0 , 8 ,  11 , 0 , 8 , 139 , 0 , 8 , 75 ,   0 , 9 , 246 ,
            80 , 7 ,   5 , 0 , 8 ,  87 , 0 , 8 , 23 , 192 , 8 ,   0 ,
            83 , 7 ,  51 , 0 , 8 , 119 , 0 , 8 , 55 ,   0 , 9 , 206 ,
            81 , 7 ,  15 , 0 , 8 , 103 , 0 , 8 , 39 ,   0 , 9 , 174 ,
             0 , 8 ,   7 , 0 , 8 , 135 , 0 , 8 , 71 ,   0 , 9 , 238 ,
            80 , 7 ,   9 , 0 , 8 ,  95 , 0 , 8 , 31 ,   0 , 9 , 158 ,
            84 , 7 ,  99 , 0 , 8 , 127 , 0 , 8 , 63 ,   0 , 9 , 222 ,
            82 , 7 ,  27 , 0 , 8 , 111 , 0 , 8 , 47 ,   0 , 9 , 190 ,
             0 , 8 ,  15 , 0 , 8 , 143 , 0 , 8 , 79 ,   0 , 9 , 254 ,
            96 , 7 , 256 , 0 , 8 ,  80 , 0 , 8 , 16 ,  84 , 8 , 115 ,
            82 , 7 ,  31 , 0 , 8 , 112 , 0 , 8 , 48 ,   0 , 9 , 193 , 
             
            80 , 7 ,  10 , 0 , 8 ,  96 , 0 , 8 , 32 ,   0 , 9 , 161 ,
             0 , 8 ,   0 , 0 , 8 , 128 , 0 , 8 , 64 ,   0 , 9 , 225 ,
            80 , 7 ,   6 , 0 , 8 ,  88 , 0 , 8 , 24 ,   0 , 9 , 145 ,
            83 , 7 ,  59 , 0 , 8 , 120 , 0 , 8 , 56 ,   0 , 9 , 209 ,
            81 , 7 ,  17 , 0 , 8 , 104 , 0 , 8 , 40 ,   0 , 9 , 177 ,
             0 , 8 ,   8 , 0 , 8 , 136 , 0 , 8 , 72 ,   0 , 9 , 241 ,
            80 , 7 ,   4 , 0 , 8 ,  84 , 0 , 8 , 20 ,  85 , 8 , 227 ,
            83 , 7 ,  43 , 0 , 8 , 116 , 0 , 8 , 52 ,   0 , 9 , 201 ,
            81 , 7 ,  13 , 0 , 8 , 100 , 0 , 8 , 36 ,   0 , 9 , 169 ,
             0 , 8 ,   4 , 0 , 8 , 132 , 0 , 8 , 68 ,   0 , 9 , 233 ,
            80 , 7 ,   8 , 0 , 8 ,  92 , 0 , 8 , 28 ,   0 , 9 , 153 ,
            84 , 7 ,  83 , 0 , 8 , 124 , 0 , 8 , 60 ,   0 , 9 , 217 ,
            82 , 7 ,  23 , 0 , 8 , 108 , 0 , 8 , 44 ,   0 , 9 , 185 ,
             0 , 8 ,  12 , 0 , 8 , 140 , 0 , 8 , 76 ,   0 , 9 , 249 ,
            80 , 7 ,   3 , 0 , 8 ,  82 , 0 , 8 , 18 ,  85 , 8 , 163 ,
            83 , 7 ,  35 , 0 , 8 , 114 , 0 , 8 , 50 ,   0 , 9 , 197 ,
            81 , 7 ,  11 , 0 , 8 ,  98 , 0 , 8 , 34 ,   0 , 9 , 165 ,
             0 , 8 ,   2 , 0 , 8 , 130 , 0 , 8 , 66 ,   0 , 9 , 229 ,
            80 , 7 ,   7 , 0 , 8 ,  90 , 0 , 8 , 26 ,   0 , 9 , 149 ,
            84 , 7 ,  67 , 0 , 8 , 122 , 0 , 8 , 58 ,   0 , 9 , 213 ,
            82 , 7 ,  19 , 0 , 8 , 106 , 0 , 8 , 42 ,   0 , 9 , 181 ,
             0 , 8 ,  10 , 0 , 8 , 138 , 0 , 8 , 74 ,   0 , 9 , 245 ,
            80 , 7 ,   5 , 0 , 8 ,  86 , 0 , 8 , 22 , 192 , 8 ,   0 , 
            83 , 7 ,  51 , 0 , 8 , 118 , 0 , 8 , 54 ,   0 , 9 , 205 ,
            81 , 7 ,  15 , 0 , 8 , 102 , 0 , 8 , 38 ,   0 , 9 , 173 ,
             0 , 8 ,   6 , 0 , 8 , 134 , 0 , 8 , 70 ,   0 , 9 , 237 ,
            80 , 7 ,   9 , 0 , 8 ,  94 , 0 , 8 , 30 ,   0 , 9 , 157 ,
            84 , 7 ,  99 , 0 , 8 , 126 , 0 , 8 , 62 ,   0 , 9 , 221 ,
            82 , 7 ,  27 , 0 , 8 , 110 , 0 , 8 , 46 ,   0 , 9 , 189 ,
             0 , 8 ,  14 , 0 , 8 , 142 , 0 , 8 , 78 ,   0 , 9 , 253 ,
            96 , 7 , 256 , 0 , 8 ,  81 , 0 , 8 , 17 ,  85 , 8 , 131 ,
            82 , 7 ,  31 , 0 , 8 , 113 , 0 , 8 , 49 ,   0 , 9 , 195 ,
            80 , 7 ,  10 , 0 , 8 ,  97 , 0 , 8 , 33 ,   0 , 9 , 163 ,
             0 , 8 ,   1 , 0 , 8 , 129 , 0 , 8 , 65 ,   0 , 9 , 227 ,
            80 , 7 ,   6 , 0 , 8 ,  89 , 0 , 8 , 25 ,   0 , 9 , 147 ,
            83 , 7 ,  59 , 0 , 8 , 121 , 0 , 8 , 57 ,   0 , 9 , 211 ,
            81 , 7 ,  17 , 0 , 8 , 105 , 0 , 8 , 41 ,   0 , 9 , 179 ,
             0 , 8 ,   9 , 0 , 8 , 137 , 0 , 8 , 73 ,   0 , 9 , 243 ,
            80 , 7 ,   4 , 0 , 8 ,  85 , 0 , 8 , 21 ,  80 , 8 , 258 ,
            83 , 7 ,  43 , 0 , 8 , 117 , 0 , 8 , 53 ,   0 , 9 , 203 ,
            81 , 7 ,  13 , 0 , 8 , 101 , 0 , 8 , 37 ,   0 , 9 , 171 ,
             0 , 8 ,   5 , 0 , 8 , 133 , 0 , 8 , 69 ,   0 , 9 , 235 ,
            80 , 7 ,   8 , 0 , 8 ,  93 , 0 , 8 , 29 ,   0 , 9 , 155 ,
            84 , 7 ,  83 , 0 , 8 , 125 , 0 , 8 , 61 ,   0 , 9 , 219 ,
            82 , 7 ,  23 , 0 , 8 , 109 , 0 , 8 , 45 ,   0 , 9 , 187 ,
             0 , 8 ,  13 , 0 , 8 , 141 , 0 , 8 , 77 ,   0 , 9 , 251 ,
            80 , 7 ,   3 , 0 , 8 ,  83 , 0 , 8 , 19 ,  85 , 8 , 195 ,
            83 , 7 ,  35 , 0 , 8 , 115 , 0 , 8 , 51 ,   0 , 9 , 199 ,
            81 , 7 ,  11 , 0 , 8 ,  99 , 0 , 8 , 35 ,   0 , 9 , 167 ,
             0 , 8 ,   3 , 0 , 8 , 131 , 0 , 8 , 67 ,   0 , 9 , 231 ,
            80 , 7 ,   7 , 0 , 8 ,  91 , 0 , 8 , 27 ,   0 , 9 , 151 ,
            84 , 7 ,  67 , 0 , 8 , 123 , 0 , 8 , 59 ,   0 , 9 , 215 ,
            82 , 7 ,  19 , 0 , 8 , 107 , 0 , 8 , 43 ,   0 , 9 , 183 ,
             0 , 8 ,  11 , 0 , 8 , 139 , 0 , 8 , 75 ,   0 , 9 , 247 ,
            80 , 7 ,   5 , 0 , 8 ,  87 , 0 , 8 , 23 , 192 , 8 ,   0 ,
            83 , 7 ,  51 , 0 , 8 , 119 , 0 , 8 , 55 ,   0 , 9 , 207 ,
            81 , 7 ,  15 , 0 , 8 , 103 , 0 , 8 , 39 ,   0 , 9 , 175 ,
             0 , 8 ,   7 , 0 , 8 , 135 , 0 , 8 , 71 ,   0 , 9 , 239 ,
            80 , 7 ,   9 , 0 , 8 ,  95 , 0 , 8 , 31 ,   0 , 9 , 159 ,
            84 , 7 ,  99 , 0 , 8 , 127 , 0 , 8 , 63 ,   0 , 9 , 223 ,
            82 , 7 ,  27 , 0 , 8 , 111 , 0 , 8 , 47 ,   0 , 9 , 191 ,
             0 , 8 ,  15 , 0 , 8 , 143 , 0 , 8 , 79 ,   0 , 9 , 255
        ] ;
        
        /**
         * The MANY value.
         */
        public static const MANY:int = 1440 ;
        
        /**
         * Fixed the inflate tree and return this value.
         * @param bl literal desired/actual bit depth.
         * @param bd distance desired/actual bit depth.
         * @param tl literal/length tree result.
         * @param td distance tree result.
         * @param z for memory allocation // TODO remove ??
         */
        public static function fixed( bl:Array , bd:Array , tl:Array, td:Array , z:ZStream ):int
        {
            bl[0] = fixedBL ;
            bd[0] = fixedBD ;
            tl[0] = fixedTL ;
            td[0] = fixedTD ;
            return Z_OK;
        }
    }
}