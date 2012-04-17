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
     * Evaluates a given color to a set of colors and defines if this color is unique.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.isUnique ;
     * 
     * var colors:Vector.<uint> = Vector.<uint>([ 0xFF0000 , 0x00FF00 , 0x0000FF , 0x000000 ]) ;
     * 
     * trace( isUnique( 0xFFFFFF , colors ) ) ; // true
     * trace( isUnique( 0xEEFFFF , colors ) ) ; // true
     * 
     * trace( isUnique( 0xFF0000 , colors ) ) ; // false
     * trace( isUnique( 0xFE0000 , colors ) ) ; // false
     * 
     * trace( isUnique( 0x00FF00 , colors ) ) ; // false
     * trace( isUnique( 0x0000FF , colors ) ) ; // false
     * trace( isUnique( 0x000000 , colors ) ) ; // false
     * </pre>
     * @param color The color to evaluate.
     * @param colors The vector of uint colors to compare the specific color value.
     * @param tolerance The tolerance of the algorythm.
     * @return True is the color is sufficiently unique.
     */
    public function isUnique( color:uint , colors:Vector.<uint> , tolerance:Number = 0.01 ):Boolean
    {
        tolerance = tolerance * ( 255 * 255 * 3 ) << 0 ;
        
        var distance:Number ;
        
        for each( var current:uint in colors )
        {
            distance = Math.pow( (color >> 16 & 0xFF) - (current >> 16 & 0xFF) , 2 ) 
                     + Math.pow( (color >> 8 & 0xFF)  - (current >> 8 & 0xFF)  , 2 ) 
                     + Math.pow( (color & 0xFF)       - (current & 0xFF)       , 2 ) ;
            if( distance <= tolerance ) 
            {
                return false ;
            }
        }
        
        return true ;
    }
}
