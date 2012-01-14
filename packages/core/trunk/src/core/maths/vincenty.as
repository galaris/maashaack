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

package core.maths
{
    /**
     * Calculates geodesic distance in meter between two points specified by latitude and longitude (in numeric degrees) using the Vincenty inverse formula for ellipsoids.
     * @param latitude1 The first latitude coordinate.
     * @param longitude1 The first longitude coordinate.
     * @param latitude2 The second latitude coordinate.
     * @param longitude2 The second longitude coordinate.
     * @return The distance between two points on a sphere from their longitudes and latitudes.
     */
    public function vincenty( latitude1:Number, longitude1:Number, latitude2:Number, longitude2:Number ):Number
    {
        const a:Number = 6378137;
        const b:Number = 6356752.3142 ;
        const f:Number = 1 / 298.257223563 ; // WGS-84 ellipsoid params
        
        // WGS-84 ellipsiod
        
        var L:Number = (longitude2 - longitude1) * DEG2RAD;
        
        var U1:Number = Math.atan((1 - f) * Math.tan( latitude1 * DEG2RAD ) );
        var U2:Number = Math.atan((1 - f) * Math.tan( latitude2 * DEG2RAD ) );
        
        var sinU1:Number = Math.sin(U1), cosU1:Number = Math.cos(U1);
        var sinU2:Number = Math.sin(U2), cosU2:Number = Math.cos(U2);
        
        var lambda:Number = L ;
        var lambdaP:Number = 2 * Math.PI;
        
        var iterLimit:int = 20;
        
        var cosLambda:Number ;
        var sinLambda:Number ;
        
        var cosSigma:Number ;
        var sinSigma:Number ;
        
        var sigma:Number ;
        
        var sinAlpha:Number ;
        
        var cosSqAlpha:Number ;
        var cos2SigmaM:Number ;
        
        var C:Number ;
        
        do 
        {
            sinLambda = Math.sin( lambda ) ;
            cosLambda = Math.cos( lambda ) ;
            
            sinSigma  = Math.sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) + (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) * (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));
            
            if ( sinSigma == 0 ) 
            {
                return 0 ; // co-incident points
            }
            
            cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda ;
            
            sigma = Math.atan2( sinSigma , cosSigma ) ;
            
            sinAlpha   = cosU1 * cosU2 * sinLambda / sinSigma;
            
            cosSqAlpha = 1 - sinAlpha * sinAlpha;
            
            cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;
            
            if( isNaN( cos2SigmaM ) )
            {
                cos2SigmaM = 0 ; // equatorial line: cosSqAlpha=0 (§6)
            }
            
            C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
            
            lambdaP = lambda;
            
            lambda = L + (1 - C) * f * sinAlpha * (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
        }
        while ( Math.abs(lambda - lambdaP) > 1e-12 && --iterLimit > 0 ) ;
        
        if ( iterLimit == 0 )
        {
            return NaN ; // formula failed to converge
        }
        
        var uSq:Number = cosSqAlpha * (a * a - b * b) / (b * b);
        var A:Number   = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
        var B:Number   = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
        var deltaSigma:Number = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
        
        var s:Number = b * A * ( sigma - deltaSigma ) ;
        
        s = Number(s.toFixed(3)) ; // round to 1mm precision
        
        return s;
    }
}


