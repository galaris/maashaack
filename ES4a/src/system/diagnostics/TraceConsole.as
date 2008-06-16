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

package system.diagnostics
    {
    import system.Strings;
    import system.terminals.Console;
    
    /**
    * The TraceConsole reuse the trace function that redirect
    * messages to the output console in either Flash or Flex.
    * 
    * note:
    * You can not read from the output and so the TraceConsole
    * is not interactive.
    */
    public class TraceConsole implements Console
        {
        private var _buffer:String = "";
        
        public function TraceConsole()
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
            
            messages.unshift(msg);
            return Strings.format.apply( Strings, messages );
            }
        
        public function read():String
            {
            return null;
            }
        
        public function readLine():String
            {
            return null;
            }
        
        public function write( ...messages ):void
            {
            _buffer += _formatMessage( messages );
            }
        
        public function writeLine( ...messages ):void
            {
            var msg:String = _formatMessage( messages );
            trace( _buffer + msg );
            _buffer = "";
            }
        
        }
    }

