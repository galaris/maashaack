
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

package tests.ES4a.core
    {
    import buRRRn.ASTUce.framework.*;
    
    import system.Reflection;
    
    public class ReflectionTest extends TestCase
        {
        
        public function ReflectionTest( name:String="" )
            {
            super( name );
            }
        
        public function testFindClass():void
            {
            assertTrue( Reflection.hasClassByName( "Array" ) );
            assertFalse( Reflection.hasClassByName( "" ) );
            assertFalse( Reflection.hasClassByName( "IdontExistsClass" ) );
            assertTrue( Reflection.hasClassByName( "tests.ES4a.core.ReflectMe" ) );
            assertTrue( Reflection.hasClassByName( "tests.ES4a.core::ReflectMe" ) );
            }
        
        public function testShortName():void
            {
            assertEquals( Reflection.getClassName( ReflectMe ), "ReflectMe" );
            }
        
        public function testLongName():void
            {
            assertEquals( Reflection.getClassName( ReflectMe, true ), "tests.ES4a.core::ReflectMe" );
            }
        
        public function testFindMethods():void
            {
            var methods:Array = Reflection.getClassMethods( new ReflectMe() );
            var methods2:Array = Reflection.getClassMethods( ReflectMe );
            var methods3:Array = Reflection.getClassMethods( SuperReflectMe );
            
            assertEquals( methods.length, 5 );
            methods.sort();
            assertEquals( methods.join(""), "DEFGH" );
            
            assertEquals( methods2.length, 0 );
            
            assertEquals( methods3.length, 3 );
            methods3.sort();
            assertEquals( methods3.join(""), "XYZ" );
            }
        
        public function testFindInheritedMethods():void
            {
            var methods:Array = Reflection.getClassMethods( new ReflectMe(), true );
            assertEquals( methods.length, 8 );
            methods.sort();
            assertEquals( methods.join(""), "ABCDEFGH" );
            }
        
        }
    
    }
