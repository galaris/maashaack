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

package system.formatters 
{
    import library.ASTUce.framework.TestCase;

    import system.evaluators.DateEvaluator;
    import system.evaluators.EdenEvaluator;
    import system.evaluators.MathEvaluator;

    public class StringFormatterTest extends TestCase 
    {
        public function StringFormatterTest(name:String = "")
        {
            super(name);
        }
        
        public function testInterface():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            assertTrue( formatter is Formattable ) ;
        }
        
        public function testFormat():void
        {
            var str1:String = "hello {0}";
            var str2:String = "hello {{escape}} world";
            var str3:String = "one {{ escape";
            var str4:String = "one }} escape";
            var str5:String = "say {{{0}}}";
            var str6:String = "say {left}{0}{right}";
            var str7:String = "hello {world}";
            
            var formatter:StringFormatter ;
            
            formatter = new StringFormatter( ["world"] ) ;
            
            assertEquals("hello world"         , formatter.format( str1 ) );
            assertEquals("hello {escape} world", formatter.format( str2 ) );
            
            assertEquals("one { escape"        , formatter.format( str3 ) ) ;
            assertEquals("one } escape"        , formatter.format( str4 ) ) ;
            
            formatter.parameters = ["hello"] ;
            assertEquals( "say {hello}"       , formatter.format( str5 ) );
            
            formatter.parameters = [ {left:"{{{{", right:"}}}}"}, "hello" ] ;
            assertEquals( "say {{{{hello}}}}" , formatter.format( str6 ) );
            
            formatter.parameters = [ { world : "world" } ] ;
            assertEquals( "hello world" , formatter.format( str7 ) );
        }
        
        public function testFormatBigIndexes():void
        {
            var str:String = "hello {0}, {1} {2} {3} ? {4} {5} {6} {7} {8} {9} {10} {11} ? {12} {13} {14} {15} {16} ? {99}";
            
            var formatter:StringFormatter = new StringFormatter() ;
            
            formatter.parameters = 
            [
                "world", "how", "are", "you", "would", "you", "like", "some", "formating", "in", 
                "your", "strings", "and", "maybe", "some", "evaluators", "too", null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, null, 
                null, null, null, null, null, null, null, null, null, "you got it"
            ] ;
            
            assertEquals
            (
                "hello world, how are you ? would you like some formating in your strings ? and maybe some evaluators too ? you got it", 
                formatter.format( str )
            );
            
            formatter.parameters = 
            [
                [
                    "world", "how", "are", "you", "would", "you", "like", "some", "formating", "in", 
                    "your", "strings", "and", "maybe", "some", "evaluators", "too", null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, null, 
                    null, null, null, null, null, null, null, null, null, "you got it"
                ]
            ] ;
            
            assertEquals
            (
                "hello world, how are you ? would you like some formating in your strings ? and maybe some evaluators too ? you got it", 
                formatter.format( str )
            );
        }
        
        public function testFormatOptions():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            
            formatter.parameters = [ "world" ] ;
            assertEquals("hello      world" , formatter.format( "hello {0,10}" ) , "A");
            assertEquals("hello world     " , formatter.format( "hello {0,-10}"   ) , "B");
            assertEquals("hello world_____" , formatter.format( "hello {0,-10:_}" ) , "C");
            
            formatter = new StringFormatter( [ { token:"token" } ] ) ;
            
            assertEquals("my      token" , formatter.format( "my {token,10}" )   , "D" );
            assertEquals("my token     " , formatter.format( "my {token,-10}" )  , "E" );
            assertEquals("my .....token" , formatter.format( "my {token,10:.}" ) , "F" );
        }
        
        public function testFormatMathEvaluators():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            formatter.evaluators = { math: new MathEvaluator(), math2: new MathEvaluator({x:100}) };
            assertEquals("my result is 5"   , formatter.format( "my result is ${2+3}math$" ));
            assertEquals("my result is 5"   , formatter.format( "my result is ${2+3}math,math2$" ));
            assertEquals("my result is 555" , formatter.format( "my result is ${5*x+55}math2$" ));
        }
        
        public function testFormatEdenEvaluators():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            var str1:String               = "my result is ${{a:1,b:2}}$";
            var str2:String               = "my result is ${{a:1,b:2}}eden$";
            var str3:String               = "my result is ${{a:1,b:2}}eden2$";
            
            formatter.evaluators = { eden: new EdenEvaluator(), eden2: new EdenEvaluator(false) };
            
            assertTrue(formatter.format(str1) == "my result is {a:1,b:2}" || formatter.format(str1) == "my result is {b:2,a:1}"); 
            assertTrue( formatter.format(str2) == "my result is {a:1,b:2}" || formatter.format(str2) == "my result is {b:2,a:1}" ); // FP10 hack
            assertEquals("my result is [object Object]", formatter.format(str3));
        }
        
        public function testFormatEvaluatorsParsing():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            
            var str1:String = '${{prop:"{}"}}$';
            
            assertEquals('{prop:"{}"}', formatter.format(str1));
            
            //var str2:String = '${{a:1,b:"}",c:"$",d:"}",e:"$"}}$';
            //var str3:String = "${{a:1,b:\"}\",c:\"$\",d:\"}\",e:\"$\"}}"; //cause infinite loop - fixed
            
            // assertEquals('{b:"}",d:"}",a:1,c:"$",e:"$"}', formatter.format(str1)); // TODO fix problem with FP10
             
            /* TODO:
            try to fix that
            throw an error
            Error: malformed evaluator, could not find [$] after [}].
             */
            //assertEquals( "{b:\"}\",d:\"}\",a:1,c:\"$\",e:\"$\"}", formatter.format( str2 ) ); //throw an error
        }
        
        public function testFormatDateEvaluators():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            var str1:String = "my result is ${new Date(2007,4,22,13,13,13)}eden,date$";
            var str2:String = "my result is ${new Date(2007,4,22,1,2,3)}eden,time$";
            // TODO fix problem with GMT difference : var str3:String = "my result is ${new Date(2007,4,22,13,13,13)}eden$";
            var str4:String = "my result is ${new Date(2007,4,22,13,13,13)}$";
            
            formatter.evaluators = { eden: new EdenEvaluator(false), date: new DateEvaluator(), time: new DateEvaluator("hh 'h' nn 'mn' ss 's'") };
            
            assertEquals("my result is 22.05.2007 13:13:13", formatter.format(str1));
            assertEquals("my result is 01 h 02 mn 03 s", formatter.format(str2));
            // TODO fix problem with GMT difference : assertEquals( "my result is Tue May 22 13:13:13 GMT+0100 2007", Strings.format( str3 ) );
            assertEquals("my result is new Date(2007,4,22,13,13,13)", formatter.format(str4));
        }
        
        public function testFormatAndEvaluators():void
        {
            var formatter:StringFormatter = new StringFormatter() ;
            /* TODO:
            need more tests and more evaluators :p
             */
            var str1:String = "hello {0}, the result is ${sin(0.5)*80/100}math$";
            //var str2:String = "bonjour ${\"le\".toUpperCase();}eden$ monde"; //BUG in eden \"le\".toUpperCase(); should give LE
            var str3:String = "the number is ${0xffff}eden$";
            
            formatter.evaluators = { math: new MathEvaluator(), eden: new EdenEvaluator(false) };
            
            formatter.parameters = ["world"] ;
            
            assertEquals("hello world, the result is 0.3835404308833624", formatter.format(str1));
            
            formatter.parameters = null ;
            //assertEquals( "bonjour LE monde", formatter.format( str2 )  );
            assertEquals("the number is " + (0xffff), formatter.format(str3));
        }
    }
}
