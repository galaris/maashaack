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

package system.numeric 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Equatable;
    import system.Serializable;
    
    public class RangeTest extends TestCase 
    {
        public function RangeTest(name:String = "")
        {
            super( name );
        }
        
        public var range:Range ;
        
        public function setUp():void
        {
            range = new Range(100,200) ;
        }
        
        public function tearDown():void
        {
            range = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( range , "Range object not must be null.") ;
            var r:Range ;
            try
            {
               r = new Range(200, 100) ;
               fail( "Range constructor failed, must throws a RangeError when the min argument is >= of the max argument.") ;
            }
            catch( e:RangeError )
            {
                //
            }
        }
        
        public function testInherit():void
        {
            assertTrue( range is Range , "Range object type failed.") ;
            assertTrue( range is Equatable , "Range object must implement the IEquatable interface.") ;
            assertTrue( range is Serializable , "Range object must implement the ISerializable interface.") ;
        }        
        
        public function testDEGREE():void
        {
            assertNotNull( Range.DEGREE  , "Range.DEGREE not must be null.") ;
            assertTrue( Range.DEGREE is Range  , "Range.DEGREE must be a Range object.") ;
            assertEquals( Range.DEGREE.min , 0, "Range.DEGREE min value failed.") ;
            assertEquals( Range.DEGREE.max , 360, "Range.DEGREE max value failed.") ;
        }
        
        public function testPERCENT():void
        {
            assertNotNull( Range.PERCENT  , "Range.PERCENT not must be null.") ;
            assertTrue( Range.PERCENT is Range  , "Range.PERCENT must be a Range object.") ;
            assertEquals( Range.PERCENT.min , 0, "Range.PERCENT min value failed.") ;
            assertEquals( Range.PERCENT.max , 100, "Range.PERCENT max value failed.") ;
        }
        
        public function testCOLOR():void
        {
            assertNotNull( Range.COLOR  , "Range.COLOR not must be null.") ;
            assertTrue( Range.COLOR is Range  , "Range.COLOR must be a Range object.") ;
            assertEquals( Range.COLOR.min , -255, "Range.COLOR min value failed.") ;
            assertEquals( Range.COLOR.max , 255, "Range.COLOR max value failed.") ;
        }
        
        public function testUNITY():void
        {
            assertNotNull( Range.UNITY  , "Range.UNITY not must be null.") ;
            assertTrue( Range.UNITY is Range  , "Range.UNITY must be a Range object.") ;
            assertEquals( Range.UNITY.min , 0, "Range.UNITY min value failed.") ;
            assertEquals( Range.UNITY.max , 1, "Range.UNITY max value failed.") ;
        }
        
        public function testMax():void
        {
            assertEquals( range.min , 100, "range.min value failed.") ;
        }
        
        public function testMin():void
        {
            assertEquals( range.max , 200, "range.max value failed.") ;
        }
        
        public function testClamp():void
        {
            assertEquals( range.clamp(0) , 100, "range.clamp(0) failed.") ;
            assertEquals( range.clamp(400) , 200, "range.clamp(400) failed.") ;
            assertEquals( range.clamp(150) , 150, "range.clamp(150) failed.") ;
        }
        
        public function testClone():void
        {
            var clone:Range = range.clone() as Range ;
            assertNotNull( clone , "range.clone() as Range not must be null.") ;
            assertNotSame(range, clone, "range and this clone not must be the same") ;
            assertEquals( range.min , clone.min, "compare range.min and clone.min failed.") ;
            assertEquals( range.max , clone.max, "compare range.max and clone.max failed.") ;
        }   
        
        public function testCombine():void
        {
            var r1:Range = new Range(0,100) ;
            var r2:Range = new Range(200,300) ;
            
            var r3:Range = r1.combine(r2) ;
            
            assertEquals( r3.min ,   0 , "Range.combine(" + r1 + "," + r2 + ").min failed.") ;
            assertEquals( r3.max , 300 , "Range.combine(" + r1 + "," + r2 + ").max failed.") ;
        } 
        
        public function testContains():void
        {
            assertTrue( range.contains(150) , "range.contains(150) failed");
            assertFalse( range.contains(1000) , "range.contains(1000) failed");
        }
        
        public function testEquals():void
        {
            var r:Range = new Range(100,200) ;
            assertTrue( range.equals(r) , "range.equals(r) failed with r:" + r + " and range:" + range );
        }
        
        public function testExpand():void
        {
            var r:Range ;
            
            r = range.expand() ;
            assertEquals(r , new Range(0,300) , "01 - Range expand failed.") ;
            
            r = range.expand(2 , 2) ;
            assertEquals(r , new Range(-100, 400) , "02 - Range expand failed.") ;
        }
        
        public function testFilterNaNValue():void
        {
            assertEquals(Range.filterNaNValue(NaN), 0, "Range.filterNaNValue(NaN) failed.") ;
            assertEquals(Range.filterNaNValue(NaN, 2), 2, "Range.filterNaNValue(NaN, 2) failed.") ;    
        }
        
        public function testGetCentralValue():void
        {
            var middle:Number = range.getCentralValue() ;
            assertEquals(middle, 150, "range.getCentralValue() failed:" + middle + " with range:" + range) ;
        }
        
        public function testRandomFloat():void
        {
            var float:Number = range.getRandomFloat() ;
            assertTrue( float is Number , "Range getRandomFloat(" + range + ") failed, the value isn't a Number.") ;
            assertTrue( range.contains(float) , "Range getRandomFloat(" + range + ") failed, the value must be in the range.") ;
        }
        
        public function testRandomInteger():void
        {
            var i:int = range.getRandomInteger() ;
            assertTrue( i is int , "Range getRandomInteger(" + range + ") failed, the value isn't a Number.") ;
            assertTrue( range.contains(i) , "Range getRandomInteger(" + range + ") failed, the value must be in the range.") ;
        } 
        
        public function testIsOutOfRange():void
        {
            assertFalse( range.isOutOfRange(150) , range + ".isOutOfRange(150) failed");
            assertTrue( range.isOutOfRange(1000) , range + ".isOutOfRange(1000) failed");
        }
        
        public function testOverLap():void
        {
            var r1:Range = new Range(0, 50) ;
            var r2:Range = new Range(0, 99) ;
            var r3:Range = new Range(0, 100) ;
            var r4:Range = new Range(0, 150) ;
            var r5:Range = new Range(200, 300) ;
            var r6:Range = new Range(201, 300) ;
            
            assertFalse( range.overlap(r1) , range + ".overlap(" + r1 + ") failed." ) ;
            
            assertFalse( range.overlap(r2) , range + ".overlap(" + r2 + ") failed." ) ;
            
            assertTrue ( range.overlap(r3) , range + ".overlap(" + r3 + ") failed." ) ;
            
            assertTrue( range.overlap(r4)  , range + ".overlap(" + r4 + ") failed." ) ;
            
            assertTrue( range.overlap(r5)  , range + ".overlap(" + r5 + ") failed." ) ;
            
            assertFalse( range.overlap(r6) , range + ".overlap(" + r6 + ") failed." ) ;
        }
        
        public function testSize():void
        {
            assertEquals( range.size() , 100 , range + ".size() failed." ) ;
        } 
        
        public function testToSource():void
        {
            assertEquals( range.toSource() , "new system.numeric.Range(100,200)" , range + ".toSource() failed." ) ;
        }
        
        public function testToString():void
        {
            assertEquals( range.toString() , "[Range min:100 max:200]" , range + ".toString() failed." ) ;
        }
    }
}
