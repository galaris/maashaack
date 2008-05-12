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
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

*/

package system.reflection
    {
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Reflection;
    
    public class ClassInfoTest extends TestCase
        {
        
        public function ClassInfoTest(name:String="")
            {
            super(name);
            }
        
        public function testName():void
            {
            var s:String = "";
            var c:ClassInfo = Reflection.getClassInfo( s );
            assertEquals( "String", c.name );
            
            var c2:ClassInfo = Reflection.getClassInfo( this );
            
            var original:Boolean = config.normalizePath;
            
            config.normalizePath = true;
            assertEquals( "system.reflection.ClassInfoTest", c2.name );
            
            config.normalizePath = false;
            assertEquals( "system.reflection::ClassInfoTest", c2.name );
            
            config.normalizePath = original;
            }
        
        public function testIsFinal():void
            {
            var s:String = "";
            var c:ClassInfo = Reflection.getClassInfo( s );
            assertTrue( c.isFinal() );
            }
        
        public function testIsDynamic():void
            {
            var o:Object = {};
            var c:ClassInfo = Reflection.getClassInfo( o );
            assertTrue( c.isDynamic() );
            }
        
        public function testIsInstance():void
            {
            var s1:String = "";
            var s2:Class = String;
            var c1:ClassInfo = Reflection.getClassInfo( s1 );
            var c2:ClassInfo = Reflection.getClassInfo( s2 );
            assertTrue( c1.isInstance() );
            assertFalse( c2.isInstance() );
            }
        
        public function testSuperClass():void
            {
            var s:String = "";
            var o:Object = {};
            var c1:ClassInfo = Reflection.getClassInfo( s );
            var c2:ClassInfo = Reflection.getClassInfo( o );
            
            assertEquals( "Object", c1.superClass.name );
            assertNull( c2.superClass );
            }
        
        public function testSuperClass2():void
            {
            var c1:ClassInfo = Reflection.getClassInfo( this );
            var c2:ClassInfo = c1.superClass;
            var c3:ClassInfo = c2.superClass;
            
            assertEquals( "buRRRn.ASTUce.framework.TestCase", c1.superClass.name );
            assertEquals( "buRRRn.ASTUce.framework.Assert", c2.superClass.name );
            assertEquals( "Object", c3.superClass.name );
            }
        
        }
    }

