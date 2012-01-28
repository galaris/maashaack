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
     * Returns the YUV representation of the passed-in RGB parameter.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.RGB ;
     * import graphics.colors.RGB2YUV ;
     * import graphics.colors.YUV ;
     * 
     * var rgb:RGB = new RGB(255,0,0)  ;
     * var yuv:YUV = RGB2YUV( rgb ) ; 
     * 
     * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]
     * trace( yuv ) ; // [YUV y:76.24499999999999 u:84.97232 v:255.5]
     * </pre>
     * @param rgb The RGB color to transform.
     * @param yuv The optional YUV reference who contains the transform components.
     * @return the YUV representation of the passed-in RGB parameter.
     */
    public const RGB2YUV:Function = function( rgb:RGB , yuv:YUV = null ):YUV
    {
        var r:Number = rgb.r ;
        var g:Number = rgb.g ;
        var b:Number = rgb.b ;
        
        if ( yuv == null )
        {
            yuv = new YUV() ;
        }
        
        yuv.y = r *  .299000 + g *  .587000 + b *  .114000 ;
        yuv.u = r * -.168736 + g * -.331264 + b *  .500000 + 128 ;
        yuv.v = r *  .500000 + g * -.418688 + b * -.081312 + 128 ;
        
        return yuv ;
    };
}
