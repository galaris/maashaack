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

package system.data.sets 
{
    import system.data.Set;
    import system.data.collections.TypedCollection;
    
    /**
     * TypedCollection is a wrapper for Collection instances that ensures that only values of a specific type can be added to the wrapped collection.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.sets.ArraySet ;
     * import system.data.sets.TypedSet ;
     * 
     * var co:ArraySet = new ArraySet(["item1", "item2"]) ;
     * var ts:TypedSet = new TypedSet( String , co ) ;
     * 
     * ts.add( "item3" ) ;
     * trace( ts ) ; // {item1,item2,item3}
     * 
     * try
     * {
     *     ts.add( 10 ) ;
     * }
     * catch( e:Error )
     * {
     *     trace( e.message ) ; // TypedSet.validate(10) is mismatch.
     * }
     * </pre>
     */
    public class TypedSet extends TypedCollection implements Set
    {
        /**
         * Creates a new TypedSet instance.
         * @param type the type of this Typeable object (a Class or a Function).
         * @param set The Collection reference of this wrapper.
         * @throws ArgumentError if the type is null or undefined.
         * @throws TypeError if a value in the passed-in Collection object isn't valid.
         */ 
        public function TypedSet( type:* , s:Set )
        {
            super( type , s ) ;
        }
        
        /**
         * Returns a shallow copy of this collection.
         * @return a shallow copy of this collection.
         */
        public override function clone():*
        {
            return new TypedSet( type , _co as Set ) ;
        }
    }
}
