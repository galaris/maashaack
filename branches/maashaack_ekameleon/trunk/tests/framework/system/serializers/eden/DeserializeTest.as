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

package system.serializers.eden
{
    import buRRRn.ASTUce.framework.*;

    import system.Version;
    import system.eden;
    import system.logging.LoggerLevel;
    import system.logging.targets.TraceTarget;
    import system.serializers.eden.samples.BasicClass;
    import system.serializers.eden.samples.CtorNoDefaultValue;

    public class DeserializeTest extends TestCase
    {
        public function DeserializeTest( name:String = "" )
        {
            super(name);
        }
        
        public function testEmpty():void
        {
            assertEquals(undefined, ECMAScript.evaluate(""));
        }
        
        public function testString():void
        {
            assertEquals("hello world", ECMAScript.evaluate("\"hello world\""));
            assertEquals("hello world", ECMAScript.evaluate("\'hello world\'"));
        }
        
        public function testSingleChar():void
        {
            assertEquals(0, ECMAScript.evaluate("0"));
            assertEquals(1, ECMAScript.evaluate("1"));
            assertEquals(2, ECMAScript.evaluate("2"));
            assertEquals(3, ECMAScript.evaluate("3"));
            assertEquals(4, ECMAScript.evaluate("4"));
            assertEquals(5, ECMAScript.evaluate("5"));
            assertEquals(6, ECMAScript.evaluate("6"));
            assertEquals(7, ECMAScript.evaluate("7"));
            assertEquals(8, ECMAScript.evaluate("8"));
            assertEquals(9, ECMAScript.evaluate("9"));
            
            assertEquals(undefined, ECMAScript.evaluate(" "));
            assertEquals(undefined, ECMAScript.evaluate("/"));
        }
        
        public function testPreComment():void
        {
            assertEquals("abc", ECMAScript.evaluate("//test\r\n\"abc\""));
            assertEquals("abc", ECMAScript.evaluate("//test\r\"abc\""));
            assertEquals("abc", ECMAScript.evaluate("//test\n\"abc\""));
            assertEquals("abc", ECMAScript.evaluate("//test\r\n  \t   \"abc\""));
            
            assertEquals("abc", ECMAScript.evaluate("/*test*/\"abc\""));
            assertEquals("abc", ECMAScript.evaluate("/*test*/  \t  \"abc\""));
            assertEquals("abc", ECMAScript.evaluate("  \t   /*test*/\"abc\""));
            assertEquals("abc", ECMAScript.evaluate("  \t\r\n   /*test*/   \r\n\t     \"abc\""));
        }
        
        public function testPostComment():void
        {
            assertEquals("abc", ECMAScript.evaluate("\"abc\"//test\r\n"));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"//test"));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"//test\r"));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"//test\n"));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"//test\r\n  \t   "));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"  \r //test\r\n  \t   "));
            
            assertEquals("abc", ECMAScript.evaluate("\"abc\"/*test*/"));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"/*test*/  \t  "));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"  \t   /*test*/"));
            assertEquals("abc", ECMAScript.evaluate("\"abc\"  \t\r\n   /*test*/   \r\n\t     "));
        }
        
        public function testComments():void
        {
            assertEquals(undefined, ECMAScript.evaluate("//test\r//test2"));
            assertEquals(ECMAScript.comments, "//test\r//test2");
            assertEquals(undefined, ECMAScript.evaluate("/*test*//*test2*/"));
            assertEquals(ECMAScript.comments, "/*test*//*test2*/");
        }
        
        public function testBetweenComments():void
        {
            assertEquals(123, ECMAScript.evaluate("//test\r123//test2"));
            assertEquals(ECMAScript.comments, "//test\r//test2");
            assertEquals("abc", ECMAScript.evaluate("/*test*/\"abc\"/*test2*/"));
            assertEquals(ECMAScript.comments, "/*test*//*test2*/");
        }
        
        public function testBasicKeywords():void
        {
            assertEquals(undefined, ECMAScript.evaluate("undefined"));
            assertEquals(null, ECMAScript.evaluate("null"));
            assertEquals(true, ECMAScript.evaluate("true"));
            assertEquals(false, ECMAScript.evaluate("false"));
            assertEquals(NaN, ECMAScript.evaluate("NaN"));
            assertEquals(Infinity, ECMAScript.evaluate("Infinity"));
            assertEquals(+Infinity, ECMAScript.evaluate("+Infinity"));
            assertEquals(-Infinity, ECMAScript.evaluate("-Infinity"));
        }
        
        public function testLocalKeywords():void
        {
            assertEquals(undefined, ECMAScript.evaluate("x.if.z"));
            
            assertEquals(eden.serialize({x:{y:{z:{}}}}), eden.serialize(ECMAScript.evaluate("x.y.z")));
            assertEquals(eden.serialize({x:{y:{z:123}}}), eden.serialize(ECMAScript.evaluate("x.y.z = 123;")));
            assertEquals(123, ECMAScript.evaluate("x.y.z = 123;").x.y.z);
            
            //assertEquals( eden.serialize( {x:{y:{z:{a:false,b:true}}}} ), eden.serialize( ECMAScript.evaluate( "x.y.z.a = false; x.y.z.b = true;" ) ) );
        }
        
        /* note:
        We can not run this test under ASTUce CLI
        because there must be a problem between DOmain and ApplicationDomain
         */
        /*
        public function testGlobalKeywords():void
        {
                
        assertEquals( system.serializers.eden.config, ECMAScript.evaluate( "system.serializers.eden.config" ) );
        assertEquals( system.serializers.eden.config.authorized, ECMAScript.evaluate( "system.serializers.eden.config.authorized" ) );
        assertEquals( system.serializers.eden.config.compress, ECMAScript.evaluate( "system.serializers.eden.config.compress" ) );
        assertEquals( system.serializers.eden.config, ECMAScript.evaluate( "system.serializers.eden.config" ) );
            
        var original:Boolean = system.serializers.eden.config.verbose;
        var result:* = ECMAScript.evaluate( "system.serializers.eden.config.verbose = " + (!original).toString() + ";" );
        assertEquals( system.serializers.eden.config.verbose, !original );
        assertEquals( !system.serializers.eden.config.verbose, original );
        assertEquals( eden.serialize( {} ), eden.serialize( result ) );
        system.serializers.eden.config.verbose = original;
        }
         */
        public function testObject():void
        {
            var obj1:* = ECMAScript.evaluate("{a:1,b:2,c:3}");
            assertEquals(obj1.a, 1);
            assertEquals(obj1.b, 2);
            assertEquals(obj1.c, 3);
            
            var obj2:* = ECMAScript.evaluate("hello = {a:1,b:2,c:3}; world = {x:0,y:1};");
            assertEquals(obj2.hello.a, 1);
            assertEquals(obj2.hello.b, 2);
            assertEquals(obj2.hello.c, 3);
            assertEquals(obj2.world.x, 0);
            assertEquals(obj2.world.y, 1);
            
            var obj3:* = ECMAScript.evaluate("n = null; t = true; f = false; u = undefined;");
            assertEquals(obj3.n, null);
            assertEquals(obj3.t, true);
            assertEquals(obj3.f, false);
            assertEquals(obj3.u, undefined);
        }
        
        public function testArray():void
        {
            var arr1:* = ECMAScript.evaluate("[1,2,3]");
            assertEquals(eden.serialize([1,2,3]), eden.serialize(arr1));
            
            var arr2:* = ECMAScript.evaluate("test = [1,2,3];");
            assertEquals(eden.serialize({test:[1,2,3]}), eden.serialize(arr2));
            
            var arr3:* = ECMAScript.evaluate(" test.multiline = []; test.multiline[0] = true;");
            assertEquals(eden.serialize({test:{multiline:[true]}}), eden.serialize(arr3));
            
            var arr4:* = ECMAScript.evaluate("multiline = [];\r\nmultiline[0] = 1;\r\nmultiline[1] = 2;\r\nmultiline[2] = 3;\r\n");
            assertEquals(eden.serialize({multiline:[1,2,3]}), eden.serialize(arr4));
        }
        
        public function testScript1():void
        {
            /* TODO:
            #1 - you can not assign a local scope on the RHS, cause infinite loop
            #2 - you can not assign a local scope array index on the RHS, cause infinite loop
            #3 - you can assign a global scope array index on the RHS, no infinite loop, undefined is returned
             */
            var s1:* = "/* test script1 */\r\n";
            s1  += "a = \"hello world\";\r\n";
            s1  += "/*boolean*/ b = true;\r\n";
            s1  += "c = 123456789; //ending comment\r\n";
            s1  += "//starting comment\r\n";
            s1  += "d /*here*/ = null;\r\n";
            s1  += "e = { /*test*/ f:true, g:false };\r\n";
            s1  += "h = 0xFF;\r\n";
            s1  += "i = [ 0, 1, 2 ];\r\n";
            s1  += "i[3] = 3;\r\n"; //use of array indexes on the LHS
            s1  += "j = undefined;"; //missing CRLF
                s1  += "k = NaN\r\n"; //missing ;
                //s1  += "l = ;"; //no assignement
                s1  += "m.o.n.o = \"space\";\r\n";
                s1  += "space = m.o.n.o;"; //fixed: #1
                s1  += "j2 = i[0];\r\n"; //fixed: #2
                s1  += "ext1 = system.serializers.eden.GlobalAccessTest.bool;"; //you can assign a global scope on the RHS
                s1  += "word = system.serializers.eden.GlobalAccessTest.arr[0];";//fixed: #3
                s1  += "system.serializers.eden.GlobalAccessTest.arr[1] = \"eden_deserialize_test\";\r\n"; //you can redefine a value in the global scope
            
            var r1:* = ECMAScript.evaluate( s1 );
            //trace( eden.serialize( r1 ) );
            
            assertEquals( r1.a, "hello world" );
            assertEquals( r1.b, true );
            assertEquals( r1.c, 123456789 );
            assertEquals( r1.d, null );
            assertEquals( r1.e.f, true );
            assertEquals( r1.e.g, false );
            assertEquals( r1.h, 0xFF );
            assertEquals( eden.serialize(r1.i), eden.serialize([0,1,2,3]) );
            assertEquals( r1.j, undefined );
            assertEquals( r1.k, NaN );
            assertEquals( r1.l, undefined );
            assertEquals( r1.m.o.n.o, "space" );
            assertEquals( r1.space, "space" );
            assertEquals( r1.j2, r1.i[0] );
            assertEquals( r1.ext1, system.serializers.eden.GlobalAccessTest.bool );
            assertEquals( r1.word, system.serializers.eden.GlobalAccessTest.arr[0] );
            assertEquals( system.serializers.eden.GlobalAccessTest.arr[1], "eden_deserialize_test" );
            
            //ECMAScript.tracePools();
        }
        
        public function testAssignLocalScopeOnRHS():void
        {
            var s1:* = "\r\n";
                s1  += "m.o.n.o = \"space\";\r\n";
                s1  += "space = m.o.n.o;\r\n";
                s1  += "n.u.m.b.e.r = -123;\r\n";
                s1  += "num = n.u.m.b.e.r;" ;
            
            var r1:* = ECMAScript.evaluate( s1 );
            //trace( eden.serialize( r1 ) );
            
            assertEquals( r1.space, r1.m.o.n.o );
            assertEquals( r1.space, "space" );
            assertEquals( r1.num, r1.n.u.m.b.e.r );
            assertEquals( r1.num, -123 );
        }
        
        public function testAssignLocalScopeArrayIndexOnRHS():void
        {
            var s1:* = "\r\n";
                s1  += "x.y.z = [ 0, 1, 2 ];\r\n";
                s1  += "i = [ 0, 1, 2 ];\r\n";
                s1  += "A = x.y.z[5];\r\n"; //a non-existing array index on RHS will return undefined
                s1  += "x.y.z[5] = true;\r\n"; //a non-existing array index on LHS will define the property
                s1  += "B = x.y.z[5];\r\n";
                s1  += "j = i[0];";
            
            var r1:* = ECMAScript.evaluate( s1 );
            //trace( eden.serialize( r1 ) );
            
            assertEquals( r1.j, r1.i[0] );
            assertEquals( r1.A, undefined );
            assertEquals( r1.B, r1.x.y.z[5] );
            assertEquals( r1.B, true );
        }
        
        public function testNegativeNumberInKeyValue():void
        {
            var s1:* = "\r\n";
                s1  += "{ foo: {bar: -12, foo: 15} };";
            
            var r1:* = ECMAScript.evaluate( s1 );
            //trace( eden.serialize( r1 ) );
            
            var s2:* = "\r\n";
                s2  += "{\r\n";
                s2  += "    foo : \r\n";
                s2  += "    {\r\n";
                s2  += "         bar: -12, // parsing failed with this negative value ?\r\n";
                s2  += "         foo: 15\r\n";
                s2  += "    }\r\n";
                s2  += "}\r\n";
            
            var r2:* = ECMAScript.evaluate( s2 );
            //trace( eden.serialize( r2 ) );
            
            assertEquals( r1.foo.bar, -12 );
            assertEquals( r2.foo.bar, -12 );
        }
        
        public function testFunctionCall():void
        {
            var s1:* = "\r\n";
                s1  += "a = \"123\";\r\n";
                s1  += "b = a.split(\"\");\r\n"; //object method call
                s1  += "c = parseInt( 0xFF );\r\n"; //global function
                s1  += "d = b.concat();\r\n"; //copy
                s1  += "d.push( c.toString(16) );\r\n"; //object method call in function argument
                s1  += "e = d.join( \"-\" );\r\n";
              //s1  += "\r\n";
            
            var r1:* = ECMAScript.evaluate( s1 );
            //trace( eden.serialize( r1 ) );
            
            assertEquals( r1.b[0], "1" );
            assertEquals( r1.b[1], "2" );
            assertEquals( r1.b[2], "3" );
            assertEquals( r1.b.length, 3 );
            
            assertEquals( r1.c, 0xFF );
            
            assertEquals( r1.d[0], "1" );
            assertEquals( r1.d[1], "2" );
            assertEquals( r1.d[2], "3" );
            assertEquals( r1.d[3], "ff" );
            assertEquals( r1.d.length, 4 );
            
            assertEquals( r1.e, "1-2-3-ff" );
        }
        
        public function testFunctionWithSeparators():void
        {
            var result:* ;
            result = ECMAScript.evaluate( "value = parseInt(\r\t0xFF )" );
            assertEquals( result.value , 0xFF );
            result = ECMAScript.evaluate( "parseInt\r(\r\t0xFF\r)" );
            assertEquals( result , 0xFF );
        }
        
        public function testFunctionChainedCall():void
        {
            /* note:
               yep chained call, how nice is that :)
            */
            var r1:* = ECMAScript.evaluate( "a = \"123\"; b = a.split(\"\").join( \"+\" ).split(\"+\").join( \"_\" );" );
            
            assertEquals( r1.b, "1_2_3" );
        }
        
        public function testConstructorInstanciation():void
        {
            var r:* = ECMAScript.evaluate( "a = new system.Version(1,2,3,4);" );
            
            assertEquals( r.a.toString(), "1.2.3.4" );
            assertTrue( r.a is Version );
            assertTrue( r.a.equals( new Version(1,2,3,4) ) );
        }
        
        public function testConstructorWithSeparators():void
        {
            var r:* = ECMAScript.evaluate( "{\r\tarray : new Array\r\t(\r\t\t2,3,4\r\t)\r}" );
            assertEquals( eden.serialize(r) , "{array:[2,3,4]}" ) ;
        }
        
        /* Issue 13
           http://code.google.com/p/edenrr/issues/detail?id=13
        */
        public function testConstructorWithoutDefaultValue():void
        {
            CtorNoDefaultValue; //you HAVE TO force the inclusion of your class
            var r1:* = ECMAScript.evaluate( "a = new system.serializers.eden.samples.CtorNoDefaultValue();" );
            var r2:* = ECMAScript.evaluate( "a = new system.serializers.eden.samples.CtorNoDefaultValue(1);" );
            
            assertUndefined( r1.a );
            assertNotUndefined( r2.a );
            assertEquals( "[object CtorNoDefaultValue]", r2.a.toString() );
            assertTrue( r2.a is CtorNoDefaultValue );
        }
        
        public function testMissingEndSemiColon():void
        {
            BasicClass;
            var r1:* = ECMAScript.evaluate( "a = new system.serializers.eden.samples.BasicClass();" );
            var r2:* = ECMAScript.evaluate( "a = new system.serializers.eden.samples.BasicClass()" );
            var r3:* = ECMAScript.evaluate( "new system.serializers.eden.samples.BasicClass()" );
            var r4:* = ECMAScript.evaluate( "new system.serializers.eden.samples.BasicClass() " );
            
            assertNotUndefined( r1.a );
            assertEquals( "[object BasicClass]", r1.a.toString() );
            
            assertNotUndefined( r2.a );
            assertEquals( "[object BasicClass]", r2.a.toString() );
            
            assertNotUndefined( r3 );
            assertEquals( "[object BasicClass]", r3.toString() );
            
            assertNotUndefined( r4 );
            assertEquals( "[object BasicClass]", r4.toString() );
        }
        
        public function testMissingEndSemiColon2():void
        {
            //error found in ES4a StringsTest
            var r1:Date = ECMAScript.evaluate( "new Date(2007,4,22,13,13,13)" );
            var r2:* = ECMAScript.evaluate( "new Date(2007,4,22,13,13,13 " );
            //var r3:* = ECMAScript.evaluate( "new Date(2007,4,22,13,13,13   )" );
            var r4:* = ECMAScript.evaluate( "new Date(2007,4,22,13,13,13" );
            
            assertTrue( r1 is Date );
            
            // TODO fix problem with GMT difference : assertEquals( 1179835993000, r1.valueOf() );
            
            assertUndefined( r2 );
            
            // TODO fix problem with GMT difference : assertEquals( 1179835993000, r3.valueOf() );
            
            assertUndefined( r4 );
            
        }
        
        /* Issue 14
           http://code.google.com/p/edenrr/issues/detail?id=14
        */
        public function testMissingEndParenthesis():void
        {
            var r1:* = ECMAScript.evaluate("new Date(2007,5,12,22,10,5");
            assertUndefined( r1 );
        }
        
        /* Issue 15
           http://code.google.com/p/edenrr/issues/detail?id=15
        */
        public function testReturnAfterAssignment():void
        {
            var r1:* = ECMAScript.evaluate( "config = \r{ message: \"hello\"}" );
            
            assertEquals( "hello", r1.config.message );
        }
        
        /* Issue 16
           http://code.google.com/p/edenrr/issues/detail?id=16
        */
        public function testIssue16():void
        {
            var r1:* = ECMAScript.evaluate( "config  =  {\r\n    message : \"hello\"\r\n}\r\n\r\nlist  = [\r\n    { name:\"test\" , url:\"http://www.foobar.net\" } , true , \"hello world\"\r\n];" );
            
            assertEquals( "hello", r1.config.message );
            assertEquals( "test", r1.list[0].name );
        }
        
        public function testSecurity():void
        {
            eden.addAuthorized("system.logging.*") ;
            
            var mem:Boolean = config.security ;
            
            config.security = true ;
            
            ArrayAssert.assertEquals( [2,3,4] , eden.deserialize("new Array(2,3,4)") ) ;
            
            var o:* ;
            
            o = eden.deserialize("new system.logging.targets.TraceTarget()") as TraceTarget;
            assertTrue( o != null ) ;
            
            o = eden.deserialize("system.logging.LoggerLevel.DEBUG") as LoggerLevel;
            assertTrue( LoggerLevel.DEBUG.equals(o) ) ;
            
            eden.removeAuthorized("system.logging.*") ;
            
            config.security = mem ;
        }
    }
}

