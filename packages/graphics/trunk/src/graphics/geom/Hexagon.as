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
    import core.maths.round;
    import graphics.Geometry;
    import system.hack;
    
    /**
     * A regular hexagon is a six-sided regular polygon.
     */
    public class Hexagon implements Geometry 
    {
        use namespace hack ;
        
        /**
         * Creates a new Hexagon instance.
         */
        public function Hexagon( radius:Number = 0 )
        {
            if ( radius == 0 )
            {
                reset() ;
            }
            else
            { 
                this.radius = radius ;
            }
        }
        
        //////////////////////////////////////////////////
        
        /**
         * Indicates the central angle value (in degrees) of the hexagon (60°). 
         */
        public static const centralAngle:uint = RegularPolygon.centralAngle( 6 , true ) ;
        
        /**
         * Indicates the central angle value (in radians) of the hexagon (60 * Math.PI / 180). 
         */
        public static const centralAngleRadians:Number = RegularPolygon.centralAngle( 6 ) ;
        
        /**
         * Indicates the exterior angle value (in degrees) of the hexagon (60°). 
         * To find the exterior angle of a regular hexagon, we use the fact that the exterior angle forms a linear pair with the interior angle, so in general it is given by the formula 180 - interior angle. 
         */
        public static const exteriorAngle:uint = 60 ;
        
        /**
         * Indicates the exterior angle value (in radians) of the hexagon (60 * Math.PI / 180). 
         */
        public static const exteriorAngleRadians:Number = 60 * Math.PI / 180 ;
        
        /**
         * Indicates the interior angle value (in degrees) of the hexagon (120°). 
         * Like any regular polygon, to find the interior angle we use the formula (180n–360)/n . For a hexagon, n=6.
         */
        public static const interiorAngle:uint = 120 ;
        
        /**
         * The number of distinct diagonals (9) possible from all vertices, in general n * (n–3) / 2.
         */
        public static const numDiagonals:uint = 9 ;
        
        /**
         * The number of sides of the polygon (6).
         */
        public static const numSides:uint = 6 ;
        
        /**
         * The number of triangles (4) created by drawing the diagonals from a given vertex. (In general n–2)
         */
        public static const numTriangles:uint = 4 ;
        
        /**
         * The sum (in degrees) of all interior angles of the hexagon (720°). In general 180(n–2) degrees.
         */
        public static const sumInteriorAngle:uint = 720 ;
        
        //////////////////////////////////////////////////
        
        /**
         * The apothem distance of the hexagon (height / 2 ). 
         * The distance of the line segment from the center of a regular polygon perpendicular to a side (i.e. when a regular polygon is broken into triangles, the apothem is the height of one of the triangles whose base is a side of the regular polygon).
         */
        public function get apothem():Number
        {
            return _apothem ;
        }
        
        /**
         * @private
         */
        public function set apothem( value:Number ):void
        {
            _apothem   = value > 0 ? value : 0 ;
            _radius    = RegularPolygon.radiusByApothem( _apothem , numSides ) ;
            _height    = _apothem * 2 ;
            _width     = _radius  * 2 ;
            _side      = _radius ;
            _perimeter = RegularPolygon.perimeter( _radius , numSides ) ;
        }
        
        /**
         * Determinates the height of the hexagon (2 * apothem)
         */
        public function get height():Number
        {
            return _height ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void
        {
            apothem = (value > 0 ? value : 0) / 2 ;
        }
        
        /**
         * The perimeter size of the hexagon.
         */
        public function get perimeter():Number
        {
            return _perimeter ;
        }
        
        /**
         * @private
         */
        public function set perimeter( value:Number ):void
        {
            radius = ( ( value > 0 ) ? value : 0 ) / numSides ;
        }
        
        /**
         * Distance from the center to a vertex.
         */
        public function get radius():Number
        {
            return _radius ;
        }
        
        /**
         * @private
         */
        public function set radius( value:Number ):void
        {
            _radius    = value > 0 ? value : 0 ;
            _apothem   = RegularPolygon.apothemByRadius(_radius, numSides) ;
            _height    = _apothem * 2 ;
            _width     = _radius  * 2 ;
            _side      = _radius ;
            _perimeter = RegularPolygon.perimeter( _radius , numSides ) ;
        }
        
        /**
         * The size of the sides of the regular hexagon.
         */
        public function get side():Number
        {
            return _side ;
        }
        
        /**
         * @private
         */
        public function set side( value:Number ):void
        {
            radius = value ;
        }
        
        /**
         * Determinates the width of the hexagon (2 * radius)
         */
        public function get width():Number
        {
            return _width ;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void
        {
            radius = (value > 0 ? value : 0) / 2 ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Hexagon( _radius ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals(o:*):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is Hexagon )
            {
                return ( o as Hexagon)._radius == _radius ;
            }
            return false ; 
        }
        
        /**
         * Resets all components of the regular hexagon.
         */
        public function reset():void
        {
            _apothem   = 0 ;
            _height    = 0 ;
            _perimeter = 0 ;
            _radius    = 0 ;
            _side      = 0 ;
            _width     = 0 ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            return "new graphics.geom.Hexagon(" + String( _radius ) + ")" ;
        }
        
        /**
         * Returns the String representation of the object.
         * @param floatCount the number of floats of the radius and apothem numeric values in 
         * the string representation (default 2).
         * @return the String representation of the object.
         */
        public function toString( floatCount:uint = 2 ):String
        {
            return "[Hexagon radius:" + round(_radius,floatCount) + " apothem:" + round(_apothem,floatCount) + "]" ;
        }
        
        /**
         * @private
         */
        hack var _apothem:Number ;
        
        /**
         * @private
         */
        hack var _height:Number ;
        
        /**
         * @private
         */
        hack var _perimeter:Number ;
        
        /**
         * @private
         */
        hack var _radius:Number ;
        
        /**
         * @private
         */
        hack var _side:Number ;
        
        /**
         * @private
         */
        hack var _width:Number ;
    }
}
