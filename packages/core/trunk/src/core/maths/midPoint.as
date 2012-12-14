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

package core.maths
{
    import flash.geom.Point;
    
    /**
     * Calculates the midpoint along a great circle path between the two points. 
     * <p>See <a href="http://mathforum.org/library/drmath/view/51822.html">"Latitude and Longitude of a Point Halfway between Two Points"</a> question to calculate the derivation.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.maths.midPoint ;
     * 
     * var position1:Point = new Point( 37.422045 , -122.084347 ) ; // Google HQ
     * var position2:Point = new Point( 37.77493  , -122.419416 ) ; // San Francisco, CA
     * 
     * var position3:Point = midPoint( position1.x , position1.y , position2.x , position2.y ) ;
     *  
     * trace( "midpoint latitude:" + position3.x + " longitude:" + position3.y ) ; 
     * // midpoint latitude:61.57498891662033 longitude:-175.29648538075753
     * </pre>
     * @param latitude1 The first latitude coordinate.
     * @param longitude1 The first longitude coordinate.
     * @param latitude2 The second latitude coordinate.
     * @param longitude2 The second longitude coordinate.
     * @return The midpoint (Point) along a great circle path between the two points.
     */
    public function midPoint( latitude1:Number, longitude1:Number, latitude2:Number, longitude2:Number ):Point
    {
        latitude1  = latitude1  * DEG2RAD ;
        longitude1 = longitude1 * DEG2RAD ;
        latitude2  = latitude2  * DEG2RAD ;
        
        var dLng:Number = ( longitude2 - longitude1 ) * DEG2RAD ;
        
        var bx:Number = Math.cos( latitude2 ) * Math.cos( dLng );
        var by:Number = Math.sin( latitude2 ) * Math.sin( dLng ) ;
        
        var point:Point = new Point() ;
        
        point.x = Math.atan2( Math.sin( latitude1 ) + Math.sin( latitude2 ), Math.sqrt( ( Math.cos( latitude1 ) + bx ) * ( Math.cos( latitude1 ) + bx ) + by * by ) ) * RAD2DEG ;
        point.y = ( longitude1 + Math.atan2( by , Math.cos( latitude1 ) + bx ) ) * RAD2DEG ;
        
        return point ;
    }
}
