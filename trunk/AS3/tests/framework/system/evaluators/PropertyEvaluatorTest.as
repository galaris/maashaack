
package system.evaluators 
{
    import buRRRn.ASTUce.framework.TestCase;    

    /**
     * The PropertyEvaluatorTest test case.
     */
    public class PropertyEvaluatorTest extends TestCase 
        {

        /**
         * Creates a new PropertyEvaluatorTest instance.
         */
        public function PropertyEvaluatorTest(name:String = "")
            {
            super( name );
            }
        
        public var obj:Object ;
        
        public var e1:PropertyEvaluator ;
        
        public var e2:PropertyEvaluator ; 
        
        public function setUp():void
            {
            	
            obj =
            {
                message : "hello world" ,
                title   : "my title"    ,
                menu    :
                {
                    title : "my menu title" ,
                    label : "my label"
                }
            };
            	
            e1 = new PropertyEvaluator() ;
            e2 = new PropertyEvaluator( obj ) ;
            }
        
        public function testInstances():void
            {
            assertNotNull ( e1  , "01 - The PropertyEvaluator instance not must be null." ) ;            
            assertNotNull ( e2  , "01 - The PropertyEvaluator instance not must be null." ) ;
            assertTrue( e1 is Evaluable, "The PropertyEvaluator instance implements IEvaluator failed.") ;
            }
        
 
        public function testEval():void
            {

                var expression:String ;
                
                /////// 01 - valid expressions
                
                expression = "message" ;
                assertEquals( obj.message , e2.eval( expression ) , "01.1 - The eval method failed with the expression : '" + expression + "'" ) ;
                
                expression = "title" ;
                assertEquals( obj.title , e2.eval( expression ) , "01.2 - The eval method failed with the expression : '" + expression + "'" ) ;

                expression = "menu.title" ;
                assertEquals( obj.menu.title , e2.eval( expression ) , "01.3 - The eval method failed with the expression : '" + expression + "'" ) ;

                expression = "menu.label" ;
                assertEquals( obj.menu.label , e2.eval( expression ) , "01.4 - The eval method failed with the expression : '" + expression + "'" ) ;
                
                /////// 02 - invalid expressions                
                
                expression = "unknow" ;
                assertNull( e2.eval( expression ) , "02.1 - The eval method failed with the expression : '" + expression + "'" ) ;
    
                expression = "menu.unknow" ;
                assertNull( e2.eval( expression ) , "02.2 - The eval method failed with the expression : '" + expression + "'" ) ;    

                expression = "" ;
                assertNull( e2.eval( expression ) , "02.3 - The eval method failed with the expression : '" + expression + "'" ) ;  
    
                /////// 03 - invalid expressions - with the custom "undefineable" attribute.  
    
                e2.undefineable = "empty" ;
    
                expression = "unknow" ;
                assertEquals( e2.undefineable , e2.eval( expression ) , "03 - The eval method failed with the expression : '" + expression + "'" ) ;
                
                /////// 04 - the "throwError" mode
    
                e2.throwError = true ;
                
                try
                {    
                    e2.eval( "unknow" ) ;
                    fail( "04.1 - The eval method failed with the expression : '" + expression + "' the throwError mode is true and an exception must be throwing." ) ;
                }
                catch( e:Error )
                {
                    assertEquals( "EvalError: [object PropertyEvaluator] eval failed with the expression : unknow" , e.toString() , "04.2 - The eval method failed with the expression : '" + expression + "'" ) ;                	
                }

            }
          
        
        }
    
    }

