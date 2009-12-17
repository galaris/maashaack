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

package graphics.geom 
{
    /**
     * A hexagon is a six-sided regular polygon.
     */
    public class Hexagon implements Geometry 
    {
        /**
         * Creates a new Hexagon instance.
         */
        public function Hexagon()
        {
            
        }
        
        //////////////////////////////////////////////////
        
        /**
         * Indicates the exterior angle value (in degrees) of the hexagon (60°). 
         * To find the exterior angle of a regular hexagon, we use the fact that the exterior angle forms a linear pair with the interior angle, so in general it is given by the formula 180 - interior angle. 
         */
        public static const exteriorAngle:uint = 60 ;
        
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
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Hexagon() ;
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
                // FIXME  
            }
            return false ; 
        }
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            return "new graphics.geom.Hexagon()" ;
        }
    }
}
