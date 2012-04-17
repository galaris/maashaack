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
     * Evaluates if two colors are similar with a specific tolerance ratio between 0 and 1.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.equals ;
     * 
     * trace( equals( 0xFFFFFF , 0x000000 ) ) ; // false
     * trace( equals( 0xFF0000 , 0xFF0000 ) ) ; // true
     * trace( equals( 0xFFFFFF , 0xFFFFFF ) ) ; // true
     * 
     * trace( equals( 0xFFFFFF , 0xFFEEFF ) ) ; // true
     * trace( equals( 0xFFFFFF , 0xFFEEFF , 0 ) ) ; // false
     * trace( equals( 0xFFFFFF , 0xFFEEFF , 1 ) ) ; // true
     * </pre>
     * @param color1 The first numeric color to evaluate.
     * @param color2 The second numeric color to evaluate.
     * @param tolerance The tolerance of the algorythm between 0 and 1.
     * @return <code>true</code> if the two colors are similar.
     */
    public function equals( color1:uint , color2:uint , tolerance:Number = 0.01 ):Boolean
    {
        var dist:Number = Math.pow( (color1 >> 16 & 0xFF) - (color2 >> 16 & 0xFF) , 2 ) 
                            + Math.pow( (color1 >> 8 & 0xFF) - (color2 >> 8 & 0xFF) , 2 ) 
                            + Math.pow( (color1 & 0xFF) - (color2 & 0xFF) , 2 ) ;
        return dist <= ( tolerance * ( 255 * 255 * 3 ) << 0 ) ;
    }
}
