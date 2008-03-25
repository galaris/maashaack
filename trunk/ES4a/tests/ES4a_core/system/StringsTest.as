
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
        
        public function testStaticCompare():void
            {
            var str1:String = new String("hello world");
            var str2:String = "hello world";
            var str3:String = "hello worl";
            var str4:String = "HELLO WORLD";
            
            assertEquals( Strings.compare( str1, null ),  1 );
            assertEquals( Strings.compare( null, str1 ), -1 );
            assertEquals( Strings.compare( str1, str2 ),  0 );
            assertEquals( Strings.compare( str2, str3 ),  1 );
            assertEquals( Strings.compare( str3, str2 ), -1 );
            assertEquals( Strings.compare( null, null ),  0 );
            assertEquals( Strings.compare( str2, str4, true ),  1 );
            }
        
        public function testStaticFormat():void
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
        
        public function testStaticFormatOptions():void
            {
            var str1:String = "hello {0,10}";
            var str2:String = "hello {0,-10}";
            var str3:String = "hello {0,-10:_}";
            var str4:String = "my {token,10}";
            var str5:String = "my {token,-10}";
            var str6:String = "my {token,10:.}";
            
            assertEquals( "hello      world", Strings.format( str1, "world" ), "A" );
            trace( "["+Strings.format( str2, "world" )+"]" )
            assertEquals( "hello world     ", Strings.format( str2, "world" ), "B" );
            assertEquals( "hello world_____", Strings.format( str3, "world" ), "C" );
            assertEquals( "my      token", Strings.format( str4, {token:"token"} ), "D" );
            assertEquals( "my token     ", Strings.format( str5, {token:"token"} ), "E" );
            assertEquals( "my .....token", Strings.format( str6, {token:"token"} ), "F" );
            }
        
        }
    
    }
