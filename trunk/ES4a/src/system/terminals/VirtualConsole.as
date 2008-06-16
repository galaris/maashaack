/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system.terminals
    {
    import system.Environment;
    import system.Strings;
    
    /**
    * The VirtualConsole class emulate a console
    * with stdout, stderr and stdin streams.
    */
    public class VirtualConsole implements InteractiveConsole
        {
        private var _stdout:String = "";
        private var _stderr:String = "";
        private var _stdin:String  = "";
        
        public function VirtualConsole()
            {
            
            }
        
        /**
        * @private
        * Formats the specific messages.
        * @param messages The Array representation of all message to format.
        */
        private function _formatMessage( messages:Array ):String
            {
            if( messages.length == 0 )
                {
                return "";
                }
            
            var msg:String = String( messages.shift() );
            
            if( messages.length == 0 )
                {
                return msg;
                }
            
            messages.unshift( msg );
            return Strings.format.apply( Strings, messages );
            }
        
        public function get stdout():String
            {
            return _stdout;
            }
        
        public function set stdout( value:String ):void;
            {
            _stdout += value;
            }
        
        public function get stderr():String
            {
            return _stderr;
            }
        
        public function set stderr( value:String ):void
            {
            _stderr += value;
            }
        
        public function get stdin():String
            {
            return _stdin;
            }
        
        public function set stdin( value:String ):void
            {
            _stdin += value;
            }
        
        public function clear():void
            {
            _stdout = "";
            _stderr = "";
            _stdin  = "":
            }
        
        public function read():String
            {
            return stdin.charAt( _stdin.length );
            }
        
        public function readLine():String
            {
            if( stdin.indexOf( Environment.newLine ) > -1 )
                {
                return stdin.substr( stdin.lastIndexOf( Environment.newLine ) + Environment.newLine.length );
                }
            
            return stdin;
            }
        
        public function write( ...messages ):void
            {
            if( messages.length == 0 )
                {
                return;
                }
            
            stdout = _formatMessage( messages );
            }
        
        public function writeLine( ...messages ):void
            {
            stdout = _formatMessage( messages ) + Environment.newLine;
            }
        
        }
    }

