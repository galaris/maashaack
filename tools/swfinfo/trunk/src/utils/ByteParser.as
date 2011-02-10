package utils
{
    import flash.utils.ByteArray;
    
    public class ByteParser
    {
        private var _cursor:int;
        private var _buffer:int;
        
        protected var bytes:ByteArray;
        protected var bitsPending:uint;
        
        public function ByteParser( bytes:ByteArray )
        {
            this.bytes = bytes;
            this.bytes.position = 0;
            bitsPending = 0;
            _cursor = 0;
        }
        
        public function get length():uint { return bytes.length; }
        
        public function get position():uint { return bytes.position; }
        public function set position( value:uint ):void { bytes.position = value; }
        
        public function sync():void { _cursor = 0; }
        
        public function skip( offset:int ):void { position += offset; }
        
        public function seek( position:int ):void
        {
            if( position < 0 )
            {
                this.position = 0;
            }
            else if( position < length )
            {
                this.position = position;
            }
            else
            {
                this.position = length - 1;
            }
        }
        
        //---- signed int --------
        
        public function readS8():int { return bytes.readByte(); }
        
        public function readS16():int { return bytes.readShort(); }
        
        public function readS24():int
        {
            var b:int = readU8();
                b    |= readU8() <<  8;
                b    |= readS8() << 16;
            
            return b;
        }
        
        public function readS32():int { return bytes.readInt(); }
        
        
        //---- unsigned int --------
        
        public function readU8():uint { return bytes.readUnsignedByte(); }
        
        public function readU16():uint { return bytes.readUnsignedShort(); }
        
        public function readU24():uint
        {
            var loWord:uint = bytes.readUnsignedShort();
            var hiByte:uint = bytes.readUnsignedByte();
            return (hiByte << 16) | loWord;
        }
        
        public function readU32():uint { return bytes.readUnsignedInt(); }
        
        
        //---- fixed point number --------
        
        public function readFixed():Number { return readS32() / 0x10000; }
        
        public function readFixed8():Number { return readS16() / 0x100; }
        
        
        //---- floating point number --------
        
        public function readFloat16():Number
        {
            var EXP_BASE:uint   = 0xf;
            var b:uint          = readU16();
            var sign:int        = (b & 0x8000) ? -1 : 1;
            var exp:int         = (b >> 10) & 0x1f;
            var fraction:Number = b & 0x3ff;
            
            if( exp == 0 )
            {
                if( fraction == 0 )
                {
                    return 0;
                }
                else
                {
                    //return fraction;
                    //subnormal number
                    return sign * Math.pow(2, 1 - EXP_BASE) * (fraction / 0x400);
                }
            }
            else if( exp == 0x1f )
            {
                if( fraction == 0 )
                {
                    return (sign < 0) ? Number.NEGATIVE_INFINITY : Number.POSITIVE_INFINITY;
                }
                else
                {
                    return Number.NaN;
                }
            }
            
            //normal number
            return sign * Math.pow(2, exp - EXP_BASE) * (1 + fraction / 0x400);
        }
        
        public function readFloat():Number { return bytes.readFloat(); }
        
        public function readDouble():Number { return bytes.readDouble(); }
        
        //---- encoded int --------
        
        private function readEncodedU32():uint
        {
//            var result:uint = 0;
//            var byte:uint   = 0;
//            var c:uint      = 0;
//            
//            do
//            {
//                byte    = readU8();
//                result |= (byte & 0x7f) << (c++ * 7);
//            }
//            while( (c < 5) && ((byte & 0x80) != 0) )
//            
//            return result;

            var result:uint = bytes.readUnsignedByte();
            if(     !(result & 0x00000080) ) { return result; }
            
            result = (result & 0x0000007f) | (bytes.readUnsignedByte() << 7);
            if(     !(result & 0x00004000) ) { return result; }
            
            result = (result & 0x00003fff) | (bytes.readUnsignedByte() << 14);
            if(     !(result & 0x00200000) ) { return result; }
            
            result = (result & 0x001fffff) | (bytes.readUnsignedByte() << 21);
            if(     !(result & 0x10000000) ) { return result; }

            return    (result & 0xfffffff) | (bytes.readUnsignedByte() << 28);
        }
        
        public function readEncodedS32():int
        {
            var result:int = 0;
            var byte:uint  = 0;
            var c:uint = 0;
            
            do
            {
                byte    = readU8();
                result |= (byte & 0x7f) << (c++ * 7);
            }
            while( (c < 5) && ((byte & 0x80) != 0) )
            
            var totalBits:int = Math.min( c*7, 32 );
            var shift:int     = 32 - totalBits;
            
            result = (result << shift) >> shift;
            return result;
        }
        
        
        //---- bits --------
        
        public function readBits( bits:uint, bitBuffer:uint = 0 ):uint
        {
            if (bits == 0) { return bitBuffer; }
            
            var partial:uint;
            var bitsConsumed:uint;
            
            if( bitsPending > 0 )
            {
                var byte:uint = bytes[position - 1] & (0xff >> (8 - bitsPending));
                bitsConsumed  = Math.min(bitsPending, bits);
                bitsPending  -= bitsConsumed;
                partial       = byte >> bitsPending;
            }
            else
            {
                bitsConsumed = Math.min(8, bits);
                bitsPending  = 8 - bitsConsumed;
                partial      = bytes.readUnsignedByte() >> bitsPending;
            }
            
            bits     -= bitsConsumed;
            bitBuffer = (bitBuffer << bitsConsumed) | partial;
            
            //trace("  read"+bits+" " + partial);
            return (bits > 0) ? readBits(bits, bitBuffer) : bitBuffer;
        }
        
        public function readSB( bits:uint ):int
        {
            var shift:uint = 32 - bits;
            return int(readBits(bits) << shift) >> shift;
        }
        
        public function readUB( bits:uint ):uint
        {
            return readBits( bits );
        }
        
        public function readSBits( numBits:uint ):int
        {
            if (numBits > 32)
            {
                throw new RangeError( "Number of bits > 32" );
            }
            
            var b:int     = readUBits( numBits );
            var shift:int = 32 - numBits;
            
            var result:int = (b << shift) >> shift;
            return result;
        }
        
        public function readUBits( numBits:uint ):uint
        {
            if( numBits == 0 ) { return 0; }
            
            var result:uint  = 0;
            var bitsLeft:int = numBits;
            
            if( _cursor == 0 )
            {
                _buffer = readU8();
                _cursor = 8;
            }
            
            var shift:int;
            while( true )
            {
                shift = bitsLeft - _cursor;
                if( shift > 0 )
                {
                    result   |= _buffer << shift;
                    bitsLeft -= _cursor;
                    
                    _buffer = readU8();
                    _cursor = 8;
                }
                else
                {
                    result  |= _buffer >> -shift;
                    _cursor -= bitsLeft;
                    _buffer &= 0xff >> (8 - _cursor);
                    
                    //trace("  read"+numBits+" " + result);
                    return result;
                }
            }
            
            return result;
        }
        
        public function readFBits( numBits:uint ):Number
        {
            return readSBits( numBits ) / 0x10000;
        }
        
        public function revertBits( bits:uint, mask:uint = 0 ):uint
        {
            var len:uint = mask;
            var MAX:uint = 32;
            
            var r:uint = bits;
            r = ((r >> 1) & 0x55555555) | ((r & 0x55555555) << 1);
            r = ((r >> 2) & 0x33333333) | ((r & 0x33333333) << 2);
            r = ((r >> 4) & 0x0f0f0f0f) | ((r & 0x0f0f0f0f) << 4);
            r = ((r >> 8) & 0x00ff00ff) | ((r & 0x00ff00ff) << 8);
            r = (r >> 16) | (r << 16);
            
            bits = r >>> (MAX - len);
            
            return bits;
        }
        
        
        //---- strings --------
        
        public function readUTF( length:uint = 0 ):String
        {
            if( length == 0 )
            {
                var data:ByteArray = new ByteArray();
                var byte:uint;
                
                while( (byte = readU8()) != 0 ) { data.writeByte( byte ); }
                
                data.position = 0;
                return data.readUTFBytes( data.length );
            }
            
            return bytes.readUTFBytes( length );
        }
        
        public function readString( length:uint = 0, charset:String = "iso-8859-1" ):String
        {
            if( length == 0 )
            {
                var data:ByteArray = new ByteArray();
                var byte:uint;
                
                while( (byte = readU8()) != 0 ) { data.writeByte( byte ); }
                
                data.position = 0;
                return data.readMultiByte( data.length, charset );
            }
            
            return bytes.readMultiByte( length, charset );
        }

    }
}