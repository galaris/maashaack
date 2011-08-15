
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

package system
{
    import library.ASTUce.framework.*;

    import system.evaluators.DateEvaluator;
    import system.evaluators.EdenEvaluator;
    import system.evaluators.MathEvaluator;

    public class StringsTest extends TestCase
    {

        private var _originalEvaluators:Object;

        public function StringsTest( name:String = "" )
        {
            super(name);
        }

        public function setUp():void
        {
            _originalEvaluators = Strings.evaluators;
        }

        public function tearDown():void
        {
            Strings.evaluators = _originalEvaluators;
        }

        public function testCompare():void
        {
            var str1:String = new String("hello world");
            var str2:String = "hello world";
            var str3:String = "hello worl";
            var str4:String = "HELLO WORLD";
            
            assertEquals(Strings.compare("A", "a", true), 1);
            assertEquals(Strings.compare("a", "A", true), -1);
            assertEquals(Strings.compare(str1, ""), 1);
            assertEquals(Strings.compare("", str1), -1);
            assertEquals(Strings.compare(str1, str2), 0);
            assertEquals(Strings.compare(str2, str3), 1);
            assertEquals(Strings.compare(str3, str2), -1);
            assertEquals(Strings.compare("", ""), 0);
            assertEquals(Strings.compare(str2, str4, true), -1);
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
            
            assertEquals("hello world", Strings.format(str1, "world"));
            assertEquals("hello world", Strings.format(str1, ["world"]));
            
            assertEquals("hello {escape} world", Strings.format(str2, "world"));
            assertEquals("one { escape", Strings.format(str3, "world"));
            assertEquals("one } escape", Strings.format(str4, "world"));
            assertEquals("say {hello}", Strings.format(str5, "hello"));
            assertEquals("say {{{{hello}}}}", Strings.format(str6, {left:"{{{{", right:"}}}}"}, "hello"));
            
            assertEquals("hello world", Strings.format(str7, {world:"world"}));
        }

        public function testFormatBigIndexes():void
        {
            var str1:String = "hello {0}, {1} {2} {3} ? {4} {5} {6} {7} {8} {9} {10} {11} ? {12} {13} {14} {15} {16} ? {99}";
            
            assertEquals("hello world, how are you ? would you like some formating in your strings ? and maybe some evaluators too ? you got it", Strings.format(str1, "world", "how", "are", "you", "would", "you", "like", "some", "formating", "in", "your", "strings", "and", "maybe", "some", "evaluators", "too", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "you got it"));
            
            assertEquals("hello world, how are you ? would you like some formating in your strings ? and maybe some evaluators too ? you got it", Strings.format(str1, ["world",
                                                                                                        "how", "are", "you",
                                                                                                        "would", "you", "like", "some", "formating", "in", "your", "strings",
                                                                                                        "and", "maybe", "some", "evaluators", "too",
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, null, null, null, null, null, null, null, null,
                                                                                                        null, "you got it"]));
        }

        public function testFormatOptions():void
        {
            var str1:String = "hello {0,10}";
            var str2:String = "hello {0,-10}";
            var str3:String = "hello {0,-10:_}";
            var str4:String = "my {token,10}";
            var str5:String = "my {token,-10}";
            var str6:String = "my {token,10:.}";
            
            assertEquals("hello      world", Strings.format(str1, "world"), "A");
            assertEquals("hello world     ", Strings.format(str2, "world"), "B");
            assertEquals("hello world_____", Strings.format(str3, "world"), "C");
            assertEquals("my      token", Strings.format(str4, {token:"token"}), "D");
            assertEquals("my token     ", Strings.format(str5, {token:"token"}), "E");
            assertEquals("my .....token", Strings.format(str6, {token:"token"}), "F");
        }

        public function testFormatMathEvaluators():void
        {
            var str1:String = "my result is ${2+3}math$";
            var str2:String = "my result is ${2+3}math,math2$";
            var str3:String = "my result is ${5*x+55}math2$";
            
            Strings.evaluators = { math: new MathEvaluator(), math2: new MathEvaluator({x:100}) };
            
            assertEquals("my result is 5", Strings.format(str1));
            assertEquals("my result is 5", Strings.format(str2));
            assertEquals("my result is 555", Strings.format(str3));
        }

        public function testFormatEdenEvaluators():void
        {
            var original:Boolean = system.eden.prettyPrinting;
            
            system.eden.prettyPrinting = false;
            
            var str1:String = "my result is ${{a:1,b:2}}$";
            var str2:String = "my result is ${{a:1,b:2}}eden$";
            var str3:String = "my result is ${{a:1,b:2}}eden2$";
            
            Strings.evaluators = { eden: new EdenEvaluator(), eden2: new EdenEvaluator(false) };
                        
            assertTrue(Strings.format(str1) == "my result is {a:1,b:2}" || Strings.format(str1) == "my result is {b:2,a:1}"); // TODO FP10 hack 
            assertTrue( Strings.format(str2) == "my result is {a:1,b:2}" || Strings.format(str2) == "my result is {b:2,a:1}" ); // TODO FP10 hack
            assertEquals("my result is [object Object]", Strings.format(str3));
            
            system.eden.prettyPrinting = original;

        }

        public function testFormatEvaluatorsParsing():void
        {
            var original:Boolean = system.eden.prettyPrinting;
            
            system.eden.prettyPrinting = false;
            
            var str1:String = '${{prop:"{}"}}$';
            
            assertEquals('{prop:"{}"}', Strings.format(str1));
            
            //var str2:String = '${{a:1,b:"}",c:"$",d:"}",e:"$"}}$';
            //var str3:String = "${{a:1,b:\"}\",c:\"$\",d:\"}\",e:\"$\"}}"; //cause infinite loop - fixed
            
            // assertEquals('{b:"}",d:"}",a:1,c:"$",e:"$"}', Strings.format(str1)); // TODO fix problem with FP10
             
            /* TODO:
            try to fix that
            throw an error
            Error: malformed evaluator, could not find [$] after [}].
             */
            //assertEquals( "{b:\"}\",d:\"}\",a:1,c:\"$\",e:\"$\"}", Strings.format( str2 ) ); //throw an error
            system.eden.prettyPrinting = original ;
            
        }

        public function testFormatDateEvaluators():void
        {
            var str1:String = "my result is ${new Date(2007,4,22,13,13,13)}eden,date$";
            var str2:String = "my result is ${new Date(2007,4,22,1,2,3)}eden,time$";
            // TODO fix problem with GMT difference : var str3:String = "my result is ${new Date(2007,4,22,13,13,13)}eden$";
            var str4:String = "my result is ${new Date(2007,4,22,13,13,13)}$";
            
            Strings.evaluators = { eden: new EdenEvaluator(false), date: new DateEvaluator(), time: new DateEvaluator("hh 'h' nn 'mn' ss 's'") };
            
            assertEquals("my result is 22.05.2007 13:13:13", Strings.format(str1));
            assertEquals("my result is 01 h 02 mn 03 s", Strings.format(str2));
            // TODO fix problem with GMT difference : assertEquals( "my result is Tue May 22 13:13:13 GMT+0100 2007", Strings.format( str3 ) );
            assertEquals("my result is new Date(2007,4,22,13,13,13)", Strings.format(str4));
        }

        public function testFormatAndEvaluators():void
        {
            /* TODO:
            need more tests and more evaluators :p
             */
            var str1:String = "hello {0}, the result is ${sin(0.5)*80/100}math$";
            //var str2:String = "bonjour ${\"le\".toUpperCase();}eden$ monde"; //BUG in eden \"le\".toUpperCase(); should give LE
            var str3:String = "the number is ${0xffff}eden$";
            
            Strings.evaluators = { math: new MathEvaluator(), eden: new EdenEvaluator(false) };
            
            assertEquals("hello world, the result is 0.3835404308833624", Strings.format(str1, "world"));
            //assertEquals( "bonjour LE monde", Strings.format( str2 )  );
            assertEquals("the number is " + (0xffff), Strings.format(str3));
        }
        
        public function testEndsWith():void
        {
            assertEquals(true, Strings.endsWith("hello world", "world"));
            assertEquals(true, Strings.endsWith("hello world", "d"));
            assertEquals(true, Strings.endsWith("hello world", ""));
            assertEquals(true, Strings.endsWith("", ""));
            assertEquals(false, Strings.endsWith("", "hello"));
            assertEquals(false, Strings.endsWith("", null));
            assertEquals(false, Strings.endsWith(null, null));
            assertEquals(false, Strings.endsWith(null, ""));
            assertEquals(false, Strings.endsWith(null, "hello"));
        }
        
        public function testStartsWith():void
        {
            assertEquals(true, Strings.startsWith("hello world", "hello"));
            assertEquals(true, Strings.startsWith("hello world", "h"));
            assertEquals(true, Strings.startsWith("hello world", ""));
            assertEquals(true, Strings.startsWith("", ""));
            assertEquals(false, Strings.startsWith("", "hello"));
            assertEquals(false, Strings.startsWith("", null));
            assertEquals(false, Strings.startsWith(null, null));
            assertEquals(false, Strings.startsWith(null, ""));
            assertEquals(false, Strings.startsWith(null, "hello"));
        }
        
        /*
        public function testInsert():void
            {
            assertTrue( false, "not implemented" );
            }
        */
    }
}

