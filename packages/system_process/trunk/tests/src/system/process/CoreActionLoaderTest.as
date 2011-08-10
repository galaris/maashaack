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

package system.process 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import flash.display.Loader;
    import flash.net.URLRequest;
    
    public class CoreActionLoaderTest extends TestCase 
    {
        public function CoreActionLoaderTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertNotNull( a , "CoreActionLoader constructor method failed." ) ;
        }
        
        public function testInherit():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertTrue( a is CoreAction , "CoreActionLoader must extends the CoreAction class." ) ;
        }
        
        public function testDEFAULT_CACHE_PARAMETER():void
        {
            assertEquals( CoreActionLoader.DEFAULT_CACHE_PARAMETER, "random" ) ;
        }
        
        public function testDEFAULT_DELAY():void
        {
            assertEquals( CoreActionLoader.DEFAULT_DELAY, 8000 ) ;
        }
        
        public function testDEFAULT_TIMEOUT_POLICY():void
        {
            assertEquals(CoreActionLoader.DEFAULT_TIMEOUT_POLICY, TimeoutPolicy.LIMIT ) ;
        }
        
        public function testCache():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertFalse( a.cache ) ;
            a.cache = true ;            assertTrue( a.cache ) ;
            a.cache = false ;
            assertFalse( a.cache ) ;
        }
        
        public function testCacheParameterName():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertNull( a.cacheParameterName ) ;
            a.cacheParameterName = "randomize" ;
            assertEquals(a.cacheParameterName , "randomize") ;
        }
        
        public function testBytesLoaded():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertEquals( a.bytesLoaded, 0, "01 - CoreActionLoader bytesLoaded failed.");
        }
        
        public function testBytesTotal():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertEquals( a.bytesTotal, 0, "01 - CoreActionLoader bytesTotal failed.");
        }
        
        public function testDelay():void
        {
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertEquals( a.delay, CoreActionLoader.DEFAULT_DELAY , "01 - CoreActionLoader delay failed.");
            a.setDelay(2000) ;
            assertEquals( a.delay, 2000 , "02 - CoreActionLoader delay failed.");
        }
        
        public function testLoader():void
        {
            var loader:Loader           = new Loader() ;
            var action:CoreActionLoader = new CoreActionLoader() ;
            assertNull( action.loader , "01 - CoreActionLoader loader property failed." ) ;
            action.loader = loader ;
            assertTrue( action.loader == action.loader  , "02 - CoreActionLoader loader property failed." ) ;
        }
        
        public function testRequest():void
        {
            var r:URLRequest = new URLRequest("http://code.google.com/p/maashaack") ;
            var a:CoreActionLoader = new CoreActionLoader() ;
            assertNull( a.request , "01 - CoreActionLoader request failed.");
            a.request = r ;
            assertNotNull( a.request , "02-01 - CoreActionLoader request failed.");
            assertTrue( a.request == r , "02-02 - CoreActionLoader request failed.");
        }
        public function testTimeoutPolicy():void
        {
            var action:CoreActionLoader = new CoreActionLoader() ;
            
            assertEquals( action.timeoutPolicy.valueOf() , TimeoutPolicy.LIMIT.valueOf() , "01 - CoreActionLoader timeoutPolicy property failed." ) ;
            
            action.timeoutPolicy = TimeoutPolicy.INFINITY ;
            assertEquals( action.timeoutPolicy.valueOf() , TimeoutPolicy.INFINITY.valueOf() , "02 - CoreActionLoader timeoutPolicy property failed." ) ;
            
            action.timeoutPolicy = new TimeoutPolicy(10) ; // no valid policy object
            assertEquals( action.timeoutPolicy.valueOf() , TimeoutPolicy.INFINITY.valueOf() , "03 - CoreActionLoader timeoutPolicy property failed." ) ;
        }
        
        public function testClone():void
        {
            var loader:Loader           = new Loader() ;
            var action:CoreActionLoader = new CoreActionLoader( loader ) ;
            var clone:CoreActionLoader = action.clone() as CoreActionLoader ;
            assertNotNull( clone , "01 - CoreActionLoader clone method failed." ) ;
            assertFalse( clone == action  , "02 - CoreActionLoader clone method failed." ) ;
            assertTrue( clone.loader == action.loader  , "03 - CoreActionLoader clone method failed." ) ;
        }
    }
}

