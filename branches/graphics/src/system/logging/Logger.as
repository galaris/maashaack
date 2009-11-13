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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    import flash.events.IEventDispatcher;
    
    /**
     * All loggers within the logging framework must implement this interface.
     */
    public interface Logger extends IEventDispatcher
    {
        /**
         * Indicates the channel value for the logger.
         */
        function get channel():String ;
        
        /**
         * Logs the specified data using the LogEventLevel.DEBUG level.
         */
         function debug( context:* , ...rest:Array ):void ;
        
        /**
         * Logs the specified data using the LogEventLevel.ERROR level.
         */
        function error( context:* , ...rest:Array ):void ;
        
        /**
         * Logs the specified data using the LogEventLevel.FATAL level.
         */
        function fatal( context:* , ...rest:Array ):void ;
        
        /**
         * Logs the specified data using the LogEvent.INFO level.
         */
        function info( context:* , ...rest:Array ):void ;
        
        /**
         * Logs the specified data using the LogEvent.ALL level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        function log( context:*, ...rest ):void ;
        
        /**
         * Logs the specified data using the LogEventLevel.WARN level.
         */
        function warn( context:* , ...rest:Array ):void ;
    }
}