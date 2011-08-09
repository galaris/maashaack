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
     * Returns the HSL representation of the passed-in RGB parameter.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.HSL ;
     * import graphics.colors.RGB ;
     * import graphics.colors.RBG2HSL ;
     * 
     * var rgb:RGB = new RGB(255,0,0)  ;
     * var hsl:HSL = RGB2HSL( rgb ) ; 
     * 
     * trace( hsl ) ; // [HSL h:0 s:1 l:0.5]
     * </pre>
     * @param rgb The RGB color to transform.
     * @param hsl The optional HSL object to initialize. If this argument is null a new HSL instance is created.
     * @return the HSL representation of the passed-in RGB parameter.
     */
    public const RGB2HSL:Function = function( rgb:RGB , hsl:HSL = null ):HSL
    {
        if ( hsl == null )
        {
            hsl = new HSL() ;
        }
        
        var r:Number = rgb._red   / 0xFF ;
        var g:Number = rgb._green / 0xFF ;
        var b:Number = rgb._blue  / 0xFF ;
        
        var max:Number = Math.max( r, g, b );
        var min:Number = Math.min( r, g, b );
        
        var d:Number = (max + min) / 2 ; 
        
        hsl.h = d ;
        hsl.s = d ;
        hsl.l = d ;
         
        if ( max == min ) // achromatic
        {
            hsl.h = 0 ;
            hsl.s = 0 ;
            hsl.l = 0 ;
        }
        else
        {
            d = max - min;
            hsl.s = ( hsl.l > 0.5 ) ? d / (2 - max - min) : d / (max + min) ;
            switch(max)
            {
                case r : 
                {
                    hsl.h = (g - b) / d + (g < b ? 6 : 0) ; 
                    break ;
                }
                case g : 
                {
                    hsl.h = (b - r) / d + 2 ;
                    break ;
                }
                case b : 
                {
                    hsl.h = (r - g) / d + 4 ;
                    break ;
                }
            }
            hsl.h /= 6  ;
            hsl.h *= 360 ;
        }
        
        return hsl ;
    };
}
