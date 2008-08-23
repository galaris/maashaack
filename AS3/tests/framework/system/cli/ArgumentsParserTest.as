/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.cli
    {
    import buRRRn.ASTUce.framework.*;
    
    public class ArgumentsParserTest extends TestCase
        {
        
        public function ArgumentsParserTest( name:String="" )
            {
            super( name );
            }
        
        public function testNonSwitchOnly():void
            {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse( ["hello.txt"] );

            assertTrue( result );            
            assertEquals( simple.a, false );
            assertEquals( simple.b, false );
            assertEquals( simple.c, "" );
            assertEquals( simple.filename, "hello.txt" );
            }
        
        public function testSwitchOnly():void
            {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse( ["-a", "-b", "-c:z"] );
            
            assertFalse( result ); //<filename> is required
            assertTrue( simple.debugTrace.indexOf( "you have to provide a <filename>." ) > -1 );
            assertTrue( simple.debugTrace.indexOf( "Usage: myApp [-a] [-b] [-c:x|y|z] <filename>" ) > -1 );
            assertEquals( simple.a, true );
            assertEquals( simple.b, true );
            assertEquals( simple.c, "z" );
            assertEquals( simple.filename, "" );
            }
        
        public function testEmpty():void
            {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse( [] );
            
            assertFalse( result );
            assertTrue( simple.debugTrace.indexOf( "you have to provide a <filename>." ) > -1 );
            assertTrue( simple.debugTrace.indexOf( "Usage: myApp [-a] [-b] [-c:x|y|z] <filename>" ) > -1 );
            }
        
        public function testShowUsage():void
            {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse( ["-?"] );
            
            assertFalse( result );
            assertFalse( simple.debugTrace.indexOf( "you have to provide a <filename>." ) > -1 );
            assertTrue( simple.debugTrace.indexOf( "Usage: myApp [-a] [-b] [-c:x|y|z] <filename>" ) > -1 );
            }
        
        public function testInvalidSwitch():void
            {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse( ["-x"] );
            
            assertFalse( result );
            assertTrue( simple.debugTrace.indexOf( "CLI switch error: -x" ) > -1 );
            assertTrue( simple.debugTrace.indexOf( "Usage: myApp [-a] [-b] [-c:x|y|z] <filename>" ) > -1 );
            }
        
        public function testInvalidSwitchValue():void
            {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse( ["-c:a"] );
            
            assertFalse( result );
            assertTrue( simple.debugTrace.indexOf( "CLI switch error: a is not a correct value for -c" ) > -1 );
            assertTrue( simple.debugTrace.indexOf( "Usage: myApp [-a] [-b] [-c:x|y|z] <filename>" ) > -1 );
            }
        
        }
    
    }
