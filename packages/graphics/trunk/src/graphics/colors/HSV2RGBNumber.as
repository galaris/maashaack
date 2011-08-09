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
     * Returns the rgb number representation of the passed-in HSV color.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.HSV ;
     * import graphics.colors.HSV2RGBNumber ;
     * 
     * var hsv:HSV    = new HSV( 0 , 1 , 1 ) ;
     * var rgb:Number = HSV2RGBNumber( hsl ) ; 
     * 
     * trace( rgb ) ; // 0xFF0000
     * </pre>
     * @return the rgb number representation of the passed-in HSV color.
     */
    public const HSV2RGBNumber:Function = function( hsv:HSV ):Number
    {
        var r:Number = 0 ;
        var g:Number = 0 ;
        var b:Number = 0 ;
        if ( hsv._s == 0 )
        {
            r = hsv._v ;
            g = hsv._v ;
            b = hsv._v ; 
        }
        else
        {
            var hi:uint  = ( hsv._h / 60 ) % 6 ;
            var f:Number = hsv._h / 60 - hi ;
            var p:Number = hsv._v * (1 - hsv._s) ;
            var q:Number = hsv._v * (1 - hsv._s * f ) ;
            var t:Number = hsv._v * (1 - hsv._s * (1 - f) ) ;
            switch( hi )
            {
                case 0 :
                {
                    r = hsv._v ;
                    g = t ;
                    b = p ;
                    break;
                }
                case 1 :
                {
                    r = q ;
                    g = hsv._v ;
                    b = p ;
                    break;
                }
                case 2 :
                {
                    r = p ;
                    g = hsv._v ;
                    b = t ;
                    break;
                }
                case 3 :
                {
                    r = p ;
                    g = q ;
                    b = hsv._v ;
                    break;
                }
                case 4 :
                {
                    r = t ;
                    g = p ;
                    b = hsv._v ;
                    break;
                }
                case 5 :
                {
                    r = hsv._v ;
                    g = p ;
                    b = q ;
                    break;
                }
             } 
        }
        r *= 0xFF ;
        g *= 0xFF ;
        b *= 0xFF ;
        return ( r << 16 ) | ( g << 8 ) | b ;
    };
}
