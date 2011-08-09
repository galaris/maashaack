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

package graphics.geom 
{
    import core.reflect.getClassPath;
    
    /**
     * The polar coordinate system is a two-dimensional coordinate system in which each point on a plane is determined by a distance from a fixed point and an angle from a fixed direction.
     */
    public class Polar implements Geometry
    {
        /**
         * Creates a new Polar instance.
         * @param radius The distance from the pole.
         * @param angle The angle of the polar object.
         */
        public function Polar( radius:Number = 0 , angle:Number = 0 )
        {
            this.radius = radius ;
            this.angle  = angle  ;
        }
        
        /**
         * Defines the Polar object with the radius and angle properties set to zero.
         */
        public static const ZERO:Polar = new Polar( 0 , 0 ) ;
        
        /**
         * The angle of the polar point.
         */
        public var angle:Number ;
        
        /**
         * The distance from the pole.
         */
        public var radius:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Polar( radius , angle ) ;
        }
        
        /**
         * Reset the polar object.
         */
        public function empty():void
        {
            angle  = 0 ;
            radius = 0 ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if ( o is Polar )
            {
                return (o.angle == angle) && (o.radius == radius) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Initialize the Polar object with the passed-in object defines with the attributes angle and radius.
         */
        public function fromObject( o:Object ):void
        {
            angle  = o.angle ;
            radius = o.radius ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { angle:angle , radius:radius } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" +  radius.toString()  + "," + angle.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[Polar radius:" + radius + " angle:" + angle + "]" ;
        }
    }
}
