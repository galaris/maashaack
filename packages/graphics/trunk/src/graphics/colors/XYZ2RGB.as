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

package graphics.colors
{
    import system.hack;
    
    use namespace hack ;
    
    /**
     * Transform the specified XYZ in this RGB representation (use Observer = 2°, Illuminant = D65).
     * @param xyz The XYZ color to transform.
     * @param rgb The optional RGB object to initialize. If this parameter is null a new RGB object is created.
     * @return the RGB representation of the passed-in XYZ parameter.
     */
    public const XYZ2RGB:Function = function( xyz:XYZ , rgb:RGB = null ):RGB
    {
        if ( rgb == null )
        {
            rgb = new RGB() ;
        }
        
        var x:Number = xyz._x / 100 ; // X from 0 to  95.047
        var y:Number = xyz._y / 100 ; // Y from 0 to 100.000
        var z:Number = xyz._z / 100 ; // Z from 0 to 108.883
        
        var r:Number = x *  3.2406 + y * -1.5372 + z * -0.4986 ;
        var g:Number = x * -0.9689 + y *  1.8758 + z *  0.0415 ;
        var b:Number = x *  0.0557 + y * -0.2040 + z *  1.0570 ;
        
        var diff:Number = 1 / 2.4 ;
        
        if ( r > 0.0031308 )
        {
             r = ( 1.055 * Math.pow( r , diff ) ) - 0.055 ;
        }
        else 
        {
            r *= 12.92 ;
        }
        
        if ( g > 0.0031308 )
        {
            g = ( 1.055 * Math.pow( g , diff ) ) - 0.055 ;
        }
        else
        {
            g *= 12.92 ;
        }
        
        if ( b > 0.0031308 )
        {
            b = ( 1.055 * Math.pow( b , diff ) ) - 0.055 ;
        }
        else
        {
            b *= 12.92 ;
        }
        
        r *= 255 ;
        g *= 255 ;
        b *= 255 ;
        
        rgb.r = r ;
        rgb.g = g ;
        rgb.b = b ;
        
        return rgb ;
    };
}
