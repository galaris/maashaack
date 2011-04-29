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

package system.ioc.builders
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.ioc.ObjectArgument;
    import system.ioc.ObjectAttribute;
    
    public class createArgumentsTest extends TestCase
    {
        public function createArgumentsTest(name:String = "")
        {
            super(name);
        }
        
        public var args:Array ;
        
        public function setUp():void
        {
            args =  [ { value:"hello" } , { ref:"myRef" } , { config : "myConfig" } , { locale : "myLocale" , evaluators : [1,2,3] } ] ;
            args = createArguments( args ) ;
        }
        
        public function tearDown():void
        {
            args = null ;
        }
        
        public function testCreateArgumentsLength():void
        {
            assertEquals( 4 , args.length , "#0") ;
        }
        
        public function testCreateArgumentsValue():void
        {
            var arg:ObjectArgument = args[0] as ObjectArgument ;
            assertNotNull( arg , "#1" ) ;
            assertEquals( ObjectAttribute.VALUE , arg.policy , "#2" ) ;
            assertEquals( "hello" , arg.value , "#3" ) ;
            assertNull( arg.evaluators , "#4" ) ; 
        }
        
        public function testCreateArgumentsReference():void
        {
            var arg:ObjectArgument = args[1] as ObjectArgument ;
            assertNotNull( arg , "#1" ) ;
            assertEquals( ObjectAttribute.REFERENCE , arg.policy , "#2" ) ;
            assertEquals( "myRef" , arg.value , "#3" ) ;
            assertNull( arg.evaluators , "#4" ) ; 
        }
        
        public function testCreateArgumentsConfig():void
        {
            var arg:ObjectArgument = args[2] as ObjectArgument ;
            assertNotNull( arg , "#1" ) ;
            assertEquals( ObjectAttribute.CONFIG , arg.policy , "#2" ) ;
            assertEquals( "myConfig" , arg.value , "#3" ) ;
            assertNull( arg.evaluators , "#4" ) ; 
        }
        
        public function testCreateArgumentsLocale():void
        {
            var arg:ObjectArgument = args[3] as ObjectArgument ;
            
            assertNotNull( arg , "#1" ) ;
            assertEquals( ObjectAttribute.LOCALE , arg.policy , "#2" ) ;
            assertEquals( "myLocale" , arg.value , "#3" ) ;
            ArrayAssert.assertEquals( [1,2,3] , arg.evaluators , "#4" ) ; 
        }
    }
}
