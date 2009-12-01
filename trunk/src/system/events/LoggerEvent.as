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

package system.events
{
    import system.logging.LoggerLevel;
    
    import flash.events.Event;
    
    /**
     * Represents the log information for a single logging event. 
     * The loging system dispatches a single event each time a process requests information be logged.
     * This event can be captured by any object for storage or formatting.
     */
    public class LoggerEvent extends Event
    {
        /**
         * Creates a new LoggerEvent.
         * @param message The context or message of the log.
         * @param level The level of the log.
         */
        public function LoggerEvent( message:* , level:LoggerLevel )
        {
            super( LoggerEvent.LOG , false , false ) ;
            this.message = message ;
            this.level   = (level == null) ? LoggerLevel.ALL : level ;
        }
        
        /**
         * The default string level value in the getLevelString() method.
         */
        public static var DEFAULT_LEVEL_STRING:String = "UNKNOWN" ;
        
        /**
         * Event type constant, identifies a logging event.
         */
        public static const LOG:String = "log";
        
        /**
         * Provides access to the level for this log event.
         */
        public var level:LoggerLevel ;
        
        /**
         * Provides access to the message that was logged.
         */
        public var message:* ;
        
        /**
         * Returns the shallow copy of the event.
         * @return the shallow copy of the LogEvent event.
         */
        public override function clone():Event
        {
            return new LoggerEvent( message , level );
        }
        
        /**
         * Returns a String value representing the level specified.
         * @return a String value representing the level specified.
         */
        public static function getLevelString( value:LoggerLevel ):String
        {
            if ( LoggerLevel.isValidLevel( value ) )
            {
                return value.toString() ;
            }
            else
            {
                return DEFAULT_LEVEL_STRING ;
            }
        }
    }
}