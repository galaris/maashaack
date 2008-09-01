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
    import system.data.iterator.Iterable;    

    /**
	 * A collection designed for holding elements prior to processing. Besides basic Collection operations, queues provide additional insertion, extraction, and inspection operations.
	 * <p>Queues typically, but do not necessarily, order elements in a FIFO (first-in-first-out) manner.</p>
	 * <p>Whatever the ordering used, the head of the queue is that element which would be removed by a call to remove() or poll().</p>
	 */
    public interface Queue extends Cloneable, Iterable, Serializable
    {
    	
		/**
		 * Removes all of the elements from this queue (optional operation).
		 */
    	function clear():void ;
	
		/**
		 * Returns <code class="prettyprint">true</code> if the queue contains value.
		 * @return <code class="prettyprint">true</code> if the queue contains value.
		 */
    	function contains(o:*):Boolean ;
    	
        /**
         * Retrieves and removes the head of this queue.
         */
    	function dequeue():Boolean ;

	    /**
	     * Retrieves, but does not remove, the head of this queue.
	     */
    	function element():* ;
    	
	    /**
	     * Inserts the specified element into this queue, if possible.
	     */
    	function enqueue(o:*):Boolean ;

        /**
         * Returns <code class="prettyprint">true</code> if the queue is empty.
         * @return <code class="prettyprint">true</code> if the queue is empty.
         */
    	function isEmpty():Boolean ;

        /**
         * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
         */
    	function peek():* ;
	
	    /**
	     * Retrieves and removes the head of this queue.
	     */
    	function poll():* ;
	
	    /**
	     * Retrieves the size of the queue.
	     */
    	function size():uint ;
	
	    /**
	     * Retrieves an Array representation of the queue.
	     */
    	function toArray():Array ;
    }
}

