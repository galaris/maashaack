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

package system.data
{
    import system.Cloneable ;
    import system.Serializable ;
    
    /**
     * A collection designed for holding elements prior to processing. 
     * <p>Stacks typically, but do not necessarily, order elements in a LIFO (last-in-first-out) manner.</p>
     */
    public interface Stack extends Cloneable, Iterable, Serializable
    {
        /**
         * Removes all of the elements from this stack (optional operation).
         */
        function clear():void ;
        
        /**
         * Returns <code class="prettyprint">true</code> if this stack contains no elements.
         * @return <code class="prettyprint">true</code> if this stack is empty else <code class="prettyprint">false</code>.
         */
        function isEmpty():Boolean ;
        
        /**
         * Returns the lastly pushed value without removing it.
         * @throws the lastly pushed value.
         */
        function peek():* ;
        
        /**
         * Removes and returns the lastly pushed value.
         * @return the lastly pushed value
         */
        function pop():* ;
        
        /**
         * Pushes the passed-in value to this stack.
         */
        function push(o:*):void ;
        
        /**
         * Search a value in the stack.
         * @return the index position of a value in the stack.
         */
        function search(o:*):int ;
        
        /**
         * Returns the number of pushed values.
         * @return the number of pushed values.
         */
        function size():uint ;
    }
}