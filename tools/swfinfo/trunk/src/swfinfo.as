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

/*
    swfinfo
    Utility to get in depth informations from a SWF file.

    see:
    http://code.google.com/p/maashaack/wiki/swfinfo
 */

//FPAPI
include "flash/geom/Point.as";
include "flash/geom/Rectangle.as";

//maashaack
include "core/uri.as";
include "core/version.as";
include "core/strings/format.as";
include "core/strings/pad.as";
include "core/strings/trim.as";
include "core/strings/whiteSpaceChars.as";
include "system/cli/SwitchStatus.as";
include "system/cli/ArgumentsParser.as";

//swfinfo
include "utils/hexformat.as";
include "utils/bytesToHumandReadable.as";
include "utils/ByteParser.as";
include "utils/SWFParser.as";
include "Options.as";
include "Application.as";

import avmplus.System;

/*
//options
var parseTags:Boolean = true;
var parseTagsContent:Boolean = true;
var showUnparsedValidTags:Boolean = true;
var showParsedValidTags:Boolean = false;
var fullKnownTagInfo:Boolean = false;
var fullUnknownTagInfo:Boolean = false;
var truncateTags:uint = 200;
var hexgroup:uint = 8;
var hexwidth:uint = 80;

var file:ByteArray = FileSystem.readByteArray( "test.swf" );
var test:SWFParser = new SWFParser( file,
                                    parseTags, parseTagsContent,
                                    showUnparsedValidTags, showParsedValidTags,
                                    fullKnownTagInfo, fullUnknownTagInfo,
                                    truncateTags, hexgroup, hexwidth );

trace( test.toString() );
*/

//var args:Array = [ "-p", "-a", "test.swf" ];

var app:Application = new Application();
    //app.run( args );
    app.run( System.argv );




