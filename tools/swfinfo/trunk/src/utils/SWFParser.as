package utils
{
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class SWFParser extends ByteParser
    {
        //swfinfos
        private var _signature:String;
        private var _version:uint;
        private var _fileLength:uint;
        private var _zipLength:uint;
        private var _frameSize:Rectangle;
        private var _frameRate:Number;
        private var _frameCount:uint;
        private var _compressed:Boolean;
        
        //options
        private var _parseTags:Boolean;
        private var _parseTagsContent:Boolean;
        private var _showUnparsedValidTags:Boolean;
        private var _showParsedValidTags:Boolean;
        private var _fullKnownTagInfo:Boolean;
        private var _fullUnknownTagInfo:Boolean;
        private var _truncateTags:uint;
        private var _hexgroup:uint;
        private var _hexwidth:uint;
        
        //data
        private var _tags:Array;
        private var _tagLines:Array;
        
        
        public function SWFParser( bytes:ByteArray, parseTags:Boolean = false, parseTagsContent:Boolean = true,
                                   showUnparsedValidTags:Boolean = false,
                                   showParsedValidTags:Boolean = false,
                                   fullKnownTagInfo:Boolean = false, fullUnknownTagInfo:Boolean = false,
                                   truncateTags:uint = 200, hexgroup:uint = 8, hexwidth:uint = 80 )
        {
            super( bytes );
            
            _parseTags             = parseTags;
            _parseTagsContent      = parseTagsContent;
            _showUnparsedValidTags = showUnparsedValidTags;
            _showParsedValidTags   = showParsedValidTags;
            _fullKnownTagInfo      = fullKnownTagInfo;
            _fullUnknownTagInfo    = fullUnknownTagInfo;
            _truncateTags          = truncateTags;
            _hexgroup              = hexgroup;
            _hexwidth              = hexwidth;
            _tagLines              = [];
            
            _defineTags();
            _parse();
        }
        
        private function _defineTags():void
        {
            _tags = [
            "End",                  // 00
            "ShowFrame",            // 01
            "DefineShape",          // 02
            "FreeCharacter",        // 03
            "PlaceObject",          // 04
            "RemoveObject",         // 05
            "DefineBits",           // 06
            "DefineButton",         // 07
            "JPEGTables",           // 08
            "SetBackgroundColor",   // 09
    
            "DefineFont",           // 10
            "DefineText",           // 11
            "DoAction",             // 12
            "DefineFontInfo",       // 13
    
            "DefineSound",          // 14
            "StartSound",           // 15
            "StopSound",            // 16
    
            "DefineButtonSound",    // 17
    
            "SoundStreamHead",      // 18
            "SoundStreamBlock",     // 19
    
            "DefineBitsLossless",   // 20
            "DefineBitsJPEG2",      // 21
    
            "DefineShape2",         // 22
            "DefineButtonCxform",   // 23
    
            "Protect",              // 24
    
            "PathsArePostScript",   // 25
    
            "PlaceObject2",         // 26
            "27 (invalid)",         // 27
            "RemoveObject2",        // 28
    
            "SyncFrame",            // 29
            "30 (invalid)",         // 30
            "FreeAll",              // 31
    
            "DefineShape3",         // 32
            "DefineText2",          // 33
            "DefineButton2",        // 34
            "DefineBitsJPEG3",      // 35
            "DefineBitsLossless2",  // 36
            "DefineEditText",       // 37
    
            "DefineVideo",          // 38
    
            "DefineSprite",         // 39
            "NameCharacter",        // 40
            "ProductInfo",          // 41
            "DefineTextFormat",     // 42
            "FrameLabel",           // 43
            "DefineBehavior",       // 44
            "SoundStreamHead2",     // 45
            "DefineMorphShape",     // 46
            "FrameTag",             // 47
            "DefineFont2",          // 48
            "GenCommand",           // 49
            "DefineCommandObj",     // 50
            "CharacterSet",         // 51
            "FontRef",              // 52
    
            "DefineFunction",       // 53
            "PlaceFunction",        // 54
    
            "GenTagObject",         // 55
    
            "ExportAssets",         // 56
            "ImportAssets",         // 57
    
            "EnableDebugger",       // 58
    
            "DoInitAction",         // 59
            "DefineVideoStream",    // 60
            "VideoFrame",           // 61
    
            "DefineFontInfo2",      // 62
            "DebugID",              // 63
            "EnableDebugger2",      // 64
            "ScriptLimits",         // 65
    
            "SetTabIndex",          // 66
    
            "DefineShape4",         // 67
            "DefineMorphShape2",    // 68
    
            "FileAttributes",       // 69
    
            "PlaceObject3",         // 70
            "ImportAssets2",        // 71
    
            "DoABC",                // 72
            "DefineFontAlignZones", // 73
            "CSMSettings",          // 74
            "DefineFont3",          // 75
            "SymbolClass",          // 76
            "Metadata",             // 77
            "DefineScalingGrid",    // 78
            "DefineDeviceVideo",    // 79
            "80 (invalid)",         // 80
            "81 (invalid)",         // 81
            "DoABC2",               // 82
            "DefineShape4",         // 83
            "DefineMorphShape2",    // 84
            "PlaceImagePrivate",    // 85
            "DefineSceneAndFrameLabelData", // 86
            "DefineBinaryData",     // 87
            "DefineFontName",       // 88
            "StartSound",           // 89
            "DefineBitsJPEG64",     // 90
            "DefineFont4",          // 91
            ];
        }
        
        private function _getTagName( code:uint ):String
        {
            if( code <= (_tags.length-1) ) { return _tags[ code ]; }
            return code + " (invalid)";
        }
        
        private function _isValidTag( code:uint ):Boolean
        {
            var str:String = _getTagName( code );
            if( str.indexOf( "invalid" ) > - 1 ) { return false; }
            return true;
        }
        
        private function _uncompress():void
        {
            var ubytes:ByteArray = new ByteArray();
                ubytes.endian = Endian.LITTLE_ENDIAN;
            
            bytes.position = 8;
            bytes.readBytes( ubytes, 0, (bytes.length - bytes.position) );
            
            var ziplen:uint = ubytes.length + 8;
            ubytes.uncompress();
            var filelen:uint = ubytes.length + 8;
            
            ubytes.position = 0;
            _zipLength  = ziplen;
            _fileLength = filelen;
            bytes = ubytes;
        }
        
        private function _decodeRect():void
        {
            var frameSize:Rectangle = new Rectangle();

            var round20:Function = function( num:Number):Number
            {
                return Math.round( (num * 100) / 100 ) ;
            }
            
            sync();
            
            var nBits:uint = readUBits( 5 );
            var xMin:int   = readSBits( nBits );
            var xMax:int   = readSBits( nBits );
            var yMin:int   = readSBits( nBits );
            var yMax:int   = readSBits( nBits );
            
            frameSize.left   = round20( xMin / 20 );
            frameSize.right  = round20( xMax / 20 );
            frameSize.top    = round20( yMin / 20 );
            frameSize.bottom = round20( yMax / 20 );
            
            _frameSize = frameSize;
        }
        
        private function _decodeTags():void
        {
            var before:uint;
            var after:uint;
            
            var tagCodeAndLength:uint;
            var tagType:uint;
            var tagHex:String;
            var tagLength:Number;
            
            var known:ByteArray;
            var unknown:ByteArray;
            
            var header:String    = "            ";
            var headermid:String = "      |     ";
            var headersub:String = "      |__   ";
            
            while( position < length )
            {
                tagCodeAndLength = readU16();
                tagType          = tagCodeAndLength >> 6;
                
                tagHex           = tagType.toString(16);
                tagHex           = (tagHex.length == 1) ? "0x0" + tagHex : "0x" + tagHex;
                
                tagLength        = tagCodeAndLength & 63;
                if( tagLength == 63 ) { tagLength = readS32(); }
                
                _tagLines.push( _formatTagHeader( tagHex, tagType, tagLength ) );
                //_tagLines.push( headersub + bytesToHumandReadable( tagLength, 2, false, "" ) );
                //_tagLines.push( headersub + Number((100 * tagLength) / bytes.length).toFixed(3) + "%" );
                
                if( _parseTagsContent )
                {
                    
                    switch( tagType )
                    {
                        case 0: //0x00 - End
                        return;
                        
                        case 77: //0x4D - Metadata
                        before = position;
                        var metadata:String = _decodeMetadataTag( tagLength );
                        _tagLines.push( headersub + _formatMetadataTag( metadata, _showParsedValidTags?headermid:header )  );
                        after = position;
                        
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        
                        
                        case 41: //0x29  - ProductInfo
                        before = position;
                        var productinfo:Object = _decodeProductInfoTag();
                        _tagLines.push( headersub + _formatProductInfoTag( productinfo, _showParsedValidTags?headermid:header )  );
                        after = position;
                        
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        
                        default:
                        if( _isValidTag( tagType ) )
                        {
                            if( _showUnparsedValidTags )
                            {
                                _outputKnownTag( tagLength, header, headersub );
                            }
                            else
                            {
                                skip( tagLength );
                            }
                            
                        }
                        else
                        {
                            if( _isSpecialTag( tagType ) )
                            {
                                _tagLines.push( headersub + _formatSpecialTag( tagType ) );
                            }
                            else
                            {
                                _tagLines.push( headersub + _formatInvalidTag( tagHex, tagType ) );
                            }
                            
                            _outputUnknownTag( tagLength, header, headersub );
                        }
                        
                    } //end switch
                    
                }
                else
                {
                    skip( tagLength );
                }
            }
        }
        
        private function _outputKnownTagAndCheck( hex:String, len:Number, space:String, space2:String, check:uint ):void
        {
            _outputKnownTag( len, space, space2 );
            
            if( position != check )
            {
                throw new Error( "Wrong parsing of the tag " + hex + " current " + position + " should be " + check );
            }
        }
        
        private function _outputKnownTag( len:Number, space:String, space2:String ):void
        {
            if( len == 0 ) { return; }
            
            var known:ByteArray = _decodeRawTag( len );
            
            if( _fullKnownTagInfo )
            {
                _tagLines.push( space2 + _formatRawTag( known, -1, space ) );
            }
            else
            {
                _tagLines.push( space2 + _formatRawTag( known, _truncateTags, space ) );
            }
        }
        
        private function _outputUnknownTag( len:Number, space:String, space2:String ):void
        {
            if( len == 0 ) { return; }
            
            var unknown:ByteArray = _decodeRawTag( len );
            
            if( _fullUnknownTagInfo )
            {
                _tagLines.push( space2 + _formatRawTag( unknown, -1, space ) );
            }
            else
            {
                _tagLines.push( space2 + _formatRawTag( unknown, _truncateTags, space ) );
            }
        }
        
        private function _decodeProductInfoTag():Object
        {
            var productId:uint    = readU32();
            var edition:uint      = readU32();
            var majorVersion:uint = readU8();
            var minorVersion:uint = readU8();
            var buildLow:uint     = readU32();
            var buildHigh:uint    = readU32();
            var seconds:Number    = readU32() + (readU32() * 0x100000000);
            
            var info:Object = {};
                info.productId    = productId;
                info.edition      = edition;
                info.majorVersion = majorVersion;
                info.minorVersion = minorVersion;
                info.buildLow     = buildLow;
                info.buildHigh    = buildHigh;
                info.seconds      = seconds;
            
            return info;
        }
        
        private function _formatProductInfoTag( info:Object, space:String ):String
        {
            var productIds:Array = [ "Unknown",
                                     "Macromedia Flex for J2EE",
                                     "Macromedia Flex for .NET",
                                     "Adobe Flex" ];
            
            var editions:Array = [ "Developer Edition",
                                   "Full Commercial Edition",
                                   "Non Commercial Edition",
                                   "Educational Edition",
                                   "Not For Resale (NFR) Edition",
                                   "Trial Edition",
                                   "None" ];
            
            var compileDate:Date = new Date( info.seconds );
            var version:String   = [info.majorVersion, info.minorVersion, info.buildHigh, info.buildLow].join(".");
            
            var productinfos:Array = [];
                productinfos.push( "productId: " + info.productId + " (" + productIds[ info.productId ] + ")" );
                productinfos.push( "edition: " + info.edition + " (" + editions[ info.edition ] + ")" );
            
            if( info.productId > 0 )
            {
                productinfos.push( "version: Flex SDK v" + version );
            }
            else
            {
                productinfos.push( "version: " + version );
            }
            
                productinfos.push( "compile Date: " + compileDate );
            
            return productinfos.join( "\n" + space );
        }
        
        private function _decodeMetadataTag( len:Number ):String
        {
            //var str:String = readString( len );
            var str:String = readUTF( len );
            //trace( "metadata = [" + str + "] len = " + str.length );
            return str;
        }
        
        private function _formatMetadataTag( s:String, space:String ):String
        {
            return s.split( "><" ).join( ">\n" + space + "<" );
        }
        
        private function _decodeRawTag( len:Number ):ByteArray
        {
            var raw:ByteArray = new ByteArray();
            if( len > 0 )
            {
                bytes.readBytes( raw, 0, len );    
            }
            return raw;
        }
        
        private function _formatRawTag( b:ByteArray, truncate:int, space:String ):String
        {
            var str:String = "";
                if( (truncate > 0) && (truncate > b.length) ) { truncate = -1; }
                str += hexformat( b, 0, truncate, _hexgroup, " ", _hexwidth, space );
                if( truncate > 0 ) { str += "..."; }
            
            return str;
        }
        
        private function _formatTagHeader( hex:String, type:uint, len:Number ):String
        {
            var str:String = "";
                str += "  tag " + hex + ": ";
                str +=  _getTagName( type ) + " | ";
                str += "size: " + bytesToHumandReadable( len, 2, false, "" ) + " | ";
                str += "ratio: " + Number((100 * len) / bytes.length).toFixed(3) + "%";
            
            return str;
        }
        
        private function _formatInvalidTag( hex:String, type:uint ):String
        {
            return "Invalid tag " + hex + " (" + type + ") found.";
        }
        
        private function _isSpecialTag( type:uint ):Boolean
        {
            switch( type )
            {
                case 255: //0xFF
                case 253: //0xFD
                return true;
                
                default:
                return false;
            }
            
            return false;
        }
        
        private function _formatSpecialTag( type:uint ):String
        {
            switch( type )
            {
                case 255: //0xFF
                return "Some obfuscators use this tag to mark the SWF as processed.";
                
                case 253: //0xFD
                return "Some obfuscators use this tag to store action data.";
            }
            
            return "";
        }
        
        
        private function _parse():void
        {
            bytes.endian = Endian.LITTLE_ENDIAN;
            position     = 0;
            
            _zipLength  = 0;
            _compressed = false;
            
            var magic:Array = [readU8(), readU8(), readU8()];
                magic.reverse();
                magic.forEach( function(el:*, i:int, a:Array):void { a[i] = String.fromCharCode(el); } );
            
            var signature:String = magic.join("");
            if( (signature == "SWC") || (signature == "SWF") )
            {
                _signature = signature;
            }
            else
            {
                //throw new InvalidSWFError();
                throw new Error( "This is not a valid SWF file (signature=" + signature + ")" );
            }
            
            _version    = readU8();
            _fileLength = readU32();
            
            if( signature == "SWC" )
            {
                _compressed = true;
                _uncompress();
            }
            
            _decodeRect();
            
            _frameRate  = readFixed8();
            _frameCount = readU16();
            
            if( _parseTags )
            {
                _decodeTags();
            }
        }
        
        public function get signature():String { return _signature; }
        
        public function get version():uint { return _version; }
        
        public function get fileLength():uint { return _fileLength; }
        
        public function get zipLength():uint { return _zipLength; }
        
        public function get frameSize():Rectangle { return _frameSize; }
        
        public function get frameRate():Number { return _frameRate; }
        
        public function get frameCount():uint { return _frameCount; }
        
        public function get data():ByteArray { return bytes; }
        
        public function isCompressed():Boolean { return _compressed; }
        
        public function toString():String
        {
            var str:String = "";
                str += "[ ";
                str += signature + version;
                str += " rect=" + frameSize;
                str += ", fps=" + frameRate;
                str += ", frames=" + frameCount;
                str += ", size=" + bytesToHumandReadable( fileLength, 2, false, "" );
                
                if( isCompressed() )
                {
                    str += " (zip=" + bytesToHumandReadable( zipLength, 2, false, "" ) + ")";
                }
                
                if( _parseTags )
                {
                    str += "\n";
                    str += _tagLines.join( "\n" );
                    str += "\n";
                }
                
                str += " ]";
                
            return str;
        }
    }
}