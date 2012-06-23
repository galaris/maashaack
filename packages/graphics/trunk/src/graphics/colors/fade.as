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
    /**
     * Create a new color with the fading between two rgb numeric colors and a specific ratio.
     * <p><b>Example:</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.fade ;
     * 
     * var container:Sprite = new Sprite() ;
     * 
     * container.x = 20 ;
     * container.y = 20 ;
     * 
     * addChild( container ) ;
     * 
     * var canvas:Graphics = container.graphics ;
     * 
     * var start:uint = 0x00FF00 ;
     * var end:uint   = 0xFF0000 ;
     * 
     * var size:uint = 40 ;
     * 
     * var ratio:Number ;
     * var color:uint ;
     * 
     * for( var i:int = 0 ; i < 10 ; i++ )
     * {
     *     ratio = i/9;
     *     color = fade(start, end, ratio) ;
     *     
     *     canvas.beginFill( color );
     *     canvas.drawRect( i* size , 0 , size , size );
     *     
     *     trace( "#" + color.toString(16).toUpperCase() );
     * }
     * </pre>
     * @param color1 The first color to create the new color.
     * @param color2 The second color to create the new color.
     * @param ratio The value between 0 and 1 to calculate the fading level.
     * @return The fading rgb color value.
     */
    public function fade( color1:uint , color2:uint , ratio:Number = 0 ):uint
    {
        var r:uint = color1 >> 16;
        var g:uint = color1 >> 8 & 0xFF;
        var b:uint = color1 & 0xFF;
        
        r += ( ( color2 >> 16      ) -r ) * ratio ;
        g += ( ( color2 >> 8 & 0xFF) -g ) * ratio ;
        b += ( ( color2      & 0xFF) -b ) * ratio ;
        
        return r<<16 | g<<8 | b ;
    }
}
