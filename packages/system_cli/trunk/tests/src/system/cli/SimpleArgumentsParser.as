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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package system.cli
{

    public class SimpleArgumentsParser extends ArgumentsParser
    {
        private var _debugTrace:String = "";
        
        public var a:Boolean;
        
        public var b:Boolean;
        
        public var c:String;
        
        public var filename:String;
        
        public function SimpleArgumentsParser()
        {
            super(["?", "a", "b", "c"]);
            a = false;
            b = false;
            c = "";
            filename = "";
        }
        
        public function set debugTrace( msg:String ):void
        {
            _debugTrace += msg + "\n";
        }
        
        public function get debugTrace():String
        {
            return _debugTrace;
        }
        
        public function clearTrace():void
        {
            _debugTrace = "";
        }
        
        public override function onUsage( errorInfo:String = "" ):void
        {
            // var data:String = "";
            if( errorInfo != "" )
            {
                debugTrace = "CLI switch error: " + errorInfo;
            }
            
            debugTrace = "Usage: myApp [-a] [-b] [-c:x|y|z] <filename>";
            debugTrace = "    -? Show the help";
            debugTrace = "    -a AAA mode";
            debugTrace = "    -b BBB mode";
            debugTrace = "    -c CCC option, x or y or z";
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
                    break;
                
                case "a":
                    a = true;
                    break;
                
                case "b":
                    b = true;
                    break;
                
                case "c":
                    value = value.split(":").join("");
                    if( (value == "x") || (value == "y") || (value == "z") )
                    {
                        c = value;
                    }
                    else
                    {
                        status = SwitchStatus.error;
                        onUsage(value + " is not a correct value for -c");
                    }
                    break;
                
                default:
                    status = SwitchStatus.error;
            }
            
            return status;
        }
        
        public override function onParsed():SwitchStatus
        {
            var status:SwitchStatus = SwitchStatus.noError;
            
            if( (filename == null) || (filename == "") )
            {
                debugTrace = "you have to provide a <filename>.";
                status = SwitchStatus.showUsage;
            }
            return status;
        }
    }
}

