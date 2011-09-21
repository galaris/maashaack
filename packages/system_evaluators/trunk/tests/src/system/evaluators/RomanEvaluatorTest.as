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

package system.evaluators 
{
    import library.ASTUce.framework.TestCase;
    
    import system.Evaluable;
    
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
        
        public function testEvalInvalidValue():void
        {
            var e:RomanEvaluator = new RomanEvaluator() ;
            assertNull( e.eval( {} ) ) ;
        }
        
        public function testEvalRange():void
        {
            var e:RomanEvaluator = new RomanEvaluator() ;
            
            // evaluates a value out of range.
            
            try
            {    
                e.eval(-1) ;
                fail( "01-01 - The eval method failed." ) ;
            }
            catch( er:Error )
            {
                assertTrue( er is RangeError , "01-02 - The eval method failed." ) ;
                assertEquals( er.message , "Min value for a RomanNumber is 0" , "01-03 - The eval method failed." ) ;
            }
            
            try
            {    
                e.eval( 4000 ) ;
                fail( "02-01 - The eval method failed." ) ;
            }
            catch( er:Error )
            {
                assertTrue( er is RangeError , "02-02 - The eval method failed." ) ;
                assertEquals(er.message , "Max value for a RomanNumber is 3999" , "02-03 - The eval method failed." ) ;
            }
        }
        
        public function testEvalNumberToString():void
        {
            var e:RomanEvaluator = new RomanEvaluator() ;
            
            assertEquals( e.eval( 1 )    , "I"         , "01 - eval( 1 ) failed." ) ;
            assertEquals( e.eval( 2 )    , "II"        , "02 - eval( 2 ) failed." ) ;
            assertEquals( e.eval( 3 )    , "III"       , "03 - eval( 3 ) failed." ) ;
            assertEquals( e.eval( 4 )    , "IV"        , "04 - eval( 4 ) failed." ) ;
            assertEquals( e.eval( 5 )    , "V"         , "05 - eval( 5 ) failed." ) ;
            assertEquals( e.eval( 6 )    , "VI"        , "06 - eval( 6 ) failed." ) ;
            assertEquals( e.eval( 9 )    , "IX"        , "07 - eval( 9 ) failed." ) ;
            assertEquals( e.eval( 10 )   , "X"         , "08 - eval( 10 ) failed." ) ;
            assertEquals( e.eval( 11 )   , "XI"        , "09 - eval( 11 ) failed." ) ;
            assertEquals( e.eval( 50 )   , "L"         , "10 - eval( 50 ) failed." ) ;
            
            assertEquals( e.eval( 2459 ) , "MMCDLIX"   , "11 - eval( 2459 ) failed." ) ;
            assertEquals( e.eval( 3999 ) , "MMMCMXCIX" , "12 - eval( 3999 ) failed." ) ;
            assertEquals( e.eval( 1997 ) , "MCMXCVII"  , "13 - eval( 1997 ) failed." ) ;
        }
        
        public function testEvalStringToNumber():void
        {
            var e:RomanEvaluator = new RomanEvaluator() ;
            
            assertEquals( e.eval(   "I" ) ,  1  , "01 - eval(  'I'  ) failed." ) ;
            assertEquals( e.eval(  "II" ) ,  2  , "02 - eval(  'II' ) failed." ) ;
            assertEquals( e.eval( "III" ) ,  3  , "03 - eval( 'III' ) failed." ) ;
            assertEquals( e.eval(  "IV" ) ,  4  , "04 - eval(  'IV' ) failed." ) ;
            assertEquals( e.eval(   "V" ) ,  5  , "05 - eval(   'V' ) failed." ) ;
            assertEquals( e.eval(  "VI" ) ,  6  , "06 - eval(  'VI' ) failed." ) ;
            assertEquals( e.eval(  "IX" ) ,  9  , "07 - eval(  'IX' ) failed." ) ;
            assertEquals( e.eval(   "X" ) , 10  , "08 - eval(   'X' ) failed." ) ;
            assertEquals( e.eval(  "XI" ) , 11  , "08 - eval(  'XI' ) failed." ) ;
            assertEquals( e.eval(   "L" ) , 50  , "08 - eval(   'L' ) failed." ) ;
            
            assertEquals( e.eval(   "MMCDLIX" ) , 2459 , "11 - eval(   'MMCDLIX' ) failed." ) ;
            assertEquals( e.eval( "MMMCMXCIX" ) , 3999 , "12 - eval( 'MMMCMXCIX' ) failed." ) ;
            assertEquals( e.eval(  "MCMXCVII" ) , 1997 , "13 - eval(  'MCMXCVII' ) failed." ) ;
        }
    }
}