
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
    import buRRRn.ASTUce.framework.*;
    
    import system.Strings;
    
    public class StringsTest extends TestCase
        {
        
        public function StringsTest( name:String="" )
            {
            super( name );
            }
        
        public function testCompare():void
            {
            var str1:String = new String("hello world");
            var str2:String = "hello world";
            var str3:String = "hello worl";
            var str4:String = "HELLO WORLD";
            
            assertEquals( Strings.compare( "A", "a", true ),  1 );
            assertEquals( Strings.compare( "a", "A", true ), -1 );
            assertEquals( Strings.compare( str1, "" ),  1 );
            assertEquals( Strings.compare( "", str1 ), -1 );
            assertEquals( Strings.compare( str1, str2 ),  0 );
            assertEquals( Strings.compare( str2, str3 ),  1 );
            assertEquals( Strings.compare( str3, str2 ), -1 );
            assertEquals( Strings.compare( "", "" ),  0 );
            assertEquals( Strings.compare( str2, str4, true ),  -1 );
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
            
            assertEquals( "hello world", Strings.format( str1, "world" ) );
            assertEquals( "hello world", Strings.format( str1, ["world"] ) );
            
            assertEquals( "hello {escape} world", Strings.format( str2, "world" ) );
            assertEquals( "one { escape", Strings.format( str3, "world" ) );
            assertEquals( "one } escape", Strings.format( str4, "world" ) );
            assertEquals( "say {hello}", Strings.format( str5, "hello" ) );
            assertEquals( "say {{{{hello}}}}", Strings.format( str6, {left:"{{{{", right:"}}}}"}, "hello" ) );
            
            assertEquals( "hello world", Strings.format( str7, {world:"world"} ) );
            
            }
        
        public function testFormatOptions():void
            {
            var str1:String = "hello {0,10}";
            var str2:String = "hello {0,-10}";
            var str3:String = "hello {0,-10:_}";
            var str4:String = "my {token,10}";
            var str5:String = "my {token,-10}";
            var str6:String = "my {token,10:.}";
            
            assertEquals( "hello      world", Strings.format( str1, "world" ), "A" );
            assertEquals( "hello world     ", Strings.format( str2, "world" ), "B" );
            assertEquals( "hello world_____", Strings.format( str3, "world" ), "C" );
            assertEquals( "my      token", Strings.format( str4, {token:"token"} ), "D" );
            assertEquals( "my token     ", Strings.format( str5, {token:"token"} ), "E" );
            assertEquals( "my .....token", Strings.format( str6, {token:"token"} ), "F" );
            }
        
        public function testEndsWith():void
            {
            assertEquals( true, Strings.endsWith( "hello world", "world" ) );
            assertEquals( true, Strings.endsWith( "hello world", "d" ) );
            assertEquals( true, Strings.endsWith( "hello world", "" ) );
            assertEquals( true, Strings.endsWith( "", "" ) );
            assertEquals( false, Strings.endsWith( "", "hello" ) );
            assertEquals( false, Strings.endsWith( "", null ) );
            assertEquals( false, Strings.endsWith( null, null ) );
            assertEquals( false, Strings.endsWith( null, "" ) );
            assertEquals( false, Strings.endsWith( null, "hello" ) );
            }
        
        public function testStartsWith():void
            {
            assertEquals( true, Strings.startsWith( "hello world", "hello" ) );
            assertEquals( true, Strings.startsWith( "hello world", "h" ) );
            assertEquals( true, Strings.startsWith( "hello world", "" ) );
            assertEquals( true, Strings.startsWith( "", "" ) );
            assertEquals( false, Strings.startsWith( "", "hello" ) );
            assertEquals( false, Strings.startsWith( "", null ) );
            assertEquals( false, Strings.startsWith( null, null ) );
            assertEquals( false, Strings.startsWith( null, "" ) );
            assertEquals( false, Strings.startsWith( null, "hello" ) );
            }
        
        public function testPadLeft():void
            {
            assertEquals( "   hello", Strings.padLeft( "hello", 8 ) );
            assertEquals( "...hello", Strings.padLeft( "hello", 8, "." ) );
            assertEquals( "hello___", Strings.padLeft( "hello", -8, "_" ) );
            assertEquals( "***hello", Strings.padLeft( "hello", 8, "*.!" ) );
            }
        
        public function testPadRight():void
            {
            assertEquals( "hello   ", Strings.padRight( "hello", 8 ) );
            assertEquals( "hello...", Strings.padRight( "hello", 8, "." ) );
            assertEquals( "___hello", Strings.padRight( "hello", -8, "_" ) );
            assertEquals( "hello***", Strings.padRight( "hello", 8, "*.!" ) );
            }
        
        public function testTrimEnd():void
            {
            assertEquals( "hello", Strings.trimEnd( "hello   " ) );
            assertEquals( "hello", Strings.trimEnd( "hello  \n  \t   \r " ) );
            assertEquals( "---hello world", Strings.trimEnd( "---hello world---", ["-"] ) );
            assertEquals( "---hello world", Strings.trimEnd( "---hello world---", Strings.whiteSpaceChars.concat("-") ) );
            assertEquals( "---hello world", Strings.trimEnd( "---hello world--  -----  \r\n---\t-- ---", Strings.whiteSpaceChars.concat("-") ) );
            }
        
        public function testTrimStart():void
            {
            assertEquals( "hello", Strings.trimStart( "   hello" ) );
            assertEquals( "hello", Strings.trimStart( "  \n  \t   \r hello" ) );
            assertEquals( "hello world---", Strings.trimStart( "---hello world---", ["-"] ) );
            assertEquals( "hello world---", Strings.trimStart( "---hello world---", Strings.whiteSpaceChars.concat("-") ) );
            assertEquals( "hello world---", Strings.trimStart( "--  -----  \r\n---\t-- ---hello world---", Strings.whiteSpaceChars.concat("-") ) );
            }
        
        public function testTrim():void
            {
            assertEquals( "hello", Strings.trim( "   hello   " ) );
            assertEquals( "hello", Strings.trim( "  \n  \t   \r hello  \n  \t   \r " ) );
            assertEquals( "hello world", Strings.trim( "---hello world---", ["-"] ) );
            assertEquals( "hello world", Strings.trim( "---hello world---", Strings.whiteSpaceChars.concat("-") ) );
            assertEquals( "hello world", Strings.trim( "--  -----  \r\n---\t-- ---hello world--  -----  \r\n---\t-- ---", Strings.whiteSpaceChars.concat("-") ) );
            }
        
        public function testIndexOfAny():void
            {
            assertEquals( 1, Strings.indexOfAny("hello world", [2, "hello", 5]) );
            assertEquals( 2, Strings.indexOfAny("Five = 5", [2, "hello", 5]) );
            assertEquals( -1, Strings.indexOfAny("actionscript is good", [2, "hello", 5]) );
            assertEquals( 1, Strings.indexOfAny("hello world", ["2", "hello", "5"]) );
            assertEquals( 2, Strings.indexOfAny("Five = 5", ["2", "hello", "5"]) );
            assertEquals( 1, Strings.indexOfAny("hello world", [2, "hello", 5], -5) );
            assertEquals( 1, Strings.indexOfAny("hello world", [2, "hello", 5], 1) );
            assertEquals( 0, Strings.indexOfAny("hello the big world", ["hello", "the", "big", "world"], 0) );
            assertEquals( 1, Strings.indexOfAny("hello the big world", ["hello", "the", "big", "world"], 1) );
            assertEquals( 2, Strings.indexOfAny("hello the big world", ["hello", "the", "big", "world"], 2) );
            assertEquals( 3, Strings.indexOfAny("hello the big world", ["hello", "the", "big", "world"], 3) );
            assertEquals( -1, Strings.indexOfAny("hello the big world", ["hello", "some", "strange", "world"], 1, 2) );
            assertEquals( 3, Strings.indexOfAny("hello the big world", ["hello", "some", "strange", "world"], 1, 3) );
            assertEquals( 3, Strings.indexOfAny("hello the big world", ["hello", "some", "strange", "world"], 3, 3) );
            }
        
        public function testLastIndexOfAny():void
            {
            assertEquals( 0, Strings.lastIndexOfAny("hello world", ["2", "hello", "5"]) );
            assertEquals( 19, Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["2", "hello", "5"]) );
            }
        /*
        public function testInsert():void
            {
            assertTrue( false, "not implemented" );
            }
        */
        }
    
    }
