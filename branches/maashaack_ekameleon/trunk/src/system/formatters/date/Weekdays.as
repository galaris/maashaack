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

package system.formatters.date 
{
    /**
     * This static enumeration class register all string constants to defined a day.
     */
    public class Weekdays
    {
        /**
         * Fully written out string for monday.
         */
        public static const MONDAY:String = "Monday" ;
        
        /**
         * Fully written out string for tuesday.
         */
        public static const TUESDAY:String = "Tuesday" ;
        
        /**
         * Fully written out string for wednesday.
         */
        public static const WEDNESDAY:String = "Wednesday" ;
        
        /**
         * Fully written out string for thursday.
         */
        public static const THURSDAY:String = "Thursday" ;
        
        /**
         * Fully written out string for friday.
         */
        public static const FRIDAY:String = "Friday" ;
        
        /**
         * Fully written out string for saturday.
         */
        public static const SATURDAY:String = "Saturday" ;
        
        /**
         * Fully written out string for sunday.
         */
        public static const SUNDAY:String = "Sunday" ;
        
        /**
         * Retrieves a list of localized strings containing the names of weekdays for the current calendar system.
         */
        public static function getWeekdayNames():Array 
        {
            return _names ;
        }
        
        /**
         * Sets a list of localized strings containing the week days names for the current calendar system.
         */
        public static function setWeekdayNames( names:Array ):void
        {
            _names = [ SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY ] ;
            if ( names != null && names.length > 0 )
            {
                _names[ 0] = names[ 0] is String ? names[ 0] : SUNDAY ;
                _names[ 1] = names[ 1] is String ? names[ 1] : MONDAY ;
                _names[ 2] = names[ 2] is String ? names[ 2] : TUESDAY ;
                _names[ 3] = names[ 3] is String ? names[ 3] : WEDNESDAY ;
                _names[ 4] = names[ 4] is String ? names[ 4] : THURSDAY ;
                _names[ 5] = names[ 5] is String ? names[ 5] : FRIDAY ;
                _names[ 6] = names[ 6] is String ? names[ 6] : SATURDAY ;
            }
        }
        
        /**
         * @private
         */
        private static var _names:Array = [ SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY ] ;
    }
}
