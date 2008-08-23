
package system.evaluators 
{
    import buRRRn.ASTUce.framework.TestCase;                                            

    /**
     * The MultiEvaluatorTest test case.
     */
    public class MultiEvaluatorTest extends TestCase 
        {

        /**
         * Creates a new MultiEvaluatorTest instance.
         */
        public function MultiEvaluatorTest(name:String = "")
            {
            super( name );
            }
        
        public var evaluator:MultiEvaluator ;   
        
        public function setUp():void
            {
            evaluator  = new MultiEvaluator() ;
            }
        
        public function testConstructor():void
            {
            
            var e:MultiEvaluator = new MultiEvaluator( new CustomEvaluator() ) ;

            assertNotNull ( evaluator  , "01 - The MultiEvaluator instance not must be null." ) ;            
            assertNotNull ( e          , "02 - The MultiEvaluator instance not must be null." ) ;
            
            }
        
        public function testInterfaces():void
            {
            
            assertTrue( evaluator is Evaluable, "The MultiEvaluator instance implements IEvaluator failed.") ;
            
            }           

        public function testAutoClear():void
            {
            
            assertFalse( evaluator.autoClear, "The MultiEvaluator default autoclear property failed.") ;
            
            evaluator.autoClear = true ;
            
            assertTrue( evaluator.autoClear, "The MultiEvaluator autoclear property failed with true value.") ;
            
            evaluator.autoClear = false ;
            
            assertFalse( evaluator.autoClear, "The MultiEvaluator autoclear property failed with true value.") ;            
            
            }

        public function testAdd():void
            {
            
            }        
                  
        public function testClear():void
            {
            
            }
                
        public function testEval():void
            {
            
            }
                
        public function testRemove():void
            {
            
            }           
        
        }
}

import system.evaluators.Evaluable;

class CustomEvaluator implements Evaluable
    {
	
    public function CustomEvaluator()
        {
    	
        }
    
    public function eval(o:*):*
        {
        return o.toString() ;
        }
    
    }
