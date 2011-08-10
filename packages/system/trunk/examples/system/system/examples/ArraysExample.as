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

package examples 
{
    import system.Arrays;
    import system.eden;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class ArraysExample extends Sprite 
    {
        public function ArraysExample()
        {
            var ar:Array ;
            
            /////////////////////////////////////// debug
            
            Array.prototype.toString = function():String
            {
                return "[" + this.join(",") + "]" ;
            };
            
            /////////////////////////////////////// Arrays.contains
            
            trace("---- Arrays.contains") ;
            
            ar = [2, 3, 4] ;
            
            trace( Arrays.contains(ar, 3) ) ; // true
            trace( Arrays.contains(ar, 5) ) ; // false
            
            ///////////////////////////////////////
            
            trace("---- Arrays.initialize") ;
            
            var test:Array  = Arrays.initialize( 3 );
            trace(test) ; //define [null,null,null]
            trace(eden.serialize(test) ) ;
            
            var test1:Array = Arrays.initialize( 3, 0 );
            trace(test1) ; //define [0,0,0]
            
            var test2:Array = Arrays.initialize( 3, true );
            trace(test2) ; //define [true,true,true]
            
            var test3:Array = Arrays.initialize( 3, "" );
            trace(test3) ; //define ["","",""]
            
            /////////////////////////////////////// Arrays.reduce
            
            trace("---- Arrays.reduce") ;
            
            var result:* ;
            var callback:Function ;
            
            ar = [0,1,2,3,4] ;
            
            callback = function( previousValue:* , currentValue:* , index:int, array:Array ):*
            {
                trace( "previousValue = " + previousValue + ", currentValue = " + currentValue + ", index = " + index ) ;
                return previousValue + currentValue ;
            } ;
            
            result = Arrays.reduce( ar , callback ) ;
            // previousValue = 0, currentValue = 1, index = 1 // First call
            // previousValue = 1, currentValue = 2, index = 2 // Second call
            // previousValue = 3, currentValue = 3, index = 3 // Third call
            // previousValue = 6, currentValue = 4, index = 4 // Fourth call
            trace( "value : " + result ) ;  // value : 10
            
            result = Arrays.reduce( ar , callback , 10 ) ;
            // previousValue = 10, currentValue = 0, index = 0
            // previousValue = 10, currentValue = 1, index = 1
            // previousValue = 11, currentValue = 2, index = 2
            // previousValue = 13, currentValue = 3, index = 3
            // previousValue = 16, currentValue = 4, index = 4
            trace( "value : " + result ) ;  // value : 20
            
            // array is always the object [0,1,2,3,4] upon which reduce was called
            
            trace( "ar : " + ar ) ; // ar : [0,1,2,3,4]
            
            trace("--- Example: Sum up all values within an array") ;
            
            ar = [0, 1, 2, 3] ;
            
            callback = function( a:uint , b:uint , ...args:Array ):*
            { 
                return a + b ; 
            };
            
            result = Arrays.reduce( ar , callback );
            trace("total : " + result ) ; // total == 6
            
            trace("--- Example: Flatten an array of arrays") ;
            
            ar = [[0,1], [2,3], [4,5]] ;
            
            callback = function( a:Array , b:Array , ...args:Array ):* 
            {
              return a.concat( b ) ;
            };
            
            result = Arrays.reduce( ar , callback , [] ) ;
            trace("flattened is " + result ) ; // flattened is [0, 1, 2, 3, 4, 5]
            
            /////////////////////////////////////// Arrays.reduceRight
            
            trace("---- Arrays.reduceRight") ;
            
            ar = [0,1,2,3,4] ;
            
            callback = function( previousValue:* , currentValue:* , index:int, array:Array ):*
            {
                trace( "previousValue = " + previousValue + ", currentValue = " + currentValue + ", index = " + index ) ;
                return previousValue + currentValue ;
            } ;
            
            result = Arrays.reduceRight( ar , callback ) ;
            // previousValue = 4, currentValue = 3, index = 3 // First call
            // previousValue = 7, currentValue = 2, index = 2 // Second call
            // previousValue = 9, currentValue = 1, index = 1 // Third call
            // previousValue = 10, currentValue = 0, index = 0 // Fourth call
            trace( "value : " + result ) ;  // value : 10
            
            result = Arrays.reduceRight( ar , callback , 10 ) ;
            // previousValue = 10, currentValue = 4, index = 4
            // previousValue = 14, currentValue = 3, index = 3
            // previousValue = 17, currentValue = 2, index = 2
            // previousValue = 19, currentValue = 1, index = 1
            // previousValue = 20, currentValue = 0, index = 0
            trace( "value : " + result ) ;  // value : 20
            
            // array is always the object [0,1,2,3,4] upon which reduce was called
            
            trace( "ar : " + ar ) ; // ar : [0,1,2,3,4]
            
            trace("--- Example: Sum up all values within an array") ;
            
            ar = [0, 1, 2, 3] ;
            
            callback = function( a:uint , b:uint , ...args:Array ):*
            { 
                return a + b ; 
            };
            
            result = Arrays.reduceRight( ar , callback );
            trace("total : " + result ) ; // total == 6
            
            trace("--- Example: Flatten an array of arrays") ;
            
            ar = [[0,1], [2,3], [4,5]] ;
            
            callback = function( a:Array , b:Array , ...args:Array ):*
            {
              return a.concat( b ) ;
            };
            
            result = Arrays.reduceRight( ar , callback , [] ) ;
            trace("flattened is " + result ) ; // flattened is [4, 5, 2, 3, 0, 1]
            
            /////////////////////////////////////// Arrays.repeat
            
            trace("---- Arrays.repeat") ;
            
            ar = [2, 3, 4] ;
            
            trace( Arrays.repeat(ar, 0) ) ; // 2,3,4
            trace( Arrays.repeat(ar, 3) ) ; // 2,3,4,2,3,4,2,3,4
            
            /////////////////////////////////////// Arrays.spliceInto
            
            trace("---- Arrays.spliceInto") ;
            
            var inserted:Array  ;
            var container:Array ;
            
            inserted  = [1, 2, 3, 4] ;
            container = [5, 6, 7, 8] ;
            
            trace( "inserted  : " + inserted  ) ;
            trace( "container : " + container ) ;
            
            trace("---") ;
            
            inserted  = [1, 2, 3, 4] ;
            container = [5, 6, 7, 8] ;
            
            Arrays.spliceInto( inserted, container ) ;
            trace( "Arrays.spliceInto( inserted, container, 0 , 0 ) : " + container ) ; // 1,2,3,4,5,6,7,8
            
            trace("---") ;
            inserted  = [1, 2, 3, 4] ;
            container = [5, 6, 7, 8] ;
            
            Arrays.spliceInto( inserted, container, 0 , 4 ) ;
            trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4
            
            trace("---") ;
            
            inserted  = [1, 2, 3, 4] ;
            container = [5, 6, 7, 8] ;
            
            Arrays.spliceInto( inserted, container, 0 , 2 ) ;
            trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4,7,8
        }
    }
}
