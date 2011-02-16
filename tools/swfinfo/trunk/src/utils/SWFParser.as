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
  
  The Original Code is [swfinfo].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2011
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

package utils
{
    import core.bit;
    
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    /* note:
       SWFParser
       straightforward linear parser based on
       swf_file_format_spec_v10.pdf
       
       see:
       http://www.adobe.com/devnet/swf.html
       http://www.adobe.com/content/dam/Adobe/en/devnet/swf/pdf/swf_file_format_spec_v10.pdf
    */
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
        
        //extrainfos
        private var _bgcolor:Number;
        private var _labels:Array;
        private var _metadata:String;
        private var _timestamp:Number;
        private var _sdkversion:String;
        private var _maxRecursion:uint;
        private var _scriptTimeout:uint;
        private var _useDirectBlit:Boolean;
        private var _useGPU:Boolean;
        private var _hasMetadata:Boolean;
        private var _actionscript3:Boolean;
        private var _useNetwork:Boolean;
        
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
            
            _bgcolor    = 0;
            _labels     = [];
            _metadata   = "";
            _timestamp  = 0;
            _sdkversion = "";
            
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
            /* note:
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               FrameSize    RECT           Frame size in twips
               ----------------------------------------------------------------
            */
            var frameSize:Rectangle = new Rectangle();

            /* note:
               The SWF file format stores all x-y coordinates as integers,
               usually in a unit of measurement called a twip.
               In the SWF format, a twip is 1/20th of a logical pixel.
            */
            var twip2pixel:Function = function( twip:Number ):Number { return twip/20; }
            
            var roundTwip:Function = function( twip:Number):Number
            {
                return Math.round( ( twip2pixel(twip) * 100) / 100 ) ;
            }
            
            sync();
            
            /* note:
               RECT
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               Nbits        UB[5]          Bits in each rect value field
               Xmin         SB[Nbits]      x minimum position for rect
               Xmax         SB[Nbits]      x maximum position for rect
               Ymin         SB[Nbits]      y minimum position for rect
               Ymax         SB[Nbits]      y maximum position for rect
               ----------------------------------------------------------------
            */
            var nBits:uint = readUBits( 5 );
            var xMin:int   = readSBits( nBits );
            var xMax:int   = readSBits( nBits );
            var yMin:int   = readSBits( nBits );
            var yMax:int   = readSBits( nBits );
            
            frameSize.left   = roundTwip( xMin );
            frameSize.right  = roundTwip( xMax );
            frameSize.top    = roundTwip( yMin );
            frameSize.bottom = roundTwip( yMax );
            
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
                
                if( _parseTagsContent )
                {
                    
                    switch( tagType )
                    {
                        case 0: //0x00 - End
                        /* note:
                           ----------------------------------------------------------------
                           Field            Type           Comment
                           ----------------------------------------------------------------
                           Header           RECORDHEADER   Tag type = 0
                           ----------------------------------------------------------------
                        */
                        return;
                        
                        case 9: //0x09 - SetBackgroundColor
                        /* note:
                           ----------------------------------------------------------------
                           Field            Type           Comment
                           ----------------------------------------------------------------
                           Header           RECORDHEADER   Tag type = 9
                           BackgroundColor  RGB            Color of the display background
                           ----------------------------------------------------------------
                        */
                        before = position;
                        var bgcolor:Number = _decodeSetBackgroundColor();
                        _bgcolor = bgcolor;
                        _tagLines.push( headersub + _formatSetBackgroundColor( bgcolor, _showParsedValidTags?headermid:header )  );
                        after = position;
                        
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        case 41: //0x29  - ProductInfo
                        /* note:
                           ----------------------------------------------------------------
                           Field            Type           Comment
                           ----------------------------------------------------------------
                           Header           RECORDHEADER   Tag type = 41
                           ProductInfo      ???            undocumented
                           ----------------------------------------------------------------
                        */
                        before = position;
                        var productinfo:Object = _decodeProductInfoTag();
                        _timestamp = productinfo.seconds;
                        _sdkversion = [productinfo.majorVersion, productinfo.minorVersion, productinfo.buildHigh, productinfo.buildLow].join(".");
                        
                        _tagLines.push( headersub + _formatProductInfoTag( productinfo, _showParsedValidTags?headermid:header )  );
                        after = position;
                        
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        case 43: //0x2b - FrameLabel
                        /* note:
                           ----------------------------------------------------------------
                           Field            Type           Comment
                           ----------------------------------------------------------------
                           Header           RECORDHEADER   Tag type = 43
                           Name             STRING         Label for frame
                           ----------------------------------------------------------------
                        */
                        before = position;
                        var label:String = _decodeFrameLabel( tagLength );
                        _labels.push( label );
                        _tagLines.push( headersub + _formatFrameLabel( label ) );
                        after = position;
                        
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        case 65: //0x41   - ScriptLimits
                        /* note:
                           ----------------------------------------------------------------
                           Field                 Type           Comment
                           ----------------------------------------------------------------
                           Header                RECORDHEADER   Tag type = 65
                           MaxRecursionDeppth    UI16           Maximum recursion depth
                           ScriptTimeoutSeconds  UI16           Maximum ActionScript
                                                                processing time before
                                                                script stuck dialog box
                                                                displays
                           ----------------------------------------------------------------
                        */
                        before = position;
                        _decodeScriptLimits();
                        _tagLines.push( headersub + _formatScriptLimits( _maxRecursion, _scriptTimeout, _showParsedValidTags?headermid:header ) );
                        after = position;
                        
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        case 69: //0x45 - FileAttributes
                        /* note:
                           ----------------------------------------------------------------
                           Field            Type           Comment
                           ----------------------------------------------------------------
                           Header           RECORDHEADER   Tag type = 69
                           Reserved         UB[1]          Must be 0
                           UseDirectBlit    UB[1]          if 1, the SWF file use hardware acceleration
                                                           to blit graphics to the screen, where such
                                                           acceleration is available.
                                                           if 0, the SWF file will not use hardware
                                                           accelerated graphics facilities.
                                                           Minimum file version is 10.
                           UseGPU           UB[1]          if 1, the SWF file uses GPU compositing
                                                           features when drawing graphics, where such
                                                           acceleration is available.
                                                           if 0, the SWF file will not use hardware
                                                           accelerated graphics facilities.
                                                           Minimum file version is 10.
                           HasMetadata      UB[1]          if 1, the SWF file contains the Metadata tag.
                                                           if 0, the SWF file does not contain the
                                                           Metadata tag.
                           ActionScript3    UB[1]          if 1, this SWF uses ActionScript 3.0.
                                                           if 0, this SWF uses ActionScript 1.0 or 2.0.
                                                           Minimum file format version is 9.
                           Reserved         UB[2]          Must be 0
                           UseNetwork       UB[1]          if 1, this SWF file is given network file access
                                                           when loaded locally.
                                                           if 0, this SWF file is given local file access
                                                           when loaded locally.
                           Reserved         UB[24]         Must be 0
                           ----------------------------------------------------------------
                        */
                        before = position;
                        var attributes:Object = _decodeFileAttributes();
                        _useDirectBlit = Boolean( attributes.direct );
                        _useGPU        = Boolean( attributes.gpu );
                        _hasMetadata   = Boolean( attributes.hasMetadata );
                        _actionscript3 = Boolean( attributes.as3 );
                        _useNetwork    = Boolean( attributes.network );
                        _tagLines.push( headersub + _formatFileAttributes( attributes, _showParsedValidTags?headermid:header ) );
                               
                        after = position;
                        if( _showParsedValidTags )
                        {
                            position = before;
                            _outputKnownTagAndCheck( tagHex, tagLength, header, headersub, after );
                        }
                        break;
                        
                        case 77: //0x4D - Metadata
                        /* note:
                           ----------------------------------------------------------------
                           Field            Type           Comment
                           ----------------------------------------------------------------
                           Header           RECORDHEADER   Tag type = 77
                           Metadata         STRING         XML Metadata
                           ----------------------------------------------------------------
                        */
                        before = position;
                        var metadata:String = _decodeMetadataTag( tagLength );
                        _metadata = metadata;
                        _tagLines.push( headersub + _formatMetadataTag( metadata, _showParsedValidTags?headermid:header )  );
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
        
        private function _decodeRawTag( len:Number ):ByteArray
        {
            var raw:ByteArray = new ByteArray();
            if( len > 0 )
            {
                bytes.readBytes( raw, 0, len );    
            }
            return raw;
        }
        
        private function _decodeSetBackgroundColor():Number
        {
            /* note:
               RGB
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               Red          UI8            Red color value
               Green        UI8            Green color value
               Blue         UI8            Blue color value
               ----------------------------------------------------------------
            */
            
            var R:uint = readU8();
            var G:uint = readU8();
            var B:uint = readU8();
            return (R << 16) | (G << 8) | B;
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
        
        private function _decodeFrameLabel( len:Number ):String
        {
            var str:String = readUTF( len );
            return str;
        }
        
        private function _decodeScriptLimits():void
        {
            /* note:
               ----------------------------------------------------------------
               Field                 Type           Comment
               ----------------------------------------------------------------
               MaxRecursionDeppth    UI16           Maximum recursion depth
               ScriptTimeoutSeconds  UI16           Maximum ActionScript
                                                    processing time before
                                                    script stuck dialog box
                                                    displays
               ----------------------------------------------------------------
            */
            _maxRecursion  = readU16();
            _scriptTimeout = readU16();
        }
        
        private function _decodeFileAttributes():Object
        {
            /* note:
               ----------------------------------------------------------------
               Field            Type           Comment
               ----------------------------------------------------------------
               Reserved         UB[1]          Must be 0
               UseDirectBlit    UB[1]          if 1, the SWF file use hardware acceleration
                                               to blit graphics to the screen, where such
                                               acceleration is available.
                                               if 0, the SWF file will not use hardware
                                               accelerated graphics facilities.
                                               Minimum file version is 10.
               UseGPU           UB[1]          if 1, the SWF file uses GPU compositing
                                               features when drawing graphics, where such
                                               acceleration is available.
                                               if 0, the SWF file will not use hardware
                                               accelerated graphics facilities.
                                               Minimum file version is 10.
               HasMetadata      UB[1]          if 1, the SWF file contains the Metadata tag.
                                               if 0, the SWF file does not contain the
                                               Metadata tag.
               ActionScript3    UB[1]          if 1, this SWF uses ActionScript 3.0.
                                               if 0, this SWF uses ActionScript 1.0 or 2.0.
                                               Minimum file format version is 9.
               Reserved         UB[2]          Must be 0
               UseNetwork       UB[1]          if 1, this SWF file is given network file access
                                               when loaded locally.
                                               if 0, this SWF file is given local file access
                                               when loaded locally.
               Reserved         UB[24]         Must be 0
               ----------------------------------------------------------------
            */
            var attributes:Object = {};
            var reserved:uint;
                
                var byte:uint = readU8();
                var b:bit = new bit( byte );
                    //original     00011001   bits pos is from right to left,     here pos(0) == 1
                    b.reverse(); //10011000   we want to read from left to right, now  pos(0) == 0
                           //index 76543210    
                //trace( b.toString() ); 
                
                reserved = b.get(0);
                //trace( "reserved = " + reserved );
                //if( reserved != 0 ) { trace( "Error with reserved" ); }
                
                attributes.direct      = b.get(1);
                attributes.gpu         = b.get(2);
                attributes.hasMetadata = b.get(3);
                attributes.as3         = b.get(4);
                
                reserved = b.get(5) + b.get(6); //skip 2 bits
                //trace( "reserved = " + reserved );
                //if( reserved != 0 ) { trace( "Error with reserved" ); }
                
                attributes.network     = b.get(7);
             
                reserved = readU24();
                //trace( "reserved = " + reserved );
                //if( reserved != 0 ) { trace( "Error with reserved" ); }
           /* or we could */
           //skip( 3 ); //skip 3 bytes, eg. skip 24bits
           
           return attributes;
        }
        
        
        
        private function _decodeMetadataTag( len:Number ):String
        {
            //var str:String = readString( len );
            var str:String = readUTF( len );
            //trace( "metadata = [" + str + "] len = " + str.length );
            return str;
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

        
        private function _formatSetBackgroundColor( color:Number, space:String ):String
        {
            var str:String = "";
            var hex:String = color.toString( 16 );
            while( hex.length < 6 )
            {
                hex = "0" + hex;
            }
                str += "hex: 0x"+hex +"\n";
                
                var R:uint = ((color >> 16) & 0xFF);
                var G:uint = ((color >> 8) & 0xFF);
                var B:uint = (color & 0xFF);
                str += space += "r="+R+", g="+G+", b="+B;
            return str;
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
        
        private function _formatFrameLabel( label:String ):String
        {
            return "name: " + label;
        }
        
        private function _formatScriptLimits( maxRecursion:uint, scriptTimeout:uint, space:String ):String
        {
            var str:String = "";
                str += "max recursion: " + maxRecursion + "\n";
                str += space + "script timeout: " + scriptTimeout;
            
            return str;
        }
        
        private function _formatFileAttributes( attributes:Object, space:String ):String
        {
            var str:String = "";
                str += "Use Direct Blit: " + Boolean(attributes.direct) + "\n";
                str += space + "Use GPU: " + Boolean(attributes.gpu) + "\n";
                str += space + "Has Metadata: " + Boolean(attributes.hasMetadata) + "\n";
                str += space + "ActionScript 3: " + Boolean(attributes.as3) + "\n";
                str += space + "Use Network: " + Boolean(attributes.network);
            
            return str;
        }
        
        
        
        
        private function _formatMetadataTag( s:String, space:String ):String
        {
            return s.split( "><" ).join( ">\n" + space + "<" );
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
        
        private function _parse():void
        {
            /* note:
               parse the SWF header
               
               SWF File Header
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               Signature    UI8            Signature byte:
               Signature    UI8            "F" indicates uncompressed
               Signature    UI8            "C" indicates compressed (SWF6 and later)
               ----------------------------------------------------------------
            */
            bytes.endian = Endian.LITTLE_ENDIAN;
            position     = 0;
            
            _zipLength  = 0;
            _compressed = false;
            
            /* note:
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               Signature    UI8            Signature byte:
               Signature    UI8            "F" indicates uncompressed
               Signature    UI8            "C" indicates compressed (SWF6 and later)
               ----------------------------------------------------------------
            */
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
            
            /* note:
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               Version      UI8            Single byte file version
                                           (ex: 0x06 for SWF6)
               ----------------------------------------------------------------
            */
            _version    = readU8();
            
            /* note:
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               FileLength   UI32           Length of entire file in bytes
               ----------------------------------------------------------------
            */
            _fileLength = readU32();
            
            if( signature == "SWC" )
            {
                _compressed = true;
                _uncompress();
            }
            
            _decodeRect();
            
            /* note:
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               FrameRate    UI16           Frame delay in 8.8 fixed number of
                                           frames per second
               ----------------------------------------------------------------
            */
            _frameRate  = readFixed8();
            
            /* note:
               ----------------------------------------------------------------
               Field        Type           Comment
               ----------------------------------------------------------------
               FrameCount   UI16           Total number of frames in file
               ----------------------------------------------------------------
            */
            _frameCount = readU16();
            
            if( _parseTags )
            {
                _decodeTags();
            }
        }
        
        //swfinfos
        
        public function get signature():String { return _signature; }
        
        public function get version():uint { return _version; }
        
        public function get fileLength():uint { return _fileLength; }
        
        public function get zipLength():uint { return _zipLength; }
        
        public function get frameSize():Rectangle { return _frameSize; }
        
        public function get frameRate():Number { return _frameRate; }
        
        public function get frameCount():uint { return _frameCount; }
        
        public function isCompressed():Boolean { return _compressed; }
        
        
        //extrainfos
        
        public function get bgcolor():Number { return _bgcolor; }
        
        public function get metadata():String { return _metadata; }
        
        public function get timestamp():Number { return _timestamp; }
        
        public function get sdkversion():String { return _sdkversion; }
        
        public function get labels():Array { return _labels; }
        
        public function get maxRecursion():uint { return _maxRecursion; }
        
        public function get scriptTimeout():uint { return _scriptTimeout; }
        
        public function get useDirectBlit():Boolean { return _useDirectBlit; }
        
        public function get useGPU():Boolean { return _useGPU; }
        
        public function get hasMetadata():Boolean { return _hasMetadata; }
        
        public function get actionscript3():Boolean { return _actionscript3; }
        
        public function get useNetwork():Boolean { return _useNetwork; }
        
        
        public function toString():String
        {
            var str:String = "";
                str += "[ ";
                str += signature + version;
                str += " rect=" + frameSize;
                str += ", fps=" + frameRate;
                str += ", frames=" + frameCount;
                
                if( isCompressed() )
                {
                    str += ", size=" + bytesToHumandReadable( zipLength, 2, false, "" );
                    str += " (unzipped=" + bytesToHumandReadable( fileLength, 2, false, "" ) + ")"
                }
                else
                {
                    str += ", size=" + bytesToHumandReadable( fileLength, 2, false, "" );
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