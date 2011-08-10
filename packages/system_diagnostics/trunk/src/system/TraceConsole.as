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

package system.diagnostics
{
    import core.strings.format;
    
    import system.terminals.Console;
    
    import flash.errors.IllegalOperationError;
    
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
            
            var msg:String = String( messages.shift( ) );
            
            if( messages.length == 0 )
            {
                return msg;
            }
            
            messages.unshift( msg );
            return format.apply( null, messages );
        }
        
        /**
         * Creates a new TraceConsole instance.
         */
        public function TraceConsole()
        {
        }
        
        /**
         * Not supported, the console isn't interactive.
         * @throws flash.errors.IllegalOperationError The read() method is illegal in this console
         */
        public function read():String
        {
            throw new IllegalOperationError( this + " read() method is illegal in this console." ) ;
        }
        
        /**
         * Not supported, the console isn't interactive.
         * @throws flash.errors.IllegalOperationError The read() method is illegal in this console
         */
        public function readLine():String
        {
            throw new IllegalOperationError( this + " readLine() method is illegal in this console." ) ;
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

