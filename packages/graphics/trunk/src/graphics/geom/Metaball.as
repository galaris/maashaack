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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
    import core.dump;
    import graphics.Geometry;
    import system.hack;
    
    /**
     * Metaballs are, in computer graphics, organic-looking n-dimensional objects. 
     * The technique for rendering metaballs was invented by Jim Blinn in the early 1980s.
     * Each metaball is defined as a function in n-dimensions (ie. for three dimensions, f(x,y,z); three-dimensional metaballs tend to be most common, with two-dimensional implementations as well). 
     * A thresholding value is also chosen, to define a solid volume.
     */
    public class Metaball implements Geometry
    {
        use namespace hack ;
        
        /**
         * Creates a new <code class="prettyprint">Metaball</code> instance.
         */
        public function Metaball( x:Number = 0 , y:Number = 0 , radius:Number = 1 )
        {
            this.radius = radius ;
            this.x      = x ;
            this.y      = y ;
        }
        
        /**
         * The radius of the metaball.
         */
        public function get radius():Number
        {
            return _radius ;
        }
        
        /**
         * The radius of the metaball.
         */
        public function set radius( value:Number ):void
        {
            _radius        = isNaN(value) ? 0 : value ;
            _radiusSquared = _radius * _radius ; 
        }
        
        /**
         * The x component of the metaball.
         */
        public var x:Number ;
        
        /**
         * The y component of the metaball.
         */
        public var y:Number ;
        
        /**
         * Calculates the result of the typical equation for a Metaball.
         */
        public function calculate( tx:Number , ty:Number ):Number
        {
            return _radiusSquared / ( ( x - tx ) * ( x - tx) + ( y - ty ) * ( y - ty ) ) ;
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Metaball(x, y, radius) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is Metaball )
            {
                return (o as Metaball).radius == (o as Metaball).x == x && (o as Metaball).x == x && (o as Metaball).y == y ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the Object representation of this object.
          * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { radius:radius , x:x , y:y } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new graphics.geom.Metaball(" + dump(x) + "," + dump(y) + "," + dump(radius) + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return "[Metaball x:" + x + " y:" + y + " radius:" + radius + "]" ;
        }
        
        /**
         * @private
         */
        hack var _radius:Number ;
        
        /**
         * @private
         */
        hack var _radiusSquared:Number ;
    }
}