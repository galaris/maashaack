
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

package system.evaluators 
{
    import buRRRn.ASTUce.framework.TestCase;            

    /**
     * The RomanEvaluatorTest test case.
     */
    public class RomanEvaluatorTest extends TestCase 
    {

        /**
         * Creates a new RomanEvaluatorTest instance.
         */
        public function RomanEvaluatorTest(name:String = "")
        {
            super(name);
        }

        public function testInstances():void
        {
        	var e:RomanEvaluator = new RomanEvaluator() ;
            assertNotNull(e, "01 - The RomanEvaluator instance not must be null.") ;            
            
        }
        
        public function testInterface():void
        {
        	var e:RomanEvaluator = new RomanEvaluator() ;
        	assertTrue(e is Evaluable, "The RomanEvaluator must implement the Evaluable interface.") ;
        }

        public function testEval():void
        {

            var e:RomanEvaluator = new RomanEvaluator() ;
            
            // evaluate a value out of range.
              
            try
            {    
                e.eval(0) ;
                fail( "01-01 - The eval method failed." ) ;
            }
            catch( er:Error )
            {
            	assertTrue( er is RangeError , "01-02 - The eval method failed." ) ;
                assertEquals( er.message , "RomanEvaluator.eval(0) failed, the value is out of the range [Range<1,3999>]" , "01-03 - The eval method failed." ) ;
            }

            try
            {    
                e.eval( 4000 ) ;
                fail( "02-01 - The eval method failed." ) ;
            }
            catch( er:Error )
            {
                assertTrue( er is RangeError , "02-02 - The eval method failed." ) ;
                assertEquals(er.message , "RomanEvaluator.eval(4000) failed, the value is out of the range [Range<1,3999>]" , "02-03 - The eval method failed." ) ;
            }
            
            // evaluate 
            
            assertEquals( e.eval( 1 )    , "I"         , "03-01 - eval( 1 ) failed." ) ;
            assertEquals( e.eval( 2 )    , "II"        , "03-02 - eval( 2 ) failed." ) ;
            assertEquals( e.eval( 3 )    , "III"       , "03-03 - eval( 3 ) failed." ) ;
            assertEquals( e.eval( 4 )    , "IV"        , "03-04 - eval( 4 ) failed." ) ;
            assertEquals( e.eval( 5 )    , "V"         , "03-05 - eval( 5 ) failed." ) ;
            assertEquals( e.eval( 6 )    , "VI"        , "03-06 - eval( 6 ) failed." ) ;
            assertEquals( e.eval( 9 )    , "IX"        , "03-07 - eval( 9 ) failed." ) ;
            assertEquals( e.eval( 10 )   , "X"         , "03-08 - eval( 10 ) failed." ) ;
            assertEquals( e.eval( 11 )   , "XI"        , "03-09 - eval( 11 ) failed." ) ;
            assertEquals( e.eval( 50 )   , "L"         , "03-10 - eval( 50 ) failed." ) ;
            assertEquals( e.eval( 2459 ) , "MMCDLIX"   , "03-11 - eval( 2459 ) failed." ) ;
            assertEquals( e.eval( 3999 ) , "MMMCMXCIX" , "03-12 - eval( 3999 ) failed." ) ;
            
        }
    }
}

