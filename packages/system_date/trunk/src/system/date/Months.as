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

package system.date 
{
    /**
     * This static enumeration class register all string constants to defined a month.
     */
    public class Months 
    {
        /**
         * Fully written out string for january.
         */
        public static const JANUARY:String = "January" ;
        
        /**
         * Fully written out string for february.
         */
        public static const FEBRUARY:String = "February" ;
        
        /**
         * Fully written out string for march.
         */
        public static const MARCH:String = "March" ;
        
        /**
         * Fully written out string for april.
         */
        public static const APRIL:String = "April" ;
        
        /**
         * Fully written out string for may.
         */
        public static const MAY:String = "May" ;
        
        /**
         * Fully written out string for june.
         */
        public static const JUNE:String = "June" ;
        
        /**
         * Fully written out string for july.
         */
        public static const JULY:String = "July" ;
        
        /**
         * Fully written out string for august.
         */
        public static const AUGUST:String = "August" ;
        
        /**
         * Fully written out string for september.
         */
        public static const SEPTEMBER:String = "September" ;
        
        /**
         * Fully written out string for october.
         */
        public static const OCTOBER:String = "October" ;
        
        /**
         * Fully written out string for november.
         */
        public static const NOVEMBER:String = "November" ;
        
        /**
         * Fully written out string for december.
         */
        public static const DECEMBER:String = "December" ;
        
        /**
         * Retrieves a list of localized strings containing the month names for the current calendar system.
         * @return a list of localized strings containing the month names for the current calendar system.
         */
        public static function getMonthNames():Array 
        {
            return _names ;
        }
        
        /**
         * Sets a list of localized strings containing the month names for the current calendar system.
         */
        public static function setMonthNames( names:Array ):void
        {
            _names = [ JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER ] ;
            if ( names != null && names.length > 0 )
            {
                _names[ 0] = names[ 0] is String ? names[ 0] : JANUARY ;
                _names[ 1] = names[ 1] is String ? names[ 1] : FEBRUARY ;
                _names[ 2] = names[ 2] is String ? names[ 2] : MARCH ;
                _names[ 3] = names[ 3] is String ? names[ 3] : APRIL ;
                _names[ 4] = names[ 4] is String ? names[ 4] : MAY ;
                _names[ 5] = names[ 5] is String ? names[ 5] : JUNE ;
                _names[ 6] = names[ 6] is String ? names[ 6] : JULY ;
                _names[ 7] = names[ 7] is String ? names[ 7] : AUGUST ;
                _names[ 8] = names[ 8] is String ? names[ 8] : SEPTEMBER ;
                _names[ 9] = names[ 9] is String ? names[ 9] : OCTOBER ;
                _names[10] = names[10] is String ? names[10] : NOVEMBER ;
                _names[11] = names[11] is String ? names[11] : DECEMBER ;
            }
        }
        
        /**
         * @private
         */
        private static var _names:Array = [ JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER ] ;
    }
}
