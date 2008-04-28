
package system.numeric 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.IEquatable;
    import system.ISerializable;    

    /**
     * @author eKameleon
     */
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
            assertTrue( range is IEquatable , "Range object must implement the IEquatable interface.") ;
            assertTrue( range is ISerializable , "Range object must implement the ISerializable interface.") ;
        }        
        
        public function testDEGREE_RANGE():void
        {
            assertNotNull( Range.DEGREE_RANGE  , "Range.DEGREE_RANGE not must be null.") ;
            assertTrue( Range.DEGREE_RANGE is Range  , "Range.DEGREE_RANGE must be a Range object.") ;
            assertEquals( Range.DEGREE_RANGE.min , 0, "Range.DEGREE_RANGE min value failed.") ;
            assertEquals( Range.DEGREE_RANGE.max , 360, "Range.DEGREE_RANGE max value failed.") ;
        }
        
        public function testPERCENT_RANGE():void
        {
            assertNotNull( Range.PERCENT_RANGE  , "Range.PERCENT_RANGE not must be null.") ;
            assertTrue( Range.PERCENT_RANGE is Range  , "Range.PERCENT_RANGE must be a Range object.") ;
            assertEquals( Range.PERCENT_RANGE.min , 0, "Range.PERCENT_RANGE min value failed.") ;
            assertEquals( Range.PERCENT_RANGE.max , 100, "Range.PERCENT_RANGE max value failed.") ;
        }
        
        public function testCOLOR_RANGE():void
        {
            assertNotNull( Range.COLOR_RANGE  , "Range.COLOR_RANGE not must be null.") ;
            assertTrue( Range.COLOR_RANGE is Range  , "Range.COLOR_RANGE must be a Range object.") ;
            assertEquals( Range.COLOR_RANGE.min , -255, "Range.COLOR_RANGE min value failed.") ;
            assertEquals( Range.COLOR_RANGE.max , 255, "Range.COLOR_RANGE max value failed.") ;
        }
        
        public function testUNITY_RANGE():void
        {
            assertNotNull( Range.UNITY_RANGE  , "Range.UNITY_RANGE not must be null.") ;
            assertTrue( Range.UNITY_RANGE is Range  , "Range.UNITY_RANGE must be a Range object.") ;
            assertEquals( Range.UNITY_RANGE.min , 0, "Range.UNITY_RANGE min value failed.") ;
            assertEquals( Range.UNITY_RANGE.max , 1, "Range.UNITY_RANGE max value failed.") ;
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
        	
        	var r3:Range ;
        	
        	r3 = Range.combine(r1, r2) ;
        	
            assertEquals( r3.min , 0, "Range.combine(" + r1 + "," + r2 + ").min failed.") ;
            assertEquals( r3.max , 300, "Range.combine(" + r1 + "," + r2 + ").max failed.") ;
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
            
            r = Range.expand(range) ;
            assertEquals(r.min ,   0 , "Range.expand(" + range + ") min value failed : " + Range.expand(range)) ;
            assertEquals(r.max , 300 , "Range.expand(" + range + ") max value failed : " + Range.expand(range)) ;
            
            r = Range.expand(range, 2 , 2) ;
            assertEquals(r.min , -100 , "Range.expand(" + range + ",2,2) min value failed : " + Range.expand(range)) ;
            assertEquals(r.max ,  400 , "Range.expand(" + range + ",2,2) max value failed : " + Range.expand(range)) ;
            	
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
            var float:Number = Range.getRandomFloat(range) ;
            
            assertTrue( float is Number , "Range.getRandomFloat(" + range + ") failed, the value isn't a Number.") ;
            assertTrue( range.contains(float) , "Range.getRandomFloat(" + range + ") failed, the value must be in the range.") ;
                        
        }
        
        public function testRandomInteger():void
        {
            var i:Number = Range.getRandomInteger(range) ;
            
            assertTrue( i is Number , "Range.getRandomInteger(" + range + ") failed, the value isn't a Number.") ;
            assertTrue( range.contains(i) , "Range.getRandomInteger(" + range + ") failed, the value must be in the range.") ;
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
            assertEquals( range.toString() , "[Range<100,200>]" , range + ".toString() failed." ) ;
        }
        
    }
}
