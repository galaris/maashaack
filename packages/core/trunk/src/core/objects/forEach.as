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

package core.objects
{
    /**
     * Executes a function on each item in the object. Each invocation of iterator is called with three arguments: (value, key, ref).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.objects.each ;
     *
     * var object:Object = { one:1 , two:2 , three:3 , four:4 , five:5 } ;
     * 
     * var action:Function = function( value:* , key:* , ref:Object ):uint
     * {
     *     trace( "key:" + key + " value:" + value ) ;
     *     return uint(value) ;
     * }
     * 
     * forEach( object , action ) ;
     * 
     * trace( "----" ) ;
     * 
     * forEach( object , action, null, 3 ) ;
     * 
     * trace( "----" ) ;
     * 
     * forEach( [1,2,3,4] , action ) ; // use the Array.forEach method over Array objects.
     * </pre>
     * <p><b>output :</b></p>
     * <pre class="prettyprint">
     * key:two value:2
     * key:five value:5
     * key:three value:3
     * key:one value:1
     * key:four value:4
     * ----
     * key:two value:2
     * key:five value:5
     * key:three value:3
     * ----
     * key:0 value:1
     * key:1 value:2
     * key:2 value:3
     * key:3 value:4
     * </pre>
     * @param object The reference of the object to enumerate.
     * @param callback The function to run on each item in the object. This function can contain a simple command (for example, a trace() statement) 
     * or a more complex operation, and is invoked with three arguments; the value of an item, the key of an item, and the object reference : <code>function callback(item:*, key:*, ref:Object):void;</code>.
     * @param context An object to use as this for the callback function.
     * @param An optional breaker value to stop the enumeration. If this argument is null the behaviour is forgotten.
     */
    public const forEach:Function = function( object:Object , callback:Function , context:Object = null , breaker:* = null ):void 
    {
        if( object == null )
        {
            return ;
        }
        if( "forEach" in object && object["forEach"] is Function )
        {
            object[forEach]( callback , context ) ;
        }
        else
        {
            for (var key:String in object) 
            {
                if( breaker !== null )
                {
                    if ( callback.call( context , object[key] , key , object ) === breaker) 
                    {
                        return;
                    }
                }
                else
                {
                     callback.call( context , object[key] , key , object ) ;
                }
            }
        }
    };
}
