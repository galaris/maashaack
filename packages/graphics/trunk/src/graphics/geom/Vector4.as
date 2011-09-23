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
    import graphics.Geometry;
    
    /**
     * Represents a vector in a 3D world with the coordinates x, y, z and w.
     */
    public class Vector4 implements Geometry
    {
        /**
         * Creates a new <code class="prettyprint">Vector4</code> instance.
         * @param x the x coordinate.
         * @param y the y coordinate.
         * @param z the z coordinate.
         * @param w the w coordinate.
         */     
        public function Vector4(x:Number = 0, y:Number = 0, z:Number = 0 , w:Number = 0 )
        {
            this.x = isNaN(x) ? 0 : x ;
            this.y = isNaN(y) ? 0 : y ;
            this.z = isNaN(z) ? 0 : z ;
            this.w = isNaN(w) ? 0 : w ;
        }
        
        /**
         * Defines the Vector4 object with the x, y, z and w properties set to zero.
         */
        public static var ZERO:Vector4 = new Vector4(0,0,0,0) ;
        
        /**
         * Defines the x coordinate.
         */
        public var x:Number ;
        
        /**
         * Defines the y coordinate.
         */
        public var y:Number ;
        
        /**
         * Defined the z coordinate.
         */
        public var z:Number;
        
        /**
         * Defined the w coordinate.
         */
        public var w:Number;
        
        /**
         * Computes the addition of two Vector4 object.
         * @param v the vector object to add.
         */
        public function add( v:Vector4 ):void
        {
             x += v.x ;
             y += v.y ;
             z += v.z ;
             w += v.w ;
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Vector4(x, y, z, w) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if ( o is Vector4)
            {
                return (o.x == x) && (o.y == y) && (o.z == z) && (o.w == w) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Scales the vector object with the input value.
         * @param value a real number to scale the current vector object.
         */
        public function scale( value:Number ):void
        {
            x *= value ;
            y *= value ;
            z *= value ;
            w *= value ;
        }
        
        /**
         * Computes the substraction of the current Vector3 object with an other.
         * @param v the vector to substract.
         */
        public function substract( v:Vector4 ):void
        {
            x -= v.x ;
            y -= v.y ;
            z -= v.z ;
            w -= v.w ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { x:x , y:y , y:y , w:w } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new graphics.geom.Vector4(" +  x.toString()  + "," + y.toString()  + "," + z.toString() + "," + w.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[Vector4 x:" + x + " y:" + y + " z:" + z + " w:" + w + "]" ;
        }
    }
}
