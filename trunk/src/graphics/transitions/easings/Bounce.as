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

package graphics.transitions.easings
{
    /**
     * The Bounce class defines three easing functions to implement bouncing motion with ActionScript animation, 
     * similar to a ball falling and bouncing on a floor with several decaying rebounds.
     */
    public class Bounce 
    {
        /**
         * The <code class="prettyprint">easeIn()</code> method starts the bounce motion slowly and then accelerates motion as it executes. 
         * @param t Specifies the current time, between 0 and duration inclusive.
         * @param b Specifies the initial value of the animation property.
         * @param c Specifies the total change in the animation property.
         * @param d Specifies the duration of the motion.
         * @return The value of the interpolated property at the specified time.
         */
        public static function easeIn ( t:Number, b:Number, c:Number, d:Number ):Number 
        {
            return c - easeOut( d - t , 0 , c , d ) + b;
        }
        
        /**
         * The <code class="prettyprint">easeInOut()</code> method combines the motion of the <code class="prettyprint">easeIn()</code> and <code class="prettyprint">easeOut()</code> methods 
         * to start the motion by backtracking, then reversing direction and moving toward the target, overshooting the target slightly, 
         * reversing direction again, and then moving back toward the target.
         * @param t Specifies the current time, between 0 and duration inclusive.
         * @param b Specifies the initial value of the animation property.
         * @param c Specifies the total change in the animation property.
         * @param d Specifies the duration of the motion.
         * @return The value of the interpolated property at the specified time.
         */
        public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number 
        {
            return (t < d/2) ? easeIn(t * 2, 0, c, d) * 0.5 + b : easeOut(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b ;
        }
        
        /**
         * The <code class="prettyprint">easeOut()</code> method starts the bounce motion fast and then decelerates motion as it executes.
         * @param t Specifies the current time, between 0 and duration inclusive.
         * @param b Specifies the initial value of the animation property.
         * @param c Specifies the total change in the animation property.
         * @param d Specifies the duration of the motion.
         * @return The value of the interpolated property at the specified time.
         */
        public static function easeOut (t:Number, b:Number, c:Number, d:Number ):Number 
        {
            if ((t /= d) < (1 / 2.75))
            {
                return c * (7.5625 * t * t) + b;
            }
            else if (t < (2 / 2.75))
            {
                return c * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75) + b ;
            }
            else if (t < (2.5 / 2.75))
            {
                return c * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375) + b ;
            }
            else
            {
                return c * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375) + b ;
            }
        }
    }
}
