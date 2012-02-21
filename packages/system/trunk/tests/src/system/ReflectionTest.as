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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
            assertTrue( Reflection.hasClassByName( "system.ReflectMe" ) );
            assertTrue( Reflection.hasClassByName( "system::ReflectMe" ) );
            }
        
        public function testShortName():void
            {
            assertEquals( Reflection.getClassName( ReflectMe ), "ReflectMe" );
            }
        
        public function testLongName():void
            {
            assertEquals( Reflection.getClassName( ReflectMe, true ), "system::ReflectMe" );
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
