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

package system.data.stacks 
{
    import system.data.Stack;
    import system.data.collections.ArrayCollection;
    
    /**
     * The based implementation of the Stack interface. 
     * The Stack interface represents a last-in-first-out (LIFO) stack of objects.
     * <pre class="prettyprint">
     * import system.data.stacks.ArrayStack ;
     * 
     * var stack:ArrayStack = new ArrayStack(["item1", "item2"]) ;
     * 
     * stack.push("item3") ;
     * 
     * trace("toSource : " + stack.toSource()) ;
     * trace("pop      : " + stack.pop()) ;
     * trace("stack    : " + stack) ;
     * </pre>
     */
    public class ArrayStack extends ArrayCollection implements Stack
    {
        /**
         * Creates a new SimpleStack instance.
         * @param init An optional Array or Collection to fill the collection.
         */
        public function ArrayStack( init:* = null )
        {
            super( init );
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():* 
        {
            return new ArrayStack( toArray() ) ;
        }
        
        /**
         * Looks at the object at the top of this stack without removing it from the stack.
         */
        public function peek():* 
        {
            return _a[_a.length - 1] ;
        }
        
        /**
         * Removes the object at the top of this stack and returns that object as the value of this function.
         * @return the removed object value.
         */
        public function pop():*
        {
            return isEmpty() ? null : _a.pop() ;
        }
        
        /**
         * Pushes an item into the top of this stack.
         */
        public function push( o:* ):void
        {
            _a.push( o ) ;
        }
        
        /**
         * Returns the index of an element in the Stack.
         * @return the index of an element in the Stack.
         */
        public function search(o:*):int
        {
            return indexOf(o) ;
        }
    }
}
