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
  
  The Original Code is [flashdoc].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package flashdoc
{
    import core.strings.trim;
    import system.cli.ArgumentsParser;
    import system.cli.SwitchStatus;
    
    public class Options extends ArgumentsParser
    {
        private var _app:Application;
        
        public var verbose:Boolean;
        public var showUsage:Boolean;
        
        public var filename:String;
        public var foldername:String;
        public var outputname:String;
        
        public function Options( app:Application )
        {
            //super( switchSymbols, caseSensitive, switchChars );
            super( ["?","v","f","o"], true );
            
            _app = app;
            
            verbose   = false;
            showUsage = false;
            
            filename   = "";
            foldername = "FlashDoc";
            outputname = "Test";
            
        }
        
        public override function onUsage( errorInfo:String = "" ):void
        {
            
            if( errorInfo != "" )
            {
                trace( "Cli switch error: " + errorInfo );
            }
            
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
                case "?":
                status = SwitchStatus.showUsage;
                trace( _app.getHelp() );
                break;
                
                case "v":
                verbose = true;
                break;
                
                case "f":
                var folder:String = trim( value, [" ",":"] );
                //trace( "folder: [" + folder + "]" );
                foldername = folder;
                break;
                
                case "o":
                var output:String = trim( value, [" ",":"] );
                //trace( "output: [" + output + "]" );
                outputname = output;
                break;
                
                default:
                status = SwitchStatus.error;
            }
            
            return status;
        }
        
        public override function onParsed():SwitchStatus
        {
            var status:SwitchStatus = SwitchStatus.noError;
            
            if( filename == "" )
            {
                status = SwitchStatus.showUsage;
                trace( "you need to provide a <filename>" );
                return status;
            }
            
            if( foldername == "" )
            {
                status = SwitchStatus.showUsage;
                trace( "the foldername is empty, use -f:<foldername>" );
                return status;
            }
            
            if( outputname == "" )
            {
                status = SwitchStatus.showUsage;
                trace( "the outputname is empty, use -o:<outputname>" );
                return status;
            }
            
            return status;
        }
        
    }
}

