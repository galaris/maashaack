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

package system.data
{
    /**
     * An ordered collection (also known as a sequence). The user of this interface has precise control over where in the list each element is inserted. The user can access elements by their integer index (position in the list), and search for elements in the list.
     */
    public interface List extends Collection
    {
        /**
         * Appends all of the elements in the specified collection to the end of this Collection, in the order that they are returned by the specified collection's iterator (optional operation).
         * @return <code class="prettyprint">true</code> if this list changed as a result of the call.
         */
        function addAll( c:Collection ):Boolean ; 
        
        /**
         * Inserts the specified element at the specified position in this list (optional operation).
         */
        function addAt( index:uint , o:* ):void ;
        
        /**
         * Returns <code class="prettyprint">true</code> if this list contains all of the elements of the specified collection.
         * @return <code class="prettyprint">true</code> if this list contains all of the elements of the specified collection.
         */
        function containsAll( c:Collection ):Boolean ;
        
        /**
         * Returns the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
         * @return the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
         */
        function lastIndexOf( o:* , fromIndex:int = 0x7FFFFFFF ):int
        
        /**
         * Removes from this list all the elements that are contained between the specific <code class="prettyprint">id</code> position and the end of this list (optional operation).
         * @param id The index of the element or the first element to remove.
         * @param len The number of elements to remove (default 1).  
         */
        function removeAt( id:uint , len:int = 1 ):* ;
        
        /**
         * Removes from this List all of the elements whose index is between fromIndex, inclusive and toIndex, exclusive. 
         * <p>Shifts any succeeding elements to the left (reduces their index).</p> 
         * <p>This call shortens the list by (toIndex - fromIndex) elements. (If toIndex==fromIndex, this operation has no effect.)</p>
         * @param fromIndex The from index (inclusive) to remove elements in the list.
         * @param toIndex The to index (exclusive) to remove elements in the list.
         */
        function removeRange( fromIndex:uint , toIndex:uint ):* ;
        
        /**
         * Retains only the elements in this list that are contained in the specified collection (optional operation).
         */
        function retainAll( c:Collection ):Boolean ;
        
        /**
         * Replaces the element at the specified position in this list with the specified element (optional operation).
         * @param id index of element to replace.
         * @param o element to be stored at the specified position.
         * @return the element previously at the specified position.
         */
        function set( index:uint , o:* ):* ;
        
        /**
         * Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
         * @return a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
         */
        function subList( fromIndex:uint , toIndex:uint ):List ;
    }
}