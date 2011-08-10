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
    import system.Enum;
    import system.Equatable;
    
    /**
     * Static class containing constants for use in the level property.
     */
    public class LoggerLevel extends Enum implements Equatable
    {
        /**
         * Creates a new LoggerLevel instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function LoggerLevel( value:int , name:String )
        {
            super( value , name ) ;
        }
        
        /**
         * Intended to force a target to process all messages (1).
         */
        public static const ALL:LoggerLevel = new LoggerLevel( 1 , "ALL" ) ;
        
        /**
         * Designates informational level messages that are fine grained and most helpful when debugging an application (2).
         */
        public static const DEBUG:LoggerLevel = new LoggerLevel( 2 , "DEBUG" ) ;
        
        /**
         * The default string level value in the getLevelString() method.
         */
        public static var DEFAULT_LEVEL_STRING:String = "UNKNOWN" ;
        
        /**
         * Designates error events that might still allow the application to continue running (8).
         */
        public static const ERROR:LoggerLevel = new LoggerLevel( 8 , "ERROR" ) ;
        
        /**
         * Designates events that are very harmful and will eventually lead to application failure (16).
         */
        public static const FATAL:LoggerLevel = new LoggerLevel( 16 , "FATAL" ) ;
        
        /**
         * Designates informational messages that highlight the progress of the application at coarse-grained level (4).
         */
        public static const INFO:LoggerLevel = new LoggerLevel( 4 , "INFO" ) ;
        
        /**
         * A special level that can be used to turn off logging (0).
         */
        public static const NONE:LoggerLevel = new LoggerLevel( 0 , "NONE" ) ;
        
        /**
         * Designates events that could be harmful to the application operation (6).
         */
        public static const WARN:LoggerLevel = new LoggerLevel( 6 , "WARN" ) ;
        
        /**
         * What a Terrible Failure: designates an exception that should never happen. (32).
         */
        public static const WTF:LoggerLevel = new LoggerLevel( 32 , "WTF" ) ;
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is LoggerLevel )
            {
                return ( (o as LoggerLevel)._name == _name) && ( (o as LoggerLevel)._value == _value) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the number level passed in argument is valid.
         * @return <code class="prettyprint">true</code> if the number level passed in argument is valid.
         */
        public static function getLevel( value:int ):LoggerLevel 
        {
            var levels:Array = [ ALL, DEBUG, ERROR, FATAL, INFO, NONE, WARN , WTF ] ;
            var l:int = levels.length ;
            while( --l > -1 )
            {
                if ( int(levels[l] as LoggerLevel) == value )
                {
                    return levels[l] ; 
                }
            }
            return null ;
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
        
        /**
         * Returns <code class="prettyprint">true</code> if the number level passed in argument is valid.
         * @return <code class="prettyprint">true</code> if the number level passed in argument is valid.
         */
        public static function isValidLevel( level:LoggerLevel ):Boolean 
        {
            var levels:Array = [ ALL, DEBUG, ERROR, FATAL, INFO, NONE, WARN , WTF ] ;
            return levels.indexOf( level ) > -1 ;
        }
    }
}