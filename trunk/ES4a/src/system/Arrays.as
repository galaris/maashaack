
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
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system
    {
    
    public class Arrays
        {
        
        public function Arrays()
            {
            }
        
        /* Method: initialize
           Initializes a new Array with an arbitrary number of elements (index),
           with every element containing the passed parameter value or
           by default the null value.
           
           example:
           (code)
           test  = Arrays.initialize( 3 ); //define [null,null,null]
           test1 = Arrays.initialize( 3, 0 ); //define [0,0,0]
           test2 = Arrays.initialize( 3, true ); //define [true,true,true]
           test3 = Arrays.initialize( 3, "" ); //define ["","",""]
           (end)
        */
        public static function initialize( elements:int = 0, value:* = null ):Array
            {
            var arr:Array = [];
            
            for( var i:int = 0; i<elements; i++ )
                {
                arr.push( value );
                }
            
            return arr;
            }
        
        /* TODO:
           - method inserInto (Python inspired), implement also a ProxyArray class where we can access Array indexes like in Python (flash_proxy)
           - method reduce, see: http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Objects:Array:reduce
           - some methods for sorting Arrays
        */
        
        }
    
    }

