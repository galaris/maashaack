/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package flash.utils
{
    /**
     * The ByteArray class provides methods and properties to optimize reading, writing,
     * and working with binary data.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    [native(cls="::avmshell::ByteArrayClass", instance="::avmshell::ByteArrayObject", methods="auto")]
    public class ByteArray implements IDataInput, IDataOutput
    {
        private static var _defaultObjectEncoding:uint = ObjectEncoding.AMF3;

        private var _objectEncoding:uint;
        
        /* note:
           the ByteArray class in Tamarin misses some methods found in the flash player
           for ex: deflate() , inflate(), clear(), readObject(), writeObject(), etc.

           and also add 2 methods: readFile(), writeFile();
           
        */
        public function ByteArray()
        {
            CFG::dbg{ trace( "new ByteArray()" ); }
            super();
            _objectEncoding = ByteArray.defaultObjectEncoding;
        }

        /* note:
           already implemented, but ignored to follow the flash API signature

           TODO
           move those 2 functionality to another class ? utility ?
        */
        //public native static function readFile( filename:String ):ByteArray;
        //public native function writeFile( filename:String ):void;

        //public static native function get defaultObjectEncoding():uint;
        public static function get defaultObjectEncoding():uint
        {
            CFG::dbg{ trace( "[static] ByteArray.get defaultObjectEncoding()" ); }
            return _defaultObjectEncoding;
        }

        //public static native function set defaultObjectEncoding(version:uint):void;
        public static native function set defaultObjectEncoding( version:uint ):void
        {
            CFG::dbg{ trace( "[static] ByteArray.set defaultObjectEncoding( " + version + " )" ); }
            _defaultObjectEncoding = version;
        }
    
        public native function readBytes( bytes:ByteArray, offset:uint = 0, length:uint = 0 ):void;

        public native function writeBytes( bytes:ByteArray, offset:uint = 0, length:uint = 0 ):void;

        public native function writeBoolean( value:Boolean ):void;

        public native function writeByte( value:int ):void;

        public native function writeShort( value:int ):void;

        public native function writeInt( value:int ):void;

        public native function writeUnsignedInt( value:uint ):void;

        public native function writeFloat( value:Number ):void;

        public native function writeDouble( value:Number ):void;

        //public native function writeMultiByte( value:String, charSet:String ):void;
        public function writeMultiByte( value:String, charSet:String ):void
        {
            //TODO
        }

        public native function writeUTF( value:String ):void;

        public native function writeUTFBytes( value:String ):void;

        public native function readBoolean():Boolean;

        public native function readByte():int;

        public native function readUnsignedByte():uint;

        public native function readShort():int;

        public native function readUnsignedShort():uint;

        public native function readInt():int;

        public native function readUnsignedInt():uint;

        public native function readFloat():Number;

        public native function readDouble():Number;

        //public native function readMultiByte( length:uint, charSet:String ):String;
        public function readMultiByte( length:uint, charSet:String ):String
        {
            //TODO
            return "";
        }

        public native function readUTF():String;

        public native function readUTFBytes(length:uint):String;

        public native function get length():uint;
        public native function set length( value:uint ):void;

        //public native function writeObject( object:* ):void;
        public function writeObject( object:* ):void
        {
            //TODO
            /* Writes an object into the byte array in AMF serialized format. */
        }

        //public native function readObject():*;
        public function readObject():*
        {
            //TODO
            /* Reads an object from the byte array, encoded in AMF serialized format. */
            return null;
        }

        //private native function _compress( algorithm:String ):void;
        private native function zlib_compress():void;

        //private native function _uncompress( algorithm:String ):void;
        private native function zlib_uncompress():void;

        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function deflate():void
        {
            //_compress( "deflate" );
            zlib_compress();
        }

        /* note:
           simply follow the Flash documentation to implement ;)
           
           Decompresses the byte array using the deflate compression algorithm.
           The byte array must have been compressed using the same algorithm.

           After the call, the length property of the ByteArray is set to the new length.
           The position property is set to 0.

           The deflate compression algorithm is described at http://www.ietf.org/rfc/rfc1951.txt.

           In order to decode data compressed in a format that uses the deflate compression algorithm,
           such as data in gzip or zip format, it will not work to simply call inflate() on a ByteArray
           containing the compression formation data.
           First, you must separate the metadata that is included as part of the compressed data format
           from the actual compressed data.
           For more information, see the compress() method description.

           Throws
           IOError — The data is not valid compressed data;
                     it was not compressed with the same compression algorithm used to compress.
        */
        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.0
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_0)]
        public function inflate():void
        {
            //_uncompress( "deflate" );
            zlib_uncompress();
        }
        
        private native function _toString():String;
        
        public function toString():String
        {
            return _toString();
        }

        public native function get bytesAvailable():uint;

        public native function get position():uint;
        public native function set position( offset:uint ):void;

        //public native function get objectEncoding():uint;
        public function get objectEncoding():uint
        {
            return _objectEncoding;
        }
        
        //public native function set objectEncoding( version:uint ):void;
        public function set objectEncoding( version:uint ):void
        {
            _objectEncoding = version;
        }

        public native function get endian():String;
        public native function set endian( type:String ):void;

        //public native function clear():void;

        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function clear():void
        {
            //TODO
            /* Clears the contents of the byte array and resets the length and position properties to 0.
               Calling this method explicitly frees up the memory used by the ByteArray instance.
            */
        }

        /* note:
           again flash documentation for implementation reference.
           
           Compresses the byte array.
           The entire byte array is compressed.
           For content running in Adobe AIR, you can specify a compression algorithm by passing a value
           (defined in the CompressionAlgorithm class) as the algorithm parameter.
           Flash Player supports only the default algorithm, zlib.

           After the call, the length property of the ByteArray is set to the new length.
           The position property is set to the end of the byte array.

           The zlib compressed data format is described at http://www.ietf.org/rfc/rfc1950.txt.

           The deflate compression algorithm is described at http://www.ietf.org/rfc/rfc1951.txt.

           The deflate compression algorithm is used in several compression formats, such as zlib, gzip,
           some zip implementations, and others.
           When data is compressed using one of those compression formats,
           in addition to storing the compressed version of the original data,
           the compression format data (for example, the .zip file) includes metadata information.
           Some examples of the types of metadata included in various file formats are file name,
           file modification date/time, original file size, optional comments, checksum data, and more.

           For example, when a ByteArray is compressed using the zlib algorithm,
           the resulting ByteArray is structured in a specific format.
           Certain bytes contain metadata about the compressed data,
           while other bytes contain the actual compressed version of the original ByteArray data.
           As defined by the zlib compressed data format specification,
           those bytes (that is, the portion containing the compressed version of the original data)
           are compressed using the deflate algorithm.
           Consequently those bytes are identical to the result of calling compress(air.CompressionAlgorithm.DEFLATE)
           on the original ByteArray.
           However, the result from compress(air.CompressionAlgorithm.ZLIB) includes the extra metadata,
           while the compress(CompressionAlgorithm.DEFLATE) result includes only the compressed version
           of the original ByteArray data and nothing else.

           In order to use the deflate format to compress a ByteArray instance's data in a specific format
           such as gzip or zip, you cannot simply call compress(CompressionAlgorithm.DEFLATE).
           You must create a ByteArray structured according to the compression format's specification,
           including the appropriate metadata as well as the compressed data obtained using the deflate format.
           Likewise, in order to decode data compressed in a format such as gzip or zip,
           you can't simply call uncompress(CompressionAlgorithm.DEFLATE) on that data.
           First, you must separate the metadata from the compressed data,
           and you can then use the deflate format to decompress the compressed data.
        */
        public function compress( algorithm:String = "zlib" ):void
        {
            zlib_compress();
        }
        
        public function uncompress( algorithm:String = "zlib" ):void
        {
            zlib_uncompress();
        }
    }
}
