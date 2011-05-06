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
    import system.evaluators.DateEvaluator;
    import system.evaluators.EdenEvaluator;
    import system.evaluators.MathEvaluator;
    import system.formatters.StringFormatter;

    import flash.display.Sprite;

    public class StringFormatterExample extends Sprite 
    {
        public function StringFormatterExample()
        {
            var formatter:StringFormatter = new StringFormatter() ;
            
            // indexed from the arguments
            
            formatter.parameters = ["big", "the"] ;
            trace( formatter.format( "hello {1} {0} world" ) ) ; //"hello the big world"
            
            formatter.parameters = [41] ;
            trace( formatter.format( "Brad's dog has {0,6:#} fleas." )  ) ;
            
            formatter.parameters = [12] ;
            trace( formatter.format( "Brad's dog has {0,-6} fleas." ) ) ;
            
            formatter.parameters = ["a", "b", "c", "d"] ;
            trace( formatter.format( "{3} {2} {1} {0}" ) ) ;
            
            // named from an object
            
            formatter.parameters = [ { name : "HAL" } ] ; 
            trace( formatter.format( "hello I'm {name}" ) ) ; //"hello I'm HAL"
            
            // indexed from an array
            
            var names:Array = ["A","B","C","D"];
            var scores:Array = [16,32,128,1024];
            for( var i:int=0; i<names.length; i++ )
            {
                formatter.parameters = [ names[i], scores[i] ] ;
                trace( formatter.format( "{0} scored {1,5}" ) );
            }
            // "A scored    16"
            // "B scored    32"
            // "C scored   128"
            // "D scored  1024"
            
            // resolve toString
            var x:Object = {};
            x.toString = function():String { return "john doe"; } ;
            
            formatter.parameters = [ x ] ;
            trace( formatter.format( "Who is {0} ?" ) ) ; //"Who is john doe ?"
            
            // you can off course reuse the index
            formatter.parameters = ["apple", "banana", "pineapple"] ;
            trace( formatter.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}" ) ); // "I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
            
            // indexed from an array + the arguments
            formatter.parameters = [ ["apple", "banana", "pineapple"] , "grape", "tomato" ];
            trace( formatter.format( "fruits: {0}, {1}, {2}, {3}, {4}" ) ); //"fruits: apple, banana, pineapple, grape, tomato
            
            // passing reference and padding
            
            var what:String = "answer" ;
            formatter.parameters = [ {answer:"my answer"} , what  ] ;
            trace( formatter.format( "your {0} is within {answer,20:.}" ) ) ; // "your answer is within ...........my answer"
            
            // using evaluated parameters
            formatter.parameters = null ;
            formatter.evaluators = { math: new MathEvaluator() };
            trace( formatter.format( "my result is ${2+3}math$" ) ) ; // "my result is 5"
            
            //by default evaluated parameters use EdenEvaluator with serialized result
            formatter.parameters = null ;
            formatter.evaluators = null ;
            trace( formatter.format( "here some object '${ {a:1,b:2} }$'" ) ) ; //"here some object '{a:1,b:2}'"
            
            //use EdenEvaluator with stringified result
            formatter.parameters = null ;
            formatter.evaluators = { math: new EdenEvaluator(false) };
            trace( formatter.format( "here some object '${ {a:1,b:2} }eden$'" ) ) ; //"here some object '[object Object]'"
            trace( formatter.format( "the host is ${system.Environment.host}eden$" ) ); //"the host is Flash 9.0.115.0"
            
            //use chained evaluators
            formatter.parameters = null ;
            formatter.evaluators = { eden: new EdenEvaluator(false), date: new DateEvaluator() } ;
            trace( formatter.format( "my date is ${new Date(2007,4,22,13,13,13)}eden,date$" ) ) ; //"my date is 22.05.2007 13:13:13"
        }
    }
}
