
package system.evaluators 
{
    import buRRRn.ASTUce.framework.TestCase;    

    /**
     * The DateEvaluatorTest test case.
     */
    public class DateEvaluatorTest extends TestCase 
    {

        /**
         * Creates a new DateEvaluatorTest instance.
         */
        public function DateEvaluatorTest(name:String = "")
        {
            super( name );
        }
        
        public var date_am:Date ;

        public var date_pm:Date ;
        
        public var evaluator:DateEvaluator ;   
        
        public function setUp():void
            {
            date_am    = new Date(2008,3,30,11,25,0,0) ;
            date_pm    = new Date(2008,3,30,23,35,0,0) ;
            evaluator  = new DateEvaluator() ;
            }
        
        public function testConstructor():void
            {
            assertNotNull(evaluator, "01 - The DateEvaluator instance not must be null.") ;
            assertEquals( evaluator.pattern, "dd.mm.yyyy HH:nn:ss", "02 - The DateEvaluator default argument in the constructor failed.") ;
            
            var formatter2:DateEvaluator = new DateEvaluator("HH:nn t") ;
            assertNotNull(formatter2, "03 - The DateEvaluator instance not must be null.") ;
            assertEquals(formatter2.pattern, "HH:nn t", "04 - The DateEvaluator argument in the constructor failed.") ;
            }
        
        public function testInterfaces():void
            {
            assertTrue( evaluator is IEvaluator, "The DateEvaluator instance implements IEvaluator failed.") ;
            }           
        
        public function testPattern():void
            {
            var e:DateEvaluator = new DateEvaluator("dd.mm.yyyy HH:nn:ss tt") ;
            
            assertEquals( e.pattern , "dd.mm.yyyy HH:nn:ss tt" , "01 - pattern attribute failed." ) ;
            
            e.pattern = "hh:nn:ss" ;
            
            assertEquals( e.pattern , "hh:nn:ss" , "02 - pattern attribute failed." ) ;
            }        
        
        public function testFormat():void
            {
            var e:DateEvaluator = new DateEvaluator() ;
            
            // full pm
            
            e.pattern = "dd.mm.yyyy HH:nn:ss tt" ;
            assertEquals( e.eval(date_pm) , "30.04.2008 23:35:00 pm" , "01_01 - eval method failed with pattern : " + e.pattern ) ;

            e.pattern = "dd.mm.yyyy HH:nn:ss t" ;
            assertEquals( e.eval(date_pm) , "30.04.2008 23:35:00 p" , "01_02 - eval method failed with pattern : " + e.pattern ) ;

            e.pattern = "dd.mm.yyyy hh:nn:ss TT" ;
            assertEquals( e.eval(date_pm) , "30.04.2008 11:35:00 PM" , "01_03 - eval method failed with pattern : " + e.pattern ) ;

            e.pattern = "dd.mm.yyyy hh:nn:ss T" ;
            assertEquals( e.eval(date_pm) , "30.04.2008 11:35:00 P" , "01_04 - eval method failed with pattern : " + e.pattern ) ;
            
            // full am
            
            e.pattern = "dd.mm.yyyy HH:nn:ss tt" ;
            assertEquals( e.eval(date_am) , "30.04.2008 11:25:00 am" , "01_05 - eval method failed with pattern : " + e.pattern ) ;

            e.pattern = "dd.mm.yyyy HH:nn:ss t" ;
            assertEquals( e.eval(date_am) , "30.04.2008 11:25:00 a" , "01_06 - eval method failed with pattern : " + e.pattern ) ;

            e.pattern = "dd.mm.yyyy hh:nn:ss TT" ;
            assertEquals( e.eval(date_am) , "30.04.2008 11:25:00 AM" , "01_07 - eval method failed with pattern : " + e.pattern ) ;            
            
            e.pattern = "dd.mm.yyyy hh:nn:ss T" ;
            assertEquals( e.eval(date_am) , "30.04.2008 11:25:00 A" , "01_08 - eval method failed with pattern : " + e.pattern ) ;            
                        
            
            // DAY_AS_NUMBER

            e.pattern = "d" ;
            assertEquals(e.eval(date_pm) , "30" , "02_01 - eval method failed with pattern : " + e.pattern ) ;
            
            e.pattern = "dd" ;
            assertEquals(e.eval(date_pm) , "30" , "02_02 - eval method failed with pattern : " + e.pattern ) ;
            
            // DAY_AS_TEXT
            
            e.pattern = "DD" ;
            assertEquals(e.eval(date_pm) , "We" , "03_01 - eval method failed with pattern : " + e.pattern ) ;
            
            e.pattern = "DDD" ;
            assertEquals(e.eval(date_pm) , "We" , "03_02 - eval method failed with pattern : " + e.pattern ) ;            
            
            e.pattern = "DDDD" ;
            assertEquals(e.eval(date_pm) , "Wednesday" , "03_03 - eval method failed with pattern : " + e.pattern ) ;
            
            // TODO complete more test ?
            
            }        
        
    }
}
