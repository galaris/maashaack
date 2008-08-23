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
    * The TraceConsole reuse the trace function that redirect messages to the output console in either Flash or Flex.
    * <p><b>Note:</b> You can not read from the output and so the TraceConsole is not interactive.</p>
    */
    public class TraceConsole implements Console
        {
        
        /**
         * @private
         */
        protected var _buffer:String = "" ;
        
        /**
         * Formats the specific messages.
         * @param messages The Array representation of all message to format.
         * @private 
         */
        protected function _formatMessage( messages:Array ):String
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
        
        /**
         * Creates a new TraceConsole instance.
         */
        public function TraceConsole()
            {
            
            }
                
        /**
         * Returns the last char.
         * @return the last char.
         */        
        public function read():String
            {
            return null;
            }
        
        /**
         * Returns the last line.
         * @return the last line.
         */        
        public function readLine():String
            {
            return null;
            }
        
        /**
         * Appends the message format.
         */        
        public function write( ...messages:Array ):void
            {
            _buffer += _formatMessage( messages );
            }
        
        /**
         * Appends the message format and add newline character.
         */        
        public function writeLine( ...messages:Array ):void
            {
            var msg:String = _formatMessage( messages );
            trace( _buffer + msg );
            _buffer = "" ;
            }
        
        }
    }

