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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.process 
{    import buRRRn.ASTUce.framework.TestCase;

    import system.Cloneable;
    import system.process.cache.Attribute;

    public class CacheTest extends TestCase
    {
        
        public function CacheTest(name:String = "")
        {
            super(name);
        }
        
        public var cache:Cache ;
        
        public function setUp():void
        {
            cache = new Cache() ;
        }
        
        public function tearDown():void
        {
            cache = null ;
        }
        
        public function testConstructor():void
        {
            var cache:Cache ;
            
            cache = new Cache() ;
            assertNotNull ( cache , "01 - Cache constructor failed." ) ;
            
            var target:Object = {} ;
            cache = new Cache( target ) ;
            assertNotNull ( cache , "02-01 - Cache constructor failed." ) ;
            assertEquals ( cache.target, target , "02-02 - Cache constructor failed." ) ;
        }
        
        public function testInterface():void
        {
            var cache:Cache = new Cache() ;
            assertTrue( cache is Cloneable , "The Cache instance must implement the Cloneable interface." ) ;
            assertTrue( cache is Runnable  , "The Cache instance must implement the Runnable interface." ) ;
        }
        
        public function testClear():void
        {
            cache.enqueueAttribute("prop1", 1) ;
            cache.enqueueAttribute("prop2", 2) ;
            cache.enqueueAttribute("prop3", 3) ;
            var oldSize:int = cache.size() ;
            cache.clear() ;
            assertEquals( oldSize  , 3  , "01 - Cache clear method failed." ) ;
            assertNotSame( cache.size() , oldSize  , "02 - Cache clear method failed." ) ;
            assertEquals( cache.size()  , 0  , "03 - Cache clear method failed." ) ;
        }
        
        public function testClone():void
        {
            cache.enqueueAttribute("prop1", 1) ;
            cache.enqueueMethod("prop2", [1,2,3]) ;

            var clone:Cache = cache.clone() as Cache ;
            assertNotNull(clone, "01 - Cache clone failed.") ;
            assertEquals( clone.size() , cache.size() , "02 - Cache clone failed.") ;
            
            cache.clear() ;
            
            assertEquals( clone.size() , 2 , "03 - Cache clone failed.") ;
        }
        
        public function testElement():void
        {
            assertNull(cache.element(), "01 - Cache element() failed.") ;
            
            cache.enqueueAttribute("prop1", 1) ;
            
            var elmt:Attribute = cache.element() as Attribute ;
            
            assertNotNull(elmt, "02-01 - Cache element failed.") ;
            assertEquals( elmt.name  , "prop1" , "02-02 - Cache element failed.") ;
            assertEquals( elmt.value , 1       , "02-03 - Cache element failed.") ;
            
            cache.clear() ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( cache.isEmpty() , "01 - The Cache isEmpty method failed." ) ;
            cache.enqueueAttribute("prop", 1) ;
            assertFalse( cache.isEmpty() , "02 - The Cache isEmpty method failed." ) ;
            cache.clear() ;
            assertTrue( cache.isEmpty() , "03 - The Cache isEmpty method failed." ) ;
        }
        
        public function testSize():void
        {
            cache.enqueueAttribute("prop1", 1) ;
            cache.enqueueAttribute("prop2", 2) ;
            cache.enqueueAttribute("prop3", 3) ;
            assertEquals( cache.size() , 3  , "Cache size method failed." ) ;
            cache.clear() ;
        }        }}