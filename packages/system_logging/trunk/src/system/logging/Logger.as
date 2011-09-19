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

package system.logging
{
    import system.signals.Signal;
    
    /**
     * API for sending log output.
     */
    public final class Logger extends Signal
    {
        /**
         * Creates a new Logger instance.
         * @param channel The channel value of the logger.
         */
        public function Logger( channel:String )
        {
            _entry = new LoggerEntry( null , null , channel ) ;
        }
        
        /**
         * Indicates the channel value for the logger.
         */
        public function get channel():String
        {
            return _entry.channel ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.DEBUG level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function debug( context:* , ...rest ):void
        {
            _log( LoggerLevel.DEBUG , context , rest ) ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.ERROR level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function error( context:* , ...rest ):void
        {
            _log( LoggerLevel.ERROR , context , rest ) ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.FATAL level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.     
         */
        public function fatal(context:*, ...rest):void
        {
            _log( LoggerLevel.FATAL , context , rest ) ;
        }
        
        /**
         * Logs the specified data using the LogEvent.INFO level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function info(context:*, ...rest):void
        {
            _log( LoggerLevel.INFO , context , rest ) ;
        }
        
        /**
         * Logs the specified data using the LogEvent.ALL level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function log( context:*, ...rest ):void
        {
            _log( LoggerLevel.ALL , context , rest ) ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.WARN level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function warn(context:*, ...rest):void
        {
            _log( LoggerLevel.WARN , context , rest ) ;
        }
        
        /**
         * What a Terrible Failure: Report an exception that should never happen.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function wtf( context:* , ...rest:Array ):void
        {
            _log( LoggerLevel.WTF , context , rest ) ;
        }
        
        /**
         * @private
         */
        private var _entry:LoggerEntry ;
        
        /**
         * @private
         */
        private function _log( level:LoggerLevel, context:*, options:Array ):void
        {
            if( connected() )
            {
                if ( context is String )
                {
                    var len:int = options.length ;
                    for( var i:int ; i<len ; i++ )
                    {
                        context = (context as String).replace( new RegExp( "\\{" + i + "\\}" , "g" ) , options[i]);
                    }
                }
                _entry.message = context ;
                _entry.level   = level ;
                emit( _entry ) ;
            }
        }
    }
}