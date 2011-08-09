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
     * Returns the RGB representation of the passed-in YUV parameter.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.RGB ;
     * import graphics.colors.YUV ;
     * import graphics.colors.YUV2RGB ;
     * 
     * var yuv:YUV = new YUV(76.24499999999999,84.97232,255.5)  ;
     * var rgb:RGB = YUV2RGB( yuv ) ;
     * 
     * trace( yuv ) ; // [YUV y:76.24499999999999 u:84.97232 v:255.5]
     * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]
     * </pre>
     * @param yuv The YUV color to transform.
     * @param rgb The optional RGB color to initialize with the YUV color. If this parameter is null a new RGB object is created.
     * @return the RGB representation of the passed-in YUV parameter.
     */
    public const YUV2RGB:Function = function( yuv:YUV , rgb:RGB = null ):RGB
    {
        var y:Number = yuv.y ;
        var u:Number = yuv.u ;
        var v:Number = yuv.v ;
        
        if ( rgb == null )
        {
            rgb = new RGB() ;
        }
        
        rgb.r = y + 1.4075 * (v - 128) ;
        rgb.g = y - 0.3455 * (u - 128) - (0.7169 * (v - 128)) ;
        rgb.b = y + 1.7790 * (u - 128) ;
        
        return rgb ;
    };
}
