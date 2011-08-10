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
    import system.Equatable;
    import system.data.Collection;
    import system.data.Set;
    
    /**
     * Defines a collection that counts the number of times an object appears in the collection.
     */
    public interface Bag extends Collection, Equatable
    {
        /**
         * Adds n copies of the given object to the bag and keep a count. 
         */
        function addCopies(o:*, nCopies:uint):Boolean ;
         
        /**
         * Insert all elements represented in the given collection.
         */
        function addAll(c:Collection):Boolean ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the bag contains all elements in the given collection, respecting cardinality.
         * @return <code class="prettyprint">true</code> if the bag contains all elements in the given collection, respecting cardinality.
         */
        function containsAll( c:Collection ):Boolean ;
        
        /**
         * Returns the number of occurrences (cardinality) of the given object currently in the bag.
         * @return the number of occurrences (cardinality) of the given object currently in the bag.
         */
        function getCount( o:* ):uint ;
        
        /**
         * Removes objects from the bag according to their count in the specified collection.
         * @param c the collection to use.
         * @return true if the bag changed.
         */
        function removeAll(c:Collection):Boolean ;
        
        /**
         * Removes a specified number of copies of an object from the bag.
         * @param o the object to remove
         * @param nCopies the number of copies to remove
         * @return true if the bag changed
         */
        function removeCopies(o:*, nCopies:uint):Boolean ; 
        
        /**
         * Removes any members of the bag that are not in the given collection, respecting cardinality.
         */
        function retainAll(c:Collection):Boolean ;
        
        /**
         * Returns the Set of unique members that represent all members in the bag.
         * @return the Set of unique members that represent all members in the bag.
         */
        function uniqueSet():Set ;
    }
}