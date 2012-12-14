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
     * var pos1:Point = new Point( 34.122222 , 118.4111111 ) ; // LA
     * var pos2:Point = new Point( 40.66972222  , 73.94388889 ) ; // NYC
     * 
     * var result:Point = midPoint( pos1.x , pos1.y , pos2.x , pos2.y )  ;
     * 
     * trace( "midpt latitude:" + result.x + " longitude:" + result.y ) ;
     * // midpt latitude:39.547078603870254 longitude:97.2015133919303
     * </pre>
     * @param latitude1 The first latitude coordinate.
     * @param longitude1 The first longitude coordinate.
     * @param latitude2 The second latitude coordinate.
     * @param longitude2 The second longitude coordinate.
     * @return The midpoint (Point) along a great circle path between the two points.
     */
    public function midPoint( latitude1:Number, longitude1:Number, latitude2:Number, longitude2:Number ):Point
    {
        var dLng:Number = ( longitude2 - longitude1 ) * DEG2RAD ;
        
        latitude1  = latitude1  * DEG2RAD ;
        longitude1 = longitude1 * DEG2RAD ;
        latitude2  = latitude2  * DEG2RAD ;
        
        var bx:Number = Math.cos( latitude2 ) * Math.cos( dLng );
        var by:Number = Math.cos( latitude2 ) * Math.sin( dLng ) ;
        
        var point:Point = new Point() ;
        
        point.x = Math.atan2( Math.sin( latitude1 ) + Math.sin( latitude2 ), Math.sqrt( ( Math.cos( latitude1 ) + bx ) * ( Math.cos( latitude1 ) + bx ) + by * by ) ) * RAD2DEG ;
        point.y = ( longitude1 + Math.atan2( by , Math.cos( latitude1 ) + bx ) ) * RAD2DEG ;
        
        return point ;
    }
}
