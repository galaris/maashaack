
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
    
    /* Test for the special NaN value.
       
       note:
       equivalent to DoublePrecisionAssertTest in JUnit.
    */
    public class NumberAssertTest extends TestCase
        {
        
        public function NumberAssertTest( name:String = "" )
            {
            super( name );
            }
        
        public function testAssertEqualsNaNFails():void
            {
            try
                {
                assertEquals( 1.234, NaN );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNaNEqualsFails():void
            {
            try
                {
                assertEquals( NaN, 1.234 );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertNaNEqualsNaNFails():void
            {
            /*
            try
                {
                assertEquals( NaN, NaN );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            */
            //we do support NaN even if it's useless...
            assertEquals( NaN, NaN );
            }
        
        public function testAssertPosInfinityNotEqualsNegInfinity():void
            {
            try
                {
                assertEquals( Number.POSITIVE_INFINITY, Number.NEGATIVE_INFINITY );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertPosInfinityNotEquals():void
            {
            try
                {
                assertEquals( Number.POSITIVE_INFINITY, 1.23 );
                }
            catch( e:AssertionFailedError )
                {
                return;
                }
            
            fail();
            }
        
        public function testAssertPosInfinityEqualsInfinity():void
            {
            assertEquals( Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY );
            }
        
        public function testAssertNegInfinityEqualsInfinity():void
            {
            assertEquals( Number.NEGATIVE_INFINITY, Number.NEGATIVE_INFINITY );
            }
        
        }
    
    }

