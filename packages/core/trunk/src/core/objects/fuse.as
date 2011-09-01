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

package core.objects
{
    /**
     * Copies an array or vector from the specified source (array or vector), beginning at the specified position, to the specified position of the destination object. 
     * A subsequence of array components are copied from the source referenced by src to the destination referenced by dest. 
     * The number of components copied is equal to the length argument. The components at positions srcPos through srcPos+length-1 in the source array are copied into positions 
     * destPos through destPos+length-1, respectively, of the destination object. If the src and dest arguments refer to the same array object, then the copying is performed as 
     * if the components at positions srcPos through srcPos+length-1 were first copied to a temporary object with length components and then the contents of the temporary array were 
     * copied into positions destPos through destPos+length-1 of the destination array.
     * <p>If src is null, then a ArgumentError is thrown and the destination array is not modified.</p>
     * <p>If dest is null, then dest is the src reference.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.dump ;
     * import core.objects.fuse ;
     * 
     * var ar1:Array = [1,2,3,4] ;
     * var ar2:Array = [5,6,7,8] ;
     * 
     * fuse( ar1 , 2 , ar2 , 2 , 2 ) ;
     * 
     * trace( dump( ar2 ) ) ; // [5,6,3,4]
     * </pre>
     * @param src The source array or vector to copy.
     * @param srcPos The starting position in the source array.
     * @param dest The destination array or vector.
     * @param destPos The starting position in the destination data.
     * @param length The number of array elements to be copied.
     */
    public const fuse:Function = function( src:Object , srcPos:int , dest:Object , destPos:int , length:int ) :void
    {
        if ( src == null )
        {
            throw new ArgumentError( "if either src is null." ) ;
        }
        if ( dest == null )
        {
            dest = src ;
        }
        if ( destPos < 0 )
        {
            destPos = dest.length ;
        }
        while (length > 0)
        {
            dest[destPos] = src[srcPos];
            srcPos++;
            destPos++;
            length--;
        }
    };
}
