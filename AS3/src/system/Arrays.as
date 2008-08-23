/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Marc Alcaraz <ekameleon@gmail.com>

*/
package system
    {
    
    /**
     * A static class for Array utilities.
     */
	public class Arrays
		{
        
        /**
         * Returns whether the Array contains a particular item.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * var ar:Array = [2, 3, 4] ;
         * 
         * trace( Arrays.contains(ar, 3) ) ; // true
         * trace( Arrays.contains(ar, 5) ) ; // false
         * </pre>
         * @param ar The search Array.
         * @param value The value to search.
         * @return whether the Array contains a particular item.
         */
        public static function contains( ar:Array , value:Object):Boolean 
        {
            return ar.indexOf(value) > -1 ;
        }
        
		/**
		 * Initializes a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var test:Array  = Arrays.initialize( 3 ); //define [null,null,null]
		 * var test1:Array = Arrays.initialize( 3, 0 ); //define [0,0,0]
		 * var test2:Array = Arrays.initialize( 3, true ); //define [true,true,true]
		 * var test3:Array = Arrays.initialize( 3, "" ); //define ["","",""]
		 * </pre>
		 * @return a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 */
        public static function initialize( elements:uint = 0, value:* = null ):Array
            {
            var arr:Array = [];
            
            for( var i:int = 0; i<elements; i++ )
                {
                arr.push( value );
                }
            
            return arr;
            }
        
        /**
         * Returns a new Array who contains the specified Array elements repeated count times.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * var ar:Array = [2, 3, 4] ;
         * 
         * trace( Arrays.repeat(ar, 0) ) ; // 2,3,4
         * trace( Arrays.repeat(ar, 3) ) ; // 2,3,4,2,3,4,2,3,4
         * </pre>
         * @return a new Array who contains the specified Array elements repeated count times.
         */
        public static function repeat( ar:Array , count:uint=0 ):Array
        {
            var result:Array = [] ;
            if ( count > 0 )
            {
                for( var i:uint = 0 ; i<count ; i++)
                {
                    result = result.concat(ar) ;
                }
            }
            else
            {
                result = [].concat(ar) ;    
            }
            return  result ;
        }
        
		/** 
		 * Splice one array into another.
		 * Like the python 
		 * <pre class="prettyprint">
  		 * container[containerPosition:containerPosition + countReplaced] = inserted
  		 * </pre>
  		 * @example
		 * <pre class="prettyprint">
  		 * import system.Arrays ;
  		 * 
  		 * var inserted:Array  ;
  		 * var container:Array ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * trace( "inserted  : " + inserted  ) ;
  		 * trace( "container : " + container ) ;
  		 * 
  		 * trace("---") ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 0 ) : " + container ) ; // 1,2,3,4,5,6,7,8
  		 * 
  		 * trace("---") ;
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container, 0 , 4 ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4
  		 * 
  		 * trace("---") ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container, 0 , 2 ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4,7,8
  		 * </pre>
  		 * @param inserted The Array of char inserted in the Array container.
  		 * @param container The container modified in place.
  		 * @param containerPosition The position in the container to inserted the Array of chars.
  		 * @param countReplaced The count value to replaced values.
  		 */
		public static function spliceInto( inserted:Array, container:Array, containerPosition:Number=0 , countReplaced:Number=0 ):void
			{
  			inserted.unshift( containerPosition, isNaN( countReplaced ) ? 0 : countReplaced );
  			
  			try 
  				{
    			container.splice.apply( container, inserted ) ;
  				} 
  			finally 
  				{
    			inserted.splice(0, 2) ;
  				}
			}

        }
    
    }

