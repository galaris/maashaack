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

package graphics.colors
{
    import system.hack;
    
    use namespace hack ;
    
    /**
     * Transform the specified RGB in this XYZ representation.
     * @return the XYZ representation of the passed-in RGB parameter.
     */
    public const RGB2XYZ:Function = function( rgb:RGB , xyz:XYZ = null ):XYZ
    {
        if ( xyz == null )
        {
            xyz = new XYZ() ;
        }
        
        var r:Number   = rgb._red   / 0xFF ;
        var g:Number   = rgb._green / 0xFF ;
        var b:Number   = rgb._blue  / 0xFF ;
        
        if ( r > 0.04045 ) 
        {
            r = ( ( r + 0.055 ) / 1.055 ) ^ 2.4 ;
        }
        else
        {
            r /= 12.92 ;
        }
        
        if ( g > 0.04045 )
        {
            g = ( ( g + 0.055 ) / 1.055 ) ^ 2.4 ;
        }
        else
        {
            g /= 12.92 ;
        }
        
        if ( b > 0.04045 )
        {
            b = ( ( b + 0.055 ) / 1.055 ) ^ 2.4 ;
        }
        else
        {
            b /= 12.92 ;
        }
        
        r *= 100 ;
        g *= 100 ;
        b *= 100 ;
        
        // Observer. = 2°, Illuminant = D65
        
        xyz.X = r * 0.4124 + g * 0.3576 + b * 0.1805 ;
        xyz.Y = r * 0.2126 + g * 0.7152 + b * 0.0722 ;
        xyz.Z = r * 0.0193 + g * 0.1192 + b * 0.9505 ;
        
        return xyz ;
    };
}
