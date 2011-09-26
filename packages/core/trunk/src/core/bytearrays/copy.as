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

package core.bytearrays
{
    import flash.utils.ByteArray;
    /**
     * This function can copy a ByteArray in a other ByteArray.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.bytearrays.copy ;
     * import core.strings.hexformat ;
     * 
     * import flash.utils.ByteArray;
     * 
     * ////////////
     * 
     * var bytes1:ByteArray ;
     * var bytes2:ByteArray ;
     * 
     * bytes1 = new ByteArray() ;
     * bytes1.writeUTFBytes("hello") ;
     * 
     * bytes2 = copy( bytes1 ) ;
     * 
     * trace( "bytes1:" + hexformat(bytes1) + " position:" + bytes1.position + " length:" + bytes1.length ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * // bytes1:68 65 6c 6c 6f  position:5 length:5
     * // bytes2:68 65 6c 6c 6f  position:5 length:5
     * 
     * trace("---") ;
     * 
     * bytes2 = new ByteArray() ;
     * copy( bytes1 , 0 , bytes2 ) ;
     * 
     * trace( "bytes1:" + hexformat(bytes1) + " position:" + bytes1.position + " length:" + bytes1.length ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * // bytes1:68 65 6c 6c 6f  position:5 length:5
     * // bytes2:68 65 6c 6c 6f  position:5 length:5
     * 
     * trace("---") ;
     * 
     * bytes2 = new ByteArray() ;
     * bytes2.writeUTFBytes("world") ;
     * 
     * trace( "bytes1:" + hexformat(bytes1) + " position:" + bytes1.position + " length:" + bytes1.length ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * copy( bytes1 , 0 , bytes2 ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * // bytes1:68 65 6c 6c 6f  position:5 length:5
     * // bytes2:77 6f 72 6c 64  position:5 length:5
     * // bytes2:77 6f 72 6c 64 68 65 6c 6c 6f  position:10 length:10
     * 
     * trace("---") ;
     * 
     * bytes2 = new ByteArray() ;
     * bytes2.writeUTFBytes("world") ;
     * 
     * trace( "bytes1:" + hexformat(bytes1) + " position:" + bytes1.position + " length:" + bytes1.length ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * copy( bytes1 , 0 , bytes2 , 0) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * // bytes1:68 65 6c 6c 6f  position:5 length:5
     * // bytes2:77 6f 72 6c 64  position:5 length:5
     * // bytes2:68 65 6c 6c 6f  position:5 length:5
     * 
     * trace("---") ;
     * 
     * bytes2 = new ByteArray() ;
     * bytes2.writeUTFBytes("world") ;
     * 
     * trace( "bytes1:" + hexformat(bytes1) + " position:" + bytes1.position + " length:" + bytes1.length ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * copy( bytes1 , 0 , bytes2 , 2 ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * // bytes1:68 65 6c 6c 6f  position:5 length:5
     * // bytes2:77 6f 72 6c 64  position:5 length:5
     * // bytes2:77 6f 68 65 6c 6c 6f  position:7 length:7
     * 
     * trace("---") ;
     * 
     * bytes2 = new ByteArray() ;
     * bytes2.writeUTFBytes("world") ;
     * 
     * trace( "bytes1:" + hexformat(bytes1) + " position:" + bytes1.position + " length:" + bytes1.length ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * copy( bytes1 , 1 , bytes2 , 2 , 2 ) ;
     * trace( "bytes2:" + hexformat(bytes2) + " position:" + bytes2.position + " length:" + bytes2.length ) ;
     * 
     * // bytes1:68 65 6c 6c 6f  position:5 length:5
     * // bytes2:77 6f 72 6c 64  position:5 length:5
     * // bytes2:77 6f 65 6c 6c 6f  position:6 length:6
     * </pre>
     * @param from The ByteArray to copy with the specified offset. 
     * @param fromOffset A zero-based index indicating the position into the array to begin the copy.
     * @param to The destination ByteArray to copy all bytes in the from ByteArray.
     * @param toOffset A zero-based index indicating the position into the array to begin the insert of the from ByteArray.
     */
    public const copy:Function = function( from:ByteArray , fromOffset:uint = 0 , to:ByteArray = null, toOffset:uint = 0, length:uint = 0 ):ByteArray
    {
        if ( from == null )
        {
            throw new ArgumentError( "The core.bytearrays.copy failed if the 'from' ByteArray argument is null." ) ;
        }
        
        if ( to == null )
        {
            to = new ByteArray() ;
        }
        
        var old:uint = from.position ;
        
        from.position = 0 ;
        
        to.position = toOffset ;
        to.writeBytes( from , fromOffset , length ) ;
        
        from.position = old ;
        
        return to ;
    };
}
