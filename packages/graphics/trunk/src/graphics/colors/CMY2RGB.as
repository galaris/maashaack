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
    /**
     * Returns the RGB representation of the specified CMY object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.CMY ;
     * import graphics.colors.CMY2RGB ;
     * import graphics.colors.RGB ;
     * 
     * var cmy:CMY = new CMY( 0 , 1 , 1 ) ;
     * var rgb:RGB = CMY2RGB( cmy ) ;
     * 
     * trace( rgb ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]
     * </pre>
     * @return the RGB representation of the specified CMY object.
     */
    public const CMY2RGB:Function = function( cmy:CMY , rgb:RGB = null ):RGB
    {
        if ( rgb == null )
        {
            rgb = new RGB() ;
        }
        
        rgb.r = ( 1 - cmy.c ) * 0xFF ;
        rgb.g = ( 1 - cmy.m ) * 0xFF ;
        rgb.b = ( 1 - cmy.y ) * 0xFF ;
        
        return rgb ;
    };
}
