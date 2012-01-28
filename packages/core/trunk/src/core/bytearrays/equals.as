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

package core.bytearrays
{
    import flash.utils.ByteArray;
    
    /**
     * Indicates if two passed-in ByteArray objects are equal.
     * <p>Two ByteArray objects are considered equal if and only if all bytes they contain are equal and in the same order.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.bytearrays.equals ;
     * import flash.utils.ByteArray;
     * 
     * var bytes1:ByteArray = new ByteArray() ;
     * var bytes2:ByteArray = new ByteArray() ;
     * var bytes3:ByteArray = new ByteArray() ;
     * 
     * bytes1.writeUTFBytes("hello") ;
     * bytes2.writeUTFBytes("hello") ;
     * bytes3.writeUTFBytes("world") ;
     * 
     * trace( equals( bytes1 , bytes2 ) ) ; // true
     * trace( equals( bytes1 , bytes3 ) ) ; // false
     * </pre>
     * @param first The first ByteArray to be compared.
     * @param second The second ByteArray to be compared.
     * @return <code class="prettyprint">true</code> if the ByteArray object are equal, <code class="prettyprint">false</code> otherwise.  
     */
    public const equals:Function = function( first:ByteArray , second:ByteArray ):Boolean
    {
        var pos1:uint   = first.position  ;
        var pos2:uint   = second.position ;
        first.position  = 0 ;
        second.position = 0 ;
        if( first.bytesAvailable != second.bytesAvailable )
        {
            first.position  = pos1 ;
            second.position = pos2 ;
            return false;
        }
        while( first.bytesAvailable > 0 )
        {
            if( first.readByte() != second.readByte())
            {
                first.position  = pos1 ;
                second.position = pos2 ;
                return false;
            }
        }
        first.position  = pos1 ;
        second.position = pos2 ;
        return true;
    };
}
