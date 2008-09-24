/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data
{
    import system.Cloneable;
    import system.Serializable;    

    /**
	 * The root interface in the collection hierarchy. 
	 * <p>A collection represents a group of objects, known as its elements.</p> 
	 * <p>Some collections allow duplicate elements and others do not. Some are ordered and others unordered.</p> 
	 */
    public interface Collection extends Cloneable, Iterable, Serializable
    {
        
        /**
         * Ensures that this collection contains the specified element (optional operation).
         */
        function add( o:* ):Boolean ;        
        
		/**
		 * Removes all of the elements from this collection (optional operation).
		 */
        function clear():void ;

		/**
		 * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
		 * @return <code class="prettyprint">true</code> if this collection contains the specified element.
		 */
    	function contains( o:* ):Boolean ;
	
		/**
		 * Returns the element from this collection at the passed index.
		 * @return the element from this collection at the passed index.
		 */
    	function get( key:* ) :* ;

		/**
		 * Returns the position of the passed object in the collection.
		 * @param o the object to search in the collection.
		 * @param fromIndex the index to begin the search in the collection.
		 * @return the index of the object or -1 if the object isn't find in the collection.
		 */
		function indexOf(o:*, fromIndex:uint=0):int
        
		/**
		 * Returns <code class="prettyprint">true</code> if this collection contains no elements.
		 * @return <code class="prettyprint">true</code> if this collection is empty else <code class="prettyprint">false</code>.
		 */
    	function isEmpty():Boolean ;

		/**
		 * Removes a single instance of the specified element from this collection, if it is present (optional operation).
		 */
    	function remove(o:*):* ;
	
		/**
		 * Returns the number of elements in this collection.
		 * @return the number of elements in this collection.
		 */
    	function size():uint ;
    
    }
}