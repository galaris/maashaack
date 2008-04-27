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

    - Marc ALCARAZ <ekameleon@gmail.com>

*/
package system
{

	/* TODO: improve all that
    */
    public class Console
        {
        private static var _buffer:String  = "";
        
        private static var _reader:* = null;
        private static var _writer:* = trace;
        
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
        
        public static function set reader( reader:* ):void
            {
            _reader = reader;
            }
        
        public static function set writer( writer:* ):void
            {
            _writer = writer;
            }
        
        public static function read():String
            {
            if( _reader === null )
                {
                return "";
                }
            
            return "";
            }
        
        public static function readLine():String
            {
            if( _reader === null )
                {
                return "";
                }
            
            return "";
            }
        
        public static function write( ...messages ):void
            {
            if( messages.length == 0 )
                {
                return;
                }
            
            _buffer += formatMessage( messages );
            }
        
        public static function writeLine( ...messages ):void
            {
            var msg:String = formatMessage( messages );
            
            if( _writer !== null )
                {
                _writer( _buffer + msg );
                }
            
            _buffer = "";
            }
        
        
        }
    
    }

