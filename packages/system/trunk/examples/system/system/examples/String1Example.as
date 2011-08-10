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
    import system.Strings;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public dynamic class String1Example extends Sprite 
    {
        public function String1Example()
        {
            //*
            
            var result:* ;
            
            trace("======= Strings.center") ;
            
            trace( Strings.center("hello world", 0  ) )      ; // hello world
            trace( Strings.center("hello world", 20 ) )      ; //     hello world     
            trace( Strings.center("hello world", 20, "_" ) ) ; // ____hello world_____
            
            trace("======= Strings.repeat") ;
            
            trace( Strings.repeat("hello", 0) ) ; // hello
            trace( Strings.repeat("hello", 3) ) ; // hellohellohello
            
            trace("======= Strings.endsWith") ;
            
            trace( Strings.endsWith( "hello world", "world" ) ) ; // true
            trace( Strings.endsWith( "hello world", "hello" ) ) ; // false
            
            trace("======= Strings.startsWith") ;
            
            trace( Strings.startsWith("hello world", "h") ) ; // true
            trace( Strings.startsWith("hello world", "hello") ) ; // true
            trace( Strings.startsWith("hello world", "a") ) ; // false
            
            trace("======= Strings.format") ;
            
            // indexed from the arguments
            
            result = Strings.format( "hello {1} {0} world", "big", "the" ); 
            trace("> " + result) ; //"hello the big world"
            
            result = Strings.format("Brad's dog has {0,6:#} fleas.", 41) ;
            trace("> " + result) ;
            
            result = Strings.format("Brad's dog has {0,-6} fleas.", 12) ;
            trace("> " + result) ;
            
            result = Strings.format("{3} {2} {1} {0}", "a", "b", "c", "d") ;
            trace("> " + result) ;
            
            // named from an object
            
            result = Strings.format( "hello I'm {name}", {name:"HAL"} );
            trace("> " + result) ; //"hello I'm HAL"
            
            // indexed from an array
            
            var names:Array = ["A","B","C","D"];
            var scores:Array = [16,32,128,1024];
            for( var i:int=0; i<names.length; i++ )
            {
                trace( Strings.format( "{0} scored {1,5}", [names[i], scores[i]] ) );
            }
            // "A scored    16"
            // "B scored    32"
            // "C scored   128"
            // "D scored  1024"
            
            // resolve toString
            var user:Object = {};
            user.toString = function():String { return "john doe"; } ;
            trace( Strings.format( "Who is {0} ?", user ) ) ; //"Who is john doe ?"
            
            var fruits:Array ;
            
            // you can off course reuse the index
            fruits = ["apple", "banana", "pineapple"] ;
            trace( Strings.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}", fruits ) ); // "I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
            
            // indexed from an array + the arguments
            fruits = ["apple", "banana", "pineapple"];
            trace( Strings.format( "fruits: {0}, {1}, {2}, {3}, {4}", fruits, "grape", "tomato" ) ); //"fruits: apple, banana, pineapple, grape, tomato"
            
            // passing reference and padding
            var what:String = "answer" ;
            result = Strings.format( "your {0} is within {answer,20:.}", {answer:"my answer"}, what ) ; 
            trace( result ) ; // "your answer is within ...........my answer"
            
            trace("======= Strings.indexOfAny") ;
            
            trace( Strings.indexOfAny("hello world", [2, "hello", 5]) ) ; // 0
            trace( Strings.indexOfAny("Five 5 = 5 and not 2" , [2, "hello", 5]) ) ; // 19
            trace( Strings.indexOfAny("Five 5 = 5 and not 2" , [5, "hello", 2] ) ) ; // 5
            trace( Strings.indexOfAny("Five 5 = 5 and not 2" , [5, "hello", 2] , 6 ) ) ; // 9 
            trace( Strings.indexOfAny("Five 5 = 5 and not 2" , [5, "hello", 2] , 6 , 2 ) ) ; // -1
            trace( Strings.indexOfAny("actionscript is good" , [5, "hello", 2]) ) ; // -1
            
            trace("======= Strings.insert") ;
            
            result = Strings.insert("hello", 0, "a" ) ;  // ahello
            trace(result) ;
            
            result = Strings.insert("hello", -1, "a" ) ; // ahello
            trace(result) ;
            
            result = Strings.insert("hello", 10, "a" ) ; // helloa
            trace(result) ;
            
            result = Strings.insert("hello", 1, "a" ) ;  // haello
            trace(result) ;
            
            trace("======= Strings.padLeft") ;
            
            result = Strings.padLeft("hello", 8) ;
            trace(result) ; //  "   hello"
            
            result = Strings.padLeft("hello", 8, ".") ;
            trace(result) ; //  "...hello" 
            
            trace("======= Strings.padRight") ;
            
            result = Strings.padRight("hello", 8) ;
            trace(result) ; //  "hello   "
            
            result = Strings.padRight("hello", 8, ".") ;
            trace(result) ; //  "hello..." 
            
            trace("======= Strings.startsWith") ;
            
            trace( Strings.startsWith("hello world", "h") ) ; // true
            trace( Strings.startsWith("hello world", "hello") ) ; // true
            trace( Strings.startsWith("hello world", "a") ) ; // false
            //*/
        }
    }
}
