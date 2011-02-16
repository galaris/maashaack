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

package
{
    import system.cli.SwitchStatus;
    import system.cli.ArgumentsParser;
    import core.strings.trim;

    public class Options extends ArgumentsParser
    {
        private var _app:Application;
        
        public var filename:String;
        public var showUsage:Boolean;
        public var showVersion:Boolean;
        public var showLicense:Boolean;
        public var saveRemoteFile:Boolean;
        public var outputOption:Boolean;
        public var outputValue:String;
        public var outputFormat:String;
        
        public var parseTags:Boolean;
        public var parseTagsContent:Boolean;
        public var showUnparsedValidTags:Boolean;
        public var showParsedValidTags:Boolean;
        public var fullKnownTagInfo:Boolean;
        public var fullUnknownTagInfo:Boolean;
        public var truncateTags:uint;
        public var hexgroup:uint;
        public var hexwidth:uint;
        
        
        public function Options( app:Application )
        {
            //super( switchSymbols, caseSensitive, switchChars );
            super( ["h","v","L","s","o","p","a","n","x","k","u","t","g","w"], true );
            
            _app = app;
            
            filename              = "";     // file
            showUsage             = false;  // -h
            showVersion           = false;  // -v
            showLicense           = false;  // -L
            saveRemoteFile        = false;  // -s
            outputOption          = false;  // -o:val[=opt]
            outputValue           = "";     //    val
            outputFormat          = "";     //         opt
            
            parseTags             = false;  // -p
            parseTagsContent      = true;   // -a
            showUnparsedValidTags = false;  // -n
            showParsedValidTags   = false;  // -x
            fullKnownTagInfo      = false;  // -k
            fullUnknownTagInfo    = false;  // -u
            truncateTags          = 200;    // -t:val
            hexgroup              = 8;      // -g:val
            hexwidth              = 80;     // -w:val
        }
        
        public override function onUsage( errorInfo:String = "" ):void
        {
            if( errorInfo != "" ) { trace( "CLI switch error: " + errorInfo ); }
            showUsage = true;
        }
        
        public override function onNonSwitch( value:String ):SwitchStatus
        {
            filename = value;
            return SwitchStatus.noError;
        }
        
        public override function onSwitch( symbol:String, value:String ):SwitchStatus
        {
            var status:SwitchStatus = SwitchStatus.noError;
            
            switch( symbol )
            {
                case "h":
                status = SwitchStatus.showUsage;
                break;
                
                case "v":
                showVersion = true;
                break;
                
                case "L":
                showLicense = true;
                break;
                
                case "s":
                saveRemoteFile = true;
                break;
                
                case "o":
                outputOption = true;
                value = trim( value, [":"] );
                var foundFormat:Boolean = value.indexOf( "=" ) > -1;
                
                if( foundFormat )
                {
                    var tmp:Array = value.split( "=" );
                    outputValue   = tmp[0];
                    outputFormat  = tmp[1];
                }
                else
                {
                    outputValue = value;
                }
                break;
                
                case "p":
                parseTags = true;
                break;
                
                case "a":
                parseTagsContent = false;
                break;
                
                case "n":
                showUnparsedValidTags = true;
                break;
                
                case "x":
                showParsedValidTags = true;
                break;

                case "k":
                fullKnownTagInfo = true;
                break;
                
                case "u":
                fullUnknownTagInfo = true;
                break;
                
                case "t":
                value = trim( value, [":"] );
                truncateTags = parseInt( value );
                break;
                
                case "g":
                value = trim( value, [":"] );
                hexgroup = parseInt( value );
                break;
                
                case "w":
                value = trim( value, [":"] );
                hexwidth = parseInt( value );
                break;
                
                default:
                status = SwitchStatus.error;
            }
            
            return status;
        }
        
        public override function onParsed():SwitchStatus
        {
            var status:SwitchStatus = SwitchStatus.noError;
            
            if( parseTags && (filename == "") )
            {
                status = SwitchStatus.error;
                trace( "you need to provide a <filename>" );
                return status;
            }
            
            return status;
        }
        
    }
}