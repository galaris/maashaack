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

package graphics.numeric 
{
    /**
     * Implements the static behaviours of the Degrees manipulations.
     */
    public final class Degrees 
    {
        /**
         * Returns the inverse cosine of a slope ratio and returns its angle in degrees.
         * @param ratio a value between -1 and 1 inclusive.
         * @return the inverse cosine of a slope ratio and returns its angle in degrees.
         */
        public static function acosD (ratio:Number) : Number 
        {
            return Math.acos(ratio) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the arcsine of the passed angle.
         * @param ratio a value between -1 and 1 inclusive.
         * @return the arcsine of the passeds angle in degrees.
         */
        public static function asinD (ratio:Number) : Number 
        {
            return Math.asin(ratio) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the arctangent of the passed angle.
         * @param n a real number
         * @return the arctangent of the passed angle, a number between -Math.PI/2 and Math.PI/2 inclusive.
         */
        public static function atanD( angle:Number ):Number 
        {
            return Math.atan( angle ) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the arctangent2 of the passed angle.
         * @param y a value representing y-axis of angle vector.
         * @param x a value representing x-axis of angle vector.
         * @return the arctangent2 of the passed angle.
         */
        public static function atan2D( y:Number , x:Number ):Number 
        {
            return Math.atan2(y, x) * Trigo.RAD2DEG ;
        }
        
        /**
         * Calculates the cosine of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the cosine of the passed angle, a number between -1 and 1 inclusive.
         */
        public static function cosD(angle:Number):Number 
        {
            return Math.cos( angle * Trigo.DEG2RAD ) ;
        }
        
        /**
         * Calculates the sine of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the sine of the passed angle, a number between -1 and 1 inclusive.
         */
        public static function sinD(angle:Number):Number 
        {
            return Math.sin( angle * Trigo.DEG2RAD ) ;
        }
        
        /**
         * Calculates the tangent of the passed angle.
         * @param angle a value representing angle in degrees.
         * @return the tangent of the passed angle.
         */
        public static function tanD(angle:Number):Number 
        {
            return Math.tan( angle * Trigo.DEG2RAD ) ;
        }
    }
}
