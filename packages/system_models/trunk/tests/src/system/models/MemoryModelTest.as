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
package system.models 
{
    import library.ASTUce.framework.TestCase;

    import system.signals.Signaler;
    
    public class MemoryModelTest extends TestCase 
    {
        public function MemoryModelTest(name:String = "")
        {
            super( name );
        }
        
        public var model:MemoryModel ;
        
        public function setUp():void
        {
            model = new MemoryModel() ;
        }
        
        public function tearDown():void
        {
            model = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( model ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( model is KernelModel ) ;
        }
        
        public function testBeforeChanged():void
        {
            assertNotNull( model.beforeChanged as Signaler ) ;
        }
        
        public function testChanged():void
        {
            assertNotNull( model.changed as Signaler ) ;
        }
        
        public function testCleared():void
        {
            assertNotNull( model.cleared as Signaler ) ;
        }
        
        public function testCurrent():void
        {
            assertNull( model.current , "#1" ) ;
            model.current = "hello" ;
            assertEquals( "hello", model.current , "#2" ) ;
            model.current = "hi" ;
            assertEquals( "hi", model.current , "#3" ) ;
            model.current = "hi" ;
            assertEquals( "hi", model.current , "#4" ) ;
        }
        
        public function testSecurity():void
        {
            assertTrue( model.security , "#1" ) ;
            model.security = false ; 
            assertFalse( model.security , "#2" ) ;
            model.security = true ; 
            assertTrue( model.security , "#3" ) ;
        }
        
        public function testBack():void
        {
            model.current = "hello" ;
            model.current = "hi" ;
            assertEquals( "hi" , model.back() , "#1" ) ;
            assertEquals( "hello", model.current , "#2" ) ;
        }
        
        public function testClear():void
        {
            model.current = "hello" ;
            model.clear() ;
            assertNull( model.current ) ;
        }
        
        
        public function testHome():void
        {
            model.current = "hello" ;
            model.current = "hi" ;
            model.current = "bonjour" ;
            model.current = "hallo" ;
            
            assertEquals( "hallo" , model.home() , "#1" ) ;
            assertEquals( "hello", model.current , "#2" ) ;
        }
    }
}