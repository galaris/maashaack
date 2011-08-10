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

package system.reflection
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.Reflection;
    import system.reflection.samples.Basic2BasicClass;
    import system.reflection.samples.Basic2DynamicClass;
    import system.reflection.samples.Basic3Class;
    import system.reflection.samples.BasicClass;
    import system.reflection.samples.BasicClassInterface1;
    import system.reflection.samples.BasicClassInterface1and2;
    import system.reflection.samples.Dynamic2DynamicClass;
    import system.reflection.samples.DynamicClass;
    import system.reflection.samples.IBasicInterface1;
    import system.reflection.samples.IBasicInterface2;    

    public class ClassInfoTest extends TestCase
    {

        public function ClassInfoTest(name:String = "")
        {
            super(name);
        }

        public function testName():void
        {
            var s:String = "";
            var c:ClassInfo = Reflection.getClassInfo(s);
            assertEquals("String", c.name);
            
            var c2:ClassInfo = Reflection.getClassInfo(this);
            
            var original:Boolean = config.normalizePath;
            
            config.normalizePath = true;
            assertEquals("system.reflection.ClassInfoTest", c2.name);
            
            config.normalizePath = false;
            assertEquals("system.reflection::ClassInfoTest", c2.name);
            
            config.normalizePath = original;
        }

        public function testIsFinal():void
        {
            var s:String = "";
            var c:ClassInfo = Reflection.getClassInfo(s);
            assertTrue(c.isFinal());
        }

        public function testIsDynamic():void
        {
            var o:Object = {};
            var c:ClassInfo = Reflection.getClassInfo(o);
            assertTrue(c.isDynamic());
        }

        public function testIsInstance():void
        {
            var s1:String = "";
            var s2:Class = String;
            var c1:ClassInfo = Reflection.getClassInfo(s1);
            var c2:ClassInfo = Reflection.getClassInfo(s2);
            assertTrue(c1.isInstance());
            assertFalse(c2.isInstance());
        }

        public function testSuperClass():void
        {
            var s:String = "";
            var o:Object = {};
            var c1:ClassInfo = Reflection.getClassInfo(s);
            var c2:ClassInfo = Reflection.getClassInfo(o);
            
            assertEquals("Object", c1.superClass.name);
            assertNull(c2.superClass);
        }

        /* note:
        no more problem when ASTUce CLI is compiled dynamically :)
         */
        public function testSuperClass2():void
        {
            var c1:ClassInfo = Reflection.getClassInfo(this); //problem with ASTUce CLI
            var c2:ClassInfo = c1.superClass;
            var c3:ClassInfo = c2.superClass;
            
            assertEquals("buRRRn.ASTUce.framework.TestCase", c1.superClass.name);
            assertEquals("buRRRn.ASTUce.framework.Assert", c2.superClass.name);
            assertEquals("Object", c3.superClass.name);
        }

        public function testProperties1():void
        {
            var bc:BasicClass = new BasicClass();
            var c1:ClassInfo = Reflection.getClassInfo(bc);
            var c2:ClassInfo = Reflection.getClassInfo(BasicClass);
            var c3:ClassInfo = Reflection.getClassInfo(bc, FilterType.prototypeOnly);
            var c4:ClassInfo = Reflection.getClassInfo(BasicClass, FilterType.prototypeOnly);
            
            assertEquals(3, c1.properties.length);
            ArrayAssert.assertEquals(["variable1","constant","accessor"], c1.properties);
            ArrayAssert.assertEquals(["variable1","constant","accessor"], c2.properties);
            ArrayAssert.assertEquals([], c3.properties);
            ArrayAssert.assertEquals([], c4.properties);
        }

        public function testProperties2():void
        {
            var dc:DynamicClass = new DynamicClass();
            dc.test = 123;
            
            var c1:ClassInfo = Reflection.getClassInfo(dc);
            var c2:ClassInfo = Reflection.getClassInfo(DynamicClass);
            var c3:ClassInfo = Reflection.getClassInfo(dc, FilterType.traitOnly);
            var c4:ClassInfo = Reflection.getClassInfo(DynamicClass, FilterType.traitOnly);
            
            assertEquals(2, c1.properties.length);
            ArrayAssert.assertEquals(["test","variable10"], c1.properties);
            ArrayAssert.assertEquals(["variable10"], c2.properties);
            ArrayAssert.assertEquals([], c3.properties);
            ArrayAssert.assertEquals([], c4.properties);
        }

        public function testProperties3():void
        {
            var b2dc:Basic2DynamicClass = new Basic2DynamicClass();
            b2dc.test = 123;
            
            var c1:ClassInfo = Reflection.getClassInfo(b2dc);
            var c2:ClassInfo = Reflection.getClassInfo(Basic2DynamicClass);
            var c3:ClassInfo = Reflection.getClassInfo(b2dc, FilterType.traitOnly);
            var c4:ClassInfo = Reflection.getClassInfo(Basic2DynamicClass, FilterType.traitOnly);
            var c5:ClassInfo = Reflection.getClassInfo(b2dc, FilterType.prototypeOnly);
            var c6:ClassInfo = Reflection.getClassInfo(Basic2DynamicClass, FilterType.prototypeOnly);
            
            //trace( c1.toXML() );
            //trace( c1.methods ); 
            assertEquals(5, c1.properties.length);
            ArrayAssert.assertEquals(["test","variable100","variable1","constant","accessor"], c1.properties);
            ArrayAssert.assertEquals(["variable100","variable1","constant","accessor"], c2.properties);
            ArrayAssert.assertEquals(["variable1","constant","accessor"], c3.properties);
            ArrayAssert.assertEquals(["variable1","constant","accessor"], c4.properties);
            ArrayAssert.assertEquals(["test","variable100"], c5.properties);
            ArrayAssert.assertEquals(["variable100"], c6.properties);
        }

        public function testProperties4():void
        {
            //var d2bc:Dynamic2BasicClass = new Dynamic2BasicClass();
            
            //var c1:ClassInfo = Reflection.getClassInfo( d2bc );
            
            //trace( c1.toXML() );
        }

        public function testInherited1():void
        {
            var d2dc:Dynamic2DynamicClass = new Dynamic2DynamicClass();
            d2dc.test = 123;
               
               //var c1:ClassInfo = Reflection.getClassInfo( Dynamic2DynamicClass );
               //var c2:ClassInfo = Reflection.getClassInfo( Dynamic2DynamicClass, FilterType.declaredOnly );
               
               //var b2bc:Basic2BasicClass = new Basic2BasicClass();
               
               //var c3:ClassInfo = Reflection.getClassInfo( Basic2BasicClass );
               //var c4:ClassInfo = Reflection.getClassInfo( Basic2BasicClass, FilterType.declaredOnly );
               
               //trace( c1.toXML() );
//               trace( c3.toXML() );
//               trace( c1.properties );
//               trace( c1.methods );
//               trace( "---" );
//               trace( c2.properties );
//               trace( c2.methods );
//               trace( "---------------------" );
//               trace( c3.properties );
//               trace( c3.methods );
//               trace( "---" );
//               trace( c4.properties );
//               trace( c4.methods );
        }

        public function testHasInterface():void
        {
            var bci1:BasicClassInterface1 = new BasicClassInterface1();
            var bci1and2:BasicClassInterface1and2 = new BasicClassInterface1and2();
            
            var c1:ClassInfo = Reflection.getClassInfo(BasicClassInterface1);
            var c2:ClassInfo = Reflection.getClassInfo(bci1);
            var c3:ClassInfo = Reflection.getClassInfo(BasicClassInterface1and2);
            var c4:ClassInfo = Reflection.getClassInfo(bci1and2);
            
            assertTrue(c1.hasInterface(IBasicInterface1));
            assertTrue(c2.hasInterface(IBasicInterface1));
            assertFalse(c1.hasInterface(IBasicInterface2));
            assertFalse(c2.hasInterface(IBasicInterface2));
            
            assertFalse(c1.hasInterface(IBasicInterface1, IBasicInterface2));
            assertFalse(c2.hasInterface(IBasicInterface1, IBasicInterface2));
            
            assertTrue(c3.hasInterface(IBasicInterface1, IBasicInterface2));
            assertTrue(c4.hasInterface(IBasicInterface1, IBasicInterface2));
        }

        public function testInheritFrom():void
        {
            var b3:Basic3Class = new Basic3Class();
            var b:BasicClass = new BasicClass();
            
            var c1:ClassInfo = Reflection.getClassInfo(Basic3Class);
            var c2:ClassInfo = Reflection.getClassInfo(b3);
            var c3:ClassInfo = Reflection.getClassInfo(BasicClass);
            var c4:ClassInfo = Reflection.getClassInfo(b);
            
            assertTrue(c1.inheritFrom(Basic2BasicClass));
            assertTrue(c1.inheritFrom(BasicClass));
            assertTrue(c1.inheritFrom(BasicClass, Basic2BasicClass));
            
            assertTrue(c2.inheritFrom(Basic2BasicClass));
            assertTrue(c2.inheritFrom(BasicClass));
            assertTrue(c2.inheritFrom(BasicClass, Basic2BasicClass));
            
            assertFalse(c3.inheritFrom(Basic2BasicClass));
            assertFalse(c3.inheritFrom(Basic3Class));
            assertFalse(c3.inheritFrom(Basic3Class, Basic2BasicClass));
            
            assertFalse(c4.inheritFrom(Basic2BasicClass));
            assertFalse(c4.inheritFrom(Basic3Class));
            assertFalse(c4.inheritFrom(Basic3Class, Basic2BasicClass));
        }
        
        /*
        public function testMisc():void
            {
            var bc:BasicClass   = new BasicClass();
            var dc:DynamicClass = new DynamicClass();
            dc.test = 123;
            
            var b2dc:Basic2DynamicClass = new Basic2DynamicClass();
            b2dc.test = 123;
            
            var d2bc:Dynamic2BasicClass = new Dynamic2BasicClass();
            
            var c1:ClassInfo = Reflection.getClassInfo( bc );
            var c2:ClassInfo = Reflection.getClassInfo( BasicClass );
            
            var c3:ClassInfo = Reflection.getClassInfo( dc );
            var c4:ClassInfo = Reflection.getClassInfo( DynamicClass );
            
            var c5:ClassInfo = Reflection.getClassInfo( b2dc );
            var c6:ClassInfo = Reflection.getClassInfo( Basic2DynamicClass );
            
            var c7:ClassInfo = Reflection.getClassInfo( d2bc );
            var c8:ClassInfo = Reflection.getClassInfo( Dynamic2BasicClass );
            
            trace( "-----------------------" );
            trace( c1.toXML() );
            trace("["+ c1.properties +"]");
            trace( "-----------------------" );
            trace( c2.toXML() );
            trace("["+ c2.properties +"]");
            trace( "-----------------------" );
            trace( c3.toXML() );
            trace("["+ c3.properties +"]");
            trace( "-----------------------" );
            trace( c4.toXML() );
            trace("["+ c4.properties +"]");
            trace( "-----------------------" );
            trace( c5.toXML() );
            trace("["+ c5.properties +"]");
            trace( "-----------------------" );
            trace( c6.toXML() );
            trace("["+ c6.properties +"]");
            trace( "-----------------------" );
            trace( c7.toXML() );
            trace("["+ c7.properties +"]");
            trace( "-----------------------" );
            trace( c8.toXML() );
            trace("["+ c8.properties +"]");
            trace("["+ c8.variables +"]");
            trace("["+ c8.constants +"]");
            trace("["+ c8.accessors +"]");
            trace( "-----------------------" );
            
            }
        */
    }
}

