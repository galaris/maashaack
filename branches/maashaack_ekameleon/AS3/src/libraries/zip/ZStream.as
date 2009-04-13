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

    /**     * ZStream is the class for the stream which handles the compressed data. 
     * <p>The operations are defined in the subclasses <code class="prettyprint">Deflate</code> for compression, <code class="prettyprint">Inflate</code> for decompression.</p>
     * <p>An instance <code>ZStream</code> has one stream (struct zstream in the source) and two variable-length buffers which associated to the input (next_in) of the stream and the output (next_out) of the stream. In this document, "input buffer" means the buffer for input, and "output buffer" means the buffer for output.</p>
     * <p>Data input into an instance of ZStream are temporally stored into the end of input buffer, and then data in input buffer are processed from the beginning of the buffer until no more output from the stream is produced (i.e. until avail_out > 0 after processing). During processing, output buffer is allocated and expanded automatically to hold all output data.</p>
     * <p>Some particular instance methods consume the data in output buffer and return them as a String.</p>
     * <p>Here is an ascii art for describing above :</p>
     * <pre>
     * +================ an instance of Zlib::ZStream ================+
     * ||                                                            ||
     * ||     +--------+          +-------+          +--------+      ||
     * ||  +--| output |<---------|zstream|<---------| input  |<--+  ||
     * ||  |  | buffer |  next_out+-------+next_in   | buffer |   |  ||
     * ||  |  +--------+                             +--------+   |  ||
     * ||  |                                                      |  ||
     * +===|======================================================|===+
     *     |                                                      |
     *     v                                                      |
     * "output data"                                         "input data"
     * </pre>
     * <p>If an error occurs during processing input buffer, an exception which is a subclass of Error is raised. At that time, both input and output buffer keep their conditions at the time when the error occurs.</p>      */    public class ZStream 
    {
        /**
         * Creates a new ZStream instance.
         */
        public function ZStream()
        {
            
        }
        
        /**
         * The Adler value.
         */
        public var adler:uint ;
        
        /**
         * Number of bytes available at next_in.
         */
        public var availIn:int ;
        
        /**
         * Remaining free space at next_out.
         */
        public var availOut:int ;
        
        /**
         * The message value.
         */
        public var message:String;
        
        /**
         * Next input byte.
         */
        public var nextIn:ByteArray;
        
        /**
         * The next input index.
         */ 
        public var nextInIndex:int;
        
        /**
         * The next output byte should be put there.
         */
        public var nextOut:ByteArray ;
        
        /**
         * The next ouput index.
         */ 
        public var nextOutIndex:int ;
        
        /**
         * The total number of input bytes read so far.
         */
        public var totalIn:int ;
        
        /**
         * Total number of bytes output so far.
         */
        public var totalOut:int;
        
        /**
         * Free the memory of the ZStream reference.
         */
        public function free():void
        {
            _adler  = null ;
            nextIn  = null ;
            nextOut = null ;
            message = null ;
         }
              
        /**
         * @private
         */
        protected var _adler:Adler32 =new Adler32();
        
//        /**
//         * 32K LZ77 window
//         * @private
//         */
//        private static const MAX_WBITS:int = 15 ;
//
//        /**
//         * @private
//         */
//        private static const DEF_WBITS:int = MAX_WBITS ;
//        
//        /**
//         * @private
//         */
//        private static const MAX_MEM_LEVEL:int = 9 ;
            }}