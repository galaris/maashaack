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

package graphics.transitions.easings
{
    /**
     * The Elastic class defines three easing functions to implement motion with ActionScript animations. 
     */
    public class Elastic 
    {
        /**
         * The easeIn() method starts motion from zero velocity and then accelerates motion as it executes.
         */
        public static function easeIn (t:Number, b:Number, c:Number, d:Number, a:Number=NaN, p:Number=NaN):Number 
        {
            var s:Number ;
            if (t==0)
            {
                return b;  
            }
            if ((t/=d)==1) 
            {
                return b+c ;
            }
            if ( !p ) 
            {
                p= d * .3 ;
            }
            if (!a || a < Math.abs(c)) 
            { 
                a = c   ; 
                s = p/4 ; 
            }
            else 
            {
                s = p/(2*Math.PI) * Math.asin (c/a) ;
            }
            return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
        }
        
        /**
         * The easeInOut() method combines the motion of the easeIn() and easeOut() methods to start the motion from a zero velocity, accelerate motion, then decelerate to a zero velocity.
         */
        public static function easeInOut (t:Number, b:Number, c:Number, d:Number, a:Number=NaN, p:Number=NaN):Number 
        {
            var s:Number ;
            if (t==0) 
            {
                return b;  
            }
            if ((t/=d/2)==2) 
            {
                return b+c ;
            }
            if (!p)
            {
                p=d*(.3*1.5) ;
            }
            if (!a || a < Math.abs(c)) 
            { 
                a = c   ; 
                s = p/4 ; 
            }
            else 
            {
                s = p / (2*Math.PI) * Math.asin (c/a) ;
            }
            if (t < 1) 
            {
                return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
            }
            return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b ;
        }
        
        /**
         * The easeOut() method starts motion fast and then decelerates motion to a zero velocity as it executes.
         */
        public static function easeOut (t:Number, b:Number, c:Number, d:Number, a:Number=NaN, p:Number=NaN):Number 
        {
            var s:Number ;
            if (t==0) 
            {
                return b ;
            }
            if ((t/=d)==1) 
            {
                return b+c ;
            }    
            if (!p) 
            { 
                p=d*.3;
            }
            if (!a || a < Math.abs(c)) 
            { 
                a = c   ; 
                s = p/4 ; 
            }
            else 
            {
                s = p / (2*Math.PI) * Math.asin(c/a) ;
            }
            return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b) ;
        }
    }
}
