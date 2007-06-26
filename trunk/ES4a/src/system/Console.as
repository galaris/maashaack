
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
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system
    {
    
    public class Console extends Ghost
        {
        private static var _buffer:String  = "";
        
        public static function read():String
            {
            //return __::read();
            return ""; //not implemented for anyone yet
            }
        
        public static function readLine():String
            {
            //return __::readLine();
            return ""; //not implemented for anyone yet
            }
        
        internal static function formatMessage( messages:Array ):String
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
        
        flash static function write( messages:Array ):void
            {
            _buffer += formatMessage( messages );
            }
        
        public static function write( ...messages ):void
            {
            if( messages.length == 0 )
                {
                return;
                }
            
            //__::write( messages );
            flash::write( messages );
            }
        
        flash static function writeLine( messages:Array ):void
            {
            var msg:String = formatMessage( messages );
            trace( _buffer + msg ); //flash.utils.trace
            _buffer = "";
            }
        
        public static function writeLine( ...messages ):void
            {
            //__::writeLine( messages );
            flash::writeLine( messages );
            }
        
        
        }
    
    }

