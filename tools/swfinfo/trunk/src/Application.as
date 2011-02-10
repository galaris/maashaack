package
{
    import avmplus.System;
    
    import core.version;
    
    public class Application
    {
        private var _options:Options;
        
        private var _version:version = new version( 1, 0 );
                    _version.revision = $Rev$;
        
        private var _timestamp:String = "$Date$";
        
        private var _license:String = <![CDATA[
swfinfo is open source software

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

  swfinfo [-h] [-v] [-L] [-s] [-p] [-a] [-u] [-k] [-x] [-n] [-t:val] [-g:val] [-w:val] file

Options:
  file           a local <file> or remote <file>
                 in case of a  remote file, need to be a valid URL
                 eg. starting with http/ftp/etc.

  -h             this help
  
  -v             to see the program version
  
  -L             License and program informations

  -s             save a remote file
                 on the current local directory

  -o:val[|opt]   single line output configured by <opt>
                 when you use this mode the program will return
                 only the info from <opt> and nothing else
                 <val> can be:
                 * sign, signature
                 * rect, rectangle
                 * fps
                 * frame, frames
                 * size [|opt]
                   format <opt> can be:
                   B, K, M, G, T, P, E, Z, Y
                   for bytes, kilo, giga, tera, peta, etc.
                 * zip [|opt]
                   format <opt> can be:
                   B, K, M, G, T, P, E, Z, Y
                   for bytes, kilo, giga, tera, peta, etc.
                 * date [|opt]
                   format <opt> can be:
                   any of mm, MM, yy, YYYY, etc.
                 * metadata
                 * product
                 * flexsdk

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
        
        public function Application()
        {
            _options = new Options( this );
        }
        
        public function showUsages( exit:Boolean = true ):void
        {
            trace( _usage );
            
            if( exit ) { System.exit( 1 ); }
        }
        
        public function run( args:Array ):void
        {
            trace( "swfinfo v1.0" );
            
            if( args.length == 0 ) { showUsages(); }
            
            var success:Boolean = _options.parse( args );
            
            if( !success || _options.showUsage ) { showUsages(); }
            
        }

    }
}