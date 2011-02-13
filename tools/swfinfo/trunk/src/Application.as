package
{
    import avmplus.System;
    import avmplus.OperatingSystem;
    
    import core.version;
    import core.uri;
    import core.strings.format;
    
    import utils.SWFParser;
    import utils.bytesToHumandReadable;
    import flash.utils.ByteArray;
    import avmplus.FileSystem;
    
    public class Application
    {
        public static var version:core.version = new core.version();
                 include "version.properties";
                          version.revision = parseInt( "$Rev$".split( " " )[1] );
        
        private var _options:Options;
        
        private var _name:String = "swfinfo";
        
        private var _timestamp:String = "$Date$";
        
        private var _versioninfo:String = <![CDATA[
{name} for {system}, version {version} (r{revision})
   compiled {date}, {time}
]]>;
        
        private var _informations:String = <![CDATA[
{name} is open source software

This program is made with redtamarin
http://code.google.com/p/redtamarin/

For additional informations
http://code.google.com/p/maashaack/wiki/swfinfo
  * download for Windows / OS X / Linux
  * source code (AS3)
  * examples
]]>;

        private var _license:String = <![CDATA[
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
]]>;

        private var _usage:String = <![CDATA[
Utility to get in depth informations from a SWF file.

Usage:

  {name} [-h] [-v] [-L] [-s] [-o:val[=opt]]
         [-p] [-a] [-u] [-k] [-x] [-n] [-t:val] [-g:val] [-w:val] file

Options:
  file           a local <file> or remote <file>
                 in case of a  remote file, need to be a valid URL
                 eg. starting with http/ftp/etc.

  -h             this help
  
  -v             to see the program version
  
  -L             License and program informations

  -s             save a remote file
                 on the current local directory

  -o:val[=opt]   single line output configured by <opt>
                 when you use this mode the program will return
                 only the info from <opt> and nothing else
                 <val> can be:
                 * type, filetype
                   returns the signature+version (ex: SWF10)
                 * sign, signature
                   returns the signature (ex: SWC)
                 * version
                   returns the version (ex: 9)
                 * rect, rectangle
                   returns the rectangle (ex: x=0, y=0, w=550, h=400)
                 * fps, rate
                   returns the frame rate (ex: 24)
                 * frame, frames
                   returns the frame count (ex: 5)
                 * size [=B, K, M, G, T, P, E, Z, Y]
                   returns the uncompressed file size
                 * unzip, unzipped, uncompressed [=B, K, M, G, T, P, E, Z, Y]
                   returns the compressed file size
                 * metadata [=pp]
                   returns the metadata tag content if found
                 * date, time, timestamp [=string]
                   returns the compilation date if found (ex: 1294419029461)
                 * sdk, sdkversion
                   returns the Flex SDK version if found (ex: 4.0.0.7219)

  -p             parse SWF tags
                 this option need to be present for
                 -a -u -k -x -n -t options

  -a             display only the SWF tags header

  -n             not parsed valid SWF tags will output hex data
                 output is limited by option -t

  -x             parsed valid SWF tags will output hex data
                 output is limited by option -t

  -u             unknown SWF tags hex data will not be truncated

  -k             known SWF tags hex data will not be truncated

  -t:val         truncate SWF tags hex data from 0 to <val>
                 default <val> is 200

  -g:val         group hex data by the amount of <val>
                 default <val> is 8

  -w:val         try to limit the width of the hex data by a certain <val>
                 default <val> is 80

By default, the program parse only the SWF header.
If you need SWF tags informations you HAVE TO use option -p.

We have different SWF tags:
  * known:        the tag id is in the range of SWF tags (0 to 91)
  * parsed:       a known SWF tag that the program know how to parse
  * not parsed:   a known SWF tag that the program dow not know how to parse yet
  * unknown:      any SWF tag outside of the known range

By default, a known parsed SWF tag does not output hex data.
]]>;
        
        private var _bytes:ByteArray;
        private var _swfparser:SWFParser;
        
        public function Application()
        {
            _options = new Options( this );
        }
        
        private function _getHeader():String
        {
            return _name + " v" + version.toString( 2 ) + " (" + OperatingSystem.vendorName + ")";
        }
        
        private function _getUsages():String
        {
            return format( _usage, { name: _name } );
        }
        
        /*
            {name} for {system}, version {version} (r{revision})
               compiled {date}, {time}
        */
        private function _getVersion():String
        {
            //"$Date$"
            var t:Array = _timestamp.split( " " );
            
            var data:Object = {};
                data.name     = _name;
                data.system   = OperatingSystem.vendorName;
                data.version  = version.toString( 2 );
                data.revision = version.revision;
                data.date     = t[1];
                data.time     = t[2];
                
            return format( _versioninfo, data );
        }
        
        private function _getInformations():String
        {
            return format( _informations, { name: _name } );
        }
        
        private function _getData( filename:String ):ByteArray
        {
            var url:uri = new uri( filename );
            var urlstr:String = url.toString();
            var bytes:ByteArray;
            
            //trace( "url = " + urlstr );
            
            //local
            if( urlstr == "" )
            {
                if( !FileSystem.exists( filename ) )
                {
                    showHeader();
                    trace( "Filename \"" + filename + "\" does not exists" );
                    showUsages();
                }
                
                if( FileSystem.isDirectory( filename ) )
                {
                    showHeader();
                    trace( "Filename \"" + filename + "\" is a directory" );
                    showUsages();
                }
                
                bytes = FileSystem.readByteArray( filename );
            }
            else //remote
            {
                //TODO
                showHeader();
                trace( "remote URL are not supported yet" );
                showUsages();
            }
            
            return bytes;
        }
        
        
        public function showHeader():void
        {
            trace( _getHeader() );
        }
        
        public function showUsages( message:String = "", exit:Boolean = true ):void
        {
            if( exit ) { showHeader(); }
            if( message != "" ) { trace( "Error: " + message ); }
            trace( _getUsages() );
            
            if( exit ) { System.exit( 1 ); }
        }
        
        public function showVersion():void
        {
            trace( _getVersion() );
        }
        
        public function showLicense():void
        {
            showHeader();
            trace( _getInformations() );
            trace( "License:" );
            trace( _license );
        }
        
        public function run( args:Array ):void
        {
            if( args.length == 0 ) { showUsages(); }
            
            var success:Boolean = _options.parse( args );
            
            if( !success || _options.showUsage ) { showUsages(); }
            
            if( _options.showVersion )
            {
                showVersion();
                System.exit( 0 );
            }
            
            if( _options.showLicense )
            {
                showLicense();
                System.exit( 0 );
            }
            
            if( _options.filename != "" )
            {
                _bytes = _getData( _options.filename );
            }
            else
            {
                showUsages( "no filename provided" );
            }
            
            /* note:
               for some options we need to check them first
               to know if we need to force the parse tags option to true
            */
            if( _options.outputOption )
            {
                switch( _options.outputValue )
                {
                    case "metadata":
                    case "date":
                    case "time":
                    case "timestamp":
                    case "sdk":
                    case "sdkversion":
                    _options.parseTags = true;
                    break;
                }
            }
            
            _swfparser = new SWFParser( _bytes,
                                        _options.parseTags,
                                        _options.parseTagsContent,
                                        _options.showUnparsedValidTags,
                                        _options.showParsedValidTags,
                                        _options.fullKnownTagInfo,
                                        _options.fullUnknownTagInfo,
                                        _options.truncateTags,
                                        _options.hexgroup,
                                        _options.hexwidth );
            
            if( _options.outputOption )
            {
                //trace( "value = " + _options.outputValue );
                //trace( "format = " + _options.outputFormat );
                
                switch( _options.outputValue )
                {
                    case "type":
                    case "filetype":
                    trace( _swfparser.signature + _swfparser.version );
                    break;
                    
                    case "sign":
                    case "signature":
                    trace( _swfparser.signature );
                    break;
                    
                    case "version":
                    trace( _swfparser.version );
                    break;
                    
                    case "rect":
                    case "rectangle":
                    trace( _swfparser.frameSize );
                    break;
                    
                    case "fps":
                    case "rate":
                    trace( _swfparser.frameRate );
                    break;
                    
                    case "frame":
                    case "frames":
                    trace( _swfparser.frameCount );
                    break;
                    
                    case "size":
                    if( _swfparser.isCompressed() )
                    {
                        trace( bytesToHumandReadable( _swfparser.zipLength, 2, false, _options.outputFormat ) );
                    }
                    else
                    {
                        trace( bytesToHumandReadable( _swfparser.fileLength, 2, false, _options.outputFormat ) );
                    }
                    break;
                    
                    case "unzip":
                    case "unzipped":
                    case "uncompressed":
                    trace( bytesToHumandReadable( _swfparser.fileLength, 2, false, _options.outputFormat ) );
                    break;
                    
                    case "date":
                    case "time":
                    case "timestamp":
                    if( _options.outputFormat == "string" )
                    {
                        trace( new Date( _swfparser.timestamp ) );
                    }
                    else
                    {
                        trace( _swfparser.timestamp );
                    }
                    break;
                    
                    case "metadata":
                    if( _options.outputFormat == "pp" )
                    {
                        var data:XML = new XML( _swfparser.metadata );
                            XML.prettyPrinting = true;
                        trace( data.toString() );
                    }
                    else
                    {
                        trace( _swfparser.metadata );
                    }
                    break;
                    
                    case "sdk":
                    case "sdkversion":
                    trace( _swfparser.sdkversion );
                    break;
                    
                    default:
                    showUsages( "Unvalid output option \"" + _options.outputValue + "\"" );
                }
                
                System.exit( 0 );
            }
            
            trace( _swfparser.toString() );
            System.exit( 0 );
        }

    }
}