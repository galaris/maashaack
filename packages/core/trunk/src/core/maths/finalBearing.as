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
    /**
     * Calculates the final bearing from a specific points to a supplied point, in degrees. For final bearing, simply take the initial bearing from the end point to the start point and reverse it (using θ = (θ+180) % 360).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.maths.finalBearing ;
     * 
     * var position1:Point = new Point( 37.422045 , -122.084347 ) ; // Google HQ
     * var position2:Point = new Point( 37.77493  , -122.419416 ) ; // San Francisco, CA
     * 
     * trace( finalBearing( position1.x , position1.y , position2.x , position2.y ) ) ; // 143.1477743368166
     * </pre>
     * @param latitude1 The first latitude coordinate.
     * @param longitude1 The first longitude coordinate.
     * @param latitude2 The second latitude coordinate.
     * @param longitude2 The second longitude coordinate.
     * @return The final bearing from North in degrees.
     */
    public function finalBearing( latitude1:Number, longitude1:Number, latitude2:Number, longitude2:Number ):Number
    {
        latitude1 = latitude1 * DEG2RAD ;
        latitude2 = latitude2 * DEG2RAD ;
        
        var dLng:Number = ( longitude2 - longitude1 ) * DEG2RAD ;
        
        var y:Number = Math.sin( dLng ) * Math.cos( latitude2 ) ;
        var x:Number = Math.cos( latitude1 ) * Math.sin( latitude2 ) - Math.sin( latitude1 ) * Math.cos( latitude2 ) * Math.cos( dLng ) ;
        
        return ((Math.atan2(y, x)) * RAD2DEG + 180) % 360 ;
    }
}
