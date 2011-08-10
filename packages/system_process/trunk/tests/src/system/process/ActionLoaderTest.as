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
    import flash.system.LoaderContext;
    
    public class ActionLoaderTest extends TestCase 
    {
        public function ActionLoaderTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var a:ActionLoader = new ActionLoader() ;
            assertNotNull( a , "ActionLoader constructor method failed." ) ;
        }
        
        public function testConstructorWithLoaderParameter():void
        {
            var a:ActionLoader ;
            
            a = new ActionLoader( new Loader() ) ;
            assertNotNull( a        , "01-01 ActionLoader constructor method failed." ) ;
            assertNotNull( a.loader , "01-02 ActionLoader constructor method failed, the loader property not must be null." ) ;
            
            a = new ActionLoader( null ) ;
            assertNotNull( a     , "02-01 ActionLoader constructor method failed." ) ;
            assertNull( a.loader , "02-02 ActionLoader constructor method failed, the loader property not must be null." ) ;
        }
        
        public function testInherit():void
        {
            var a:ActionLoader = new ActionLoader() ;
            assertTrue( a is CoreActionLoader , "ActionLoader must extends the CoreActionLoader class." ) ;
        }
        
        public function testContext():void
        {
            var a:ActionLoader = new ActionLoader() ;
            assertNull( a.context , "01 - ActionLoader context property failed." ) ;
            var context:LoaderContext = new LoaderContext() ;
            a.context = context ;
            assertNotNull( a.context , "02-01 - ActionLoader context property failed." ) ;
            assertTrue( a.context == context , "02-02 - ActionLoader context property failed." ) ;
        }
        
        public function testClone():void
        {
            var loader:Loader       = new Loader() ;
            var action:ActionLoader = new ActionLoader( loader ) ;
            var clone:ActionLoader = action.clone() as ActionLoader ;
            assertNotNull( clone , "01 - ActionLoader clone method failed." ) ;
            assertFalse( clone == action  , "02 - ActionLoader clone method failed." ) ;
            assertTrue( clone.loader == action.loader  , "03 - ActionLoader clone method failed." ) ;
        }
    }
}
