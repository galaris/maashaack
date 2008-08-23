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

package system.reflection
    {
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Reflection;
    
    public class TypeInfoTest extends TestCase
        {
        
        public function TypeInfoTest( name:String="" )
            {
            super(name);
            }
        
        public function testCanConvertTo():void
            {
            var num:* = 0;
            var t:TypeInfo = Reflection.getTypeInfo( num );
            assertTrue( t.canConvertTo( Number ) );
            assertTrue( t.canConvertTo( int ) );
            assertTrue( t.canConvertTo( uint ) );
            }
        
        public function testCanConvertTo2():void
            {
            var arr:Array = [0,1,2];
            var t:TypeInfo = Reflection.getTypeInfo( arr );
            assertTrue( t.canConvertTo( Object ) );
            }
        
        public function testCanConvertTo3():void
            {
            var obj:Object = {};
            var t:TypeInfo = Reflection.getTypeInfo( obj );
            assertFalse( t.canConvertTo( Array ) );
            }
        
        public function testIsSubtypeOf():void
            {
            var arr:Array = [0,1,2];
            var t:TypeInfo = Reflection.getTypeInfo( arr );
            assertTrue( t.isSubtypeOf( Object ) );
            }
        
        public function testIsSubtypeOf2():void
            {
            var num:int = 0;
            var t:TypeInfo = Reflection.getTypeInfo( num );
            assertTrue( t.isSubtypeOf( Number ) );
            }
        
        public function testIsSubtypeOf3():void
            {
            var num:Number = 0;
            var t:TypeInfo = Reflection.getTypeInfo( num );
            assertTrue( t.isSubtypeOf( int ) );
            }
        
        }
    }

