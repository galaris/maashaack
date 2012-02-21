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

package core.arrays
{
    /**
     * Rotates an Array in-place. After calling this method, the element at index i will be 
     * the element previously at index (i - n) % array.length, for all values of i between 0 and array.length - 1, inclusive.
     * For example, suppose list comprises [l, o, v, e]. After invoking rotate(array, 1) (or rotate(array, -3)), array will comprise [e,l,o,v].
     * <p><b>Example : </b></p>
     * <pre class="prettyprint">
     * import core.dump ;
     * import core.arrays.rotate ;
     * 
     * var array:Array = ["l","o","v","e"] ;
     * 
     * trace( dump( rotate( array ,  1 ) ) ) ; // ["e","l","o","v"]
     * trace( dump( rotate( array , -1 ) ) ) ; // ["l","o","v","e"]
     * trace( dump( rotate( array , -1 ) ) ) ; // ["o","v","e","l"]
     * trace( dump( rotate( array ,  3 ) ) ) ; // ["v","e","l","o"]
     * </pre>
     * @param ar The array to rotate.
     * @param amount The amount to rotate.
     * @return The rotated Array reference.
     */
    public const rotate:Function = function( ar:Array , amount:int = 1 ):Array
    {
        if ( ar && ar.length > 0 ) 
        {
            amount %= ar.length ;
            if ( amount > 0 ) 
            {
                ar.unshift.apply( ar , ar.splice(-amount, amount ) ) ;
            }
            else if ( amount < 0 ) 
            {
                ar.push.apply( ar , ar.splice(0, -amount ) );
            }
        }
        return ar;
    };
}
