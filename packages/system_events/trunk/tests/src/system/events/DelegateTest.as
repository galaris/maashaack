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

package system.events 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.process.Runnable;
    
    import flash.events.Event;
    
    public class DelegateTest extends TestCase 
    {
        public function DelegateTest(name:String = "")
        {
            super( name );
        }
        
        public var scope:Object ;
        
        public function setUp():void
        {
            scope =
            {
                toString : function():String
                {
                    return "scope" ;
                }
            };
        }
        
        public function tearDown():void
        {
            scope = undefined ;
        }
        
        public function testConstructor():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var d:Delegate = new Delegate( scope , m , 2,3,4 ) ;
            assertNotNull( d , "Delegate constructor failed." ) ;
            assertEquals( d.scope     , scope        , "Delegate constructor failed, the scope isn't intialize." ) ;
            assertEquals( d.method    , m            , "Delegate constructor failed, the method isn't intialize." ) ;
            ArrayAssert.assertEquals( d.arguments , [2,3,4]  , "Delegate constructor failed, the arguments aren't intialize." ) ;
        }
        
        public function testInterface():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var d:Delegate = new Delegate( scope , m ) ;
            assertTrue( d is Cloneable     , "Delegate must implement the Cloneable interface." ) ;
            assertTrue( d is EventListener , "Delegate must implement the EventListener interface." ) ; 
            assertTrue( d is Runnable      , "Delegate must implement the Runnable interface." ) ;
        } 
        
        public function testArguments():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var a:Array = [2,3,4] ;
            var d:Delegate = new Delegate( scope , m  ) ;
            ArrayAssert.assertEquals( d.arguments , [] , "01 - Delegate arguments failed." ) ;
            d.arguments = a ;
            ArrayAssert.assertEquals( d.arguments , a , "02 - Delegate arguments failed." ) ;
        }
        
        public function testMethod():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var d:Delegate = new Delegate( scope , m  ) ;
            assertEquals( d.method , m , "Delegate method failed." ) ;
        }
        
        public function testScope():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var d:Delegate = new Delegate( scope , m  ) ;
            assertEquals( d.scope , scope , "Delegate scope failed." ) ;
        }
        
        public function testAddArguments():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var d:Delegate = new Delegate( scope , m  , 2 , 3 , 4 ) ;
            d.addArguments( 5, 6, 7);
            ArrayAssert.assertEquals( d.arguments , [2,3,4,5,6,7] , "Delegate addArguments failed." ) ;
        }
        
        public function testClone():void
        {
            var m:Function = function():String
            {
                return "scope:" + this.toString() ; 
            };
            var d:Delegate = new Delegate( scope , m , 2,3,4 ) ;
            var c:Delegate = d.clone() as Delegate ;
            assertNotNull( c , "Delegate clone failed." ) ;
            assertEquals( c.scope     , scope        , "01 - Delegate clone failed." ) ;
            assertEquals( c.method    , m            , "02 - Delegate clone failed." ) ;
            ArrayAssert.assertEquals( c.arguments , [2,3,4]  , "03 - Delegate clone failed." ) ;
        }
        
        public function testCreate():void
        {
            var method:Function = function( ...args:Array ):String
            {
                return "scope:" + this + " args:" + args ; 
            };
            var f:Function = Delegate.create(scope , method , 2, 3, 4 ) ;
            var r:String = f() ;
            assertEquals( r , "scope:scope args:2,3,4" , "Delegate.create failed") ;
        }
        
        public function testHandleEvent():void
        {
            var s:String ;
            var m:Function = function( ...args:Array ):void
            {
                s = "scope:" + this + " args:" + args ; 
            };
            var d:Delegate = new Delegate( scope , m , 2,3,4 ) ; 
            d.handleEvent( new Event("test") ) ;
            assertEquals( s , 'scope:scope args:[Event type="test" bubbles=false cancelable=false eventPhase=2],2,3,4' , "Delegate handleEvent failed") ;  
        }
        
        public function testRun():void
        {
            var s:String ;
            var m:Function = function( ...args:Array ):void
            {
                s = "scope:" + this + " args:" + args ; 
            };
            var d:Delegate = new Delegate( scope , m , 2,3,4 ) ; 
            d.run() ;
            assertEquals( s , 'scope:scope args:2,3,4' , "01 - Delegate run failed") ;
            
            d.run(5,6,7) ;
            assertEquals( s , 'scope:scope args:2,3,4,5,6,7' , "02 - Delegate run failed") ;
        }
    }
}
