/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.ASTUce.tests.framework
    {
    import buRRRn.ASTUce.framework.*;
    
    /* note:
       In the tests that follow, we can't use standard
       formatting for exception tests:
       
       (code)
       try
           {
           somethingThatShouldThrow();
           fail();
           }
       catch( e:AssertionFailedError )
           {
           //...
           }
       (end)
       because fail() would never be reported.
    */
    public class AssertTest extends TestCase
        {
        
        public function AssertTest( name:String = "" )
            {
            super( name );
            }
        
        /* note:
           Also, we are testing fail, so we can't rely on fail() working.
           We have to throw the exception manually.
        */
        public function testFail():void
            {
            try
                {
                fail();
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            throw new AssertionFailedError();
            }
        
        public function testAssertEquals():void
            {
            var o:Object = new Object();
            assertEquals( o, o );
            
            try
                {
                assertEquals( {hello:0}, {world:1} );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertEqualsNull():void
            {
            assertEquals( null, null );
            }
        
        public function testAssertStringEquals():void
            {
            assertEquals( "a", "a" );
            }
        
        public function testAssertNullNotEqualsString():void
            {
            try
                {
                assertEquals( null, "foo" );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertStringNotEqualsNull():void
            {
            try
                {
                assertEquals( "foo", null );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNullNotEqualsNull():void
            {
            try
                {
                assertEquals( null, new Object() );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNull():void
            {
            try
                {
                assertNull( new Object() );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNotNull():void
            {
            assertNotNull( new Object() );
            
            try
                {
                assertNotNull( null );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertTrue():void
            {
            assertTrue( true );
            
            try
                {
                assertTrue( false );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertFalse():void
            {
            assertFalse( false );
            
            try
                {
                assertFalse( true );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertSame():void
            {
            var o:Object = new Object();
            assertSame( o, o );
            
            try
                {
                assertSame( new Object(), new Object() );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNotSame():void
            {
            assertNotSame( new Object(), null );
		    assertNotSame( null, new Object() );
		    assertNotSame( new Object(), new Object() );
		    
		    try
                {
                var obj:Object = new Object();
                assertNotSame( obj, obj );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNotSameFailsNull():void
            {
            try
                {
                assertNotSame( null, null );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        }
    }

