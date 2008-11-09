/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
    - Zwetan Kjukov <zwetan@gmail.com>

*/
package system.numeric 
{
    import flash.errors.IllegalOperationError;
    
    import buRRRn.ASTUce.framework.TestCase;    

    /**
     * The MathematicsTest test case.
     */
    public class MathematicsTest extends TestCase 
    {

       /**
        * Creates a new MathematicsTest instance.
        */ 
        public function MathematicsTest(name:String = "")
        {
            super( name );
        }
        
       public function testCeil():void
        {
            var result:* ;
            
            result = Mathematics.ceil(4.572525153, 2) ;
            assertEquals( result , 4.58 , "Mathematics.ceil(4.572525153, 2) failed" ) ;
            
            result = Mathematics.ceil(4.572525153, 0) ;
            assertEquals( result , 5 , "Mathematics.ceil(4.572525153, 0) failed" ) ;            
            
            result = Mathematics.ceil(4.572525153, -1) ;
            assertEquals( result , 5 , "Mathematics.ceil(4.572525153, -1) failed" ) ;
            
            result = Mathematics.ceil(NaN, 0) ;
            assertEquals( result , NaN , "Mathematics.ceil(NaN, 0) failed" ) ;
            
            result = Mathematics.ceil(4.572525153, NaN) ;
            assertEquals( result , 5 , "Mathematics.ceil(4.572525153, NaN) failed" ) ;
            
        }
        
        public function testClamp():void
        {
            var result:* ;
            
            result = Mathematics.clamp(4, 5, 10) ;
            assertEquals( result , 5 , "Mathematics.clamp(4, 5, 10) failed" ) ;
            
            result = Mathematics.clamp(12, 5, 10) ;
            assertEquals( result , 10 , "Mathematics.clamp(12, 5, 10) failed" ) ;
            
            result = Mathematics.clamp(6, 5, 10) ;
            assertEquals( result , 6 , "Mathematics.clamp(6, 5, 10) failed" ) ;
            
            result = Mathematics.clamp(NaN, 5, 10) ;
            assertEquals( result , NaN , "Mathematics.clamp(NaN, 5, 10) failed" ) ;    
            
        }
        
        public function testFloor():void
        {
            var result:* ;
            
            result = Mathematics.floor(4.572525153, 2) ;
            assertEquals( result , 4.57 , "Mathematics.floor(4.572525153, 2) failed" ) ;
            
            result = Mathematics.floor(4.572525153, 0) ;
            assertEquals( result , 4 , "Mathematics.floor(4.572525153, 0) failed" ) ;            
            
            result = Mathematics.floor(4.572525153, -1) ;
            assertEquals( result , 4 , "Mathematics.floor(4.572525153, -1) failed" ) ;
            
            result = Mathematics.floor(NaN, 0) ;
            assertEquals( result , NaN , "Mathematics.floor(NaN, 0) failed" ) ;
            
            result = Mathematics.floor(4.572525153, NaN) ;
            assertEquals( result , 4 , "Mathematics.floor(4.572525153, NaN) failed" ) ;
            
        }
        

        public function testGcd():void
        {
            var result:* ;
            
            result = Mathematics.gcd( 320 , 240 ) ;
            assertEquals( result , 80 , "Mathematics.Mathematics.gcd( 320 , 240 ) failed" ) ;         
            
            result = Mathematics.gcd( 320 , 0 ) ;
            assertEquals( result , 320 , "Mathematics.Mathematics.gcd( 320 , 0 ) failed" ) ;
            
            result = Mathematics.gcd( 320 , 1 ) ;
            assertEquals( result , 1 , "Mathematics.Mathematics.gcd( 320 , 1 ) failed" ) ;
            
            result = Mathematics.gcd( 320 , 2 ) ;
            assertEquals( result , 2 , "Mathematics.Mathematics.gcd( 320 , 2 ) failed" ) ;    
            
            result = Mathematics.gcd( 320 , 320 ) ;
            assertEquals( result , 320 , "Mathematics.Mathematics.gcd( 320 , 2 ) failed" ) ;    
            
            result = Mathematics.gcd( 640 , 480 ) ;
            assertEquals( result , 160 , "Mathematics.Mathematics.gcd( 640 , 480 ) failed" ) ;       
            
            result = Mathematics.gcd( -640 , 480 ) ;
            assertEquals( result , -160 , "Mathematics.Mathematics.gcd( -640 , 480 ) failed" ) ; 
            
            result = Mathematics.gcd( 640 , -480 ) ;
            assertEquals( result , 160 , "Mathematics.Mathematics.gcd( 640 , -480 ) failed" ) ;                                      
            
            result = Mathematics.gcd( -640 , -480 ) ;
            assertEquals( result , -160 , "Mathematics.Mathematics.gcd( -640 , -480 ) failed" ) ;              
              
        }        
        
        public function testInterpolate():void
        {
            var result:* ;
            
            result = Mathematics.interpolate( 0.5, 0 , 100 ) ;
            assertEquals( result , 50 , "Mathematics.interpolate( 0.5, 0 , 100 ) failed" ) ;         
                        
        }
        
        public function testMap():void
        {
            
            var result:* ;
         
            result = Mathematics.map( 10, 0 , 100, 20, 80 ) ;
            assertEquals( result , 26 , "Mathematics.map( 10, 0 , 100, 20, 80 ) failed" ) ; 
            
            result = Mathematics.map( 26, 20 , 80, 0, 100 ) ;
            assertEquals( result , 10 , "Mathematics.map( 26, 20 , 80, 0, 100 ) failed" ) ;             
            
        }          
        
        public function testNormalize():void
        {
            var result:* ;
         
            result = Mathematics.normalize( 10, 0 , 100 ) ;
            assertEquals( result , 0.1 , "Mathematics.normalize( 10, 0 , 100 ) failed" ) ;         
            
            result = Mathematics.normalize( 50 , 0 , 500 ) ;
            assertEquals( result , 0.1 , "Mathematics.normalize( 50, 0 , 500  ) failed" ) ;            

            result = Mathematics.normalize( 100 , 0 , 500 ) ;
            assertEquals( result , 0.2 , "Mathematics.normalize( 100 , 0 , 500  ) failed" ) ;   
            
            result = Mathematics.normalize( 10, 25 , 100 ) ;
            assertEquals( result , -0.2 , "Mathematics.normalize( 10, 25 , 100 ) failed" ) ;
            
            result = Mathematics.normalize( 10, 25 , 500 ) ;
            assertEquals( result , -0.031578947368421054 , "Mathematics.normalize( 10, 25 , 500 ) failed" ) ;
        }
        
        public function testPercentage():void
        {
            var result:* ;
            
            result = Mathematics.percentage( 10, 100 ) ;
            assertEquals( result , 10 , "Mathematics.getPercent( 10, 100 ) failed" ) ;
            
            result = Mathematics.percentage( 50, 100 ) ;
            assertEquals( result , 50 , "Mathematics.getPercent( 50, 100 ) failed" ) ;            
            
            result = Mathematics.percentage( 68, 425 ) ;
            assertEquals( result , 16 , "Mathematics.getPercent( 68, 425 ) failed" ) ;
            
            result = Mathematics.percentage( NaN, NaN ) ;
            assertEquals( result , NaN , "Mathematics.getPercent( NaN, NaN ) failed" ) ;            

            result = Mathematics.percentage( NaN, 100 ) ;
            assertEquals( result , NaN , "Mathematics.getPercent( NaN, 100 ) failed" ) ;   
            
            result = Mathematics.percentage( 25, NaN ) ;
            assertEquals( result , NaN , "Mathematics.getPercent( 25, NaN ) failed" ) ;             
            
        }        
        
        public function testRound():void
        {
            var result:* ;
            
            result = Mathematics.round(4.572525153, 2) ;
            assertEquals( result , 4.57 , "Mathematics.round(4.572525153, 2) failed" ) ;
            
            result = Mathematics.round(4.572525153, 0) ;
            assertEquals( result , 5 , "Mathematics.round(4.572525153, 0) failed" ) ;            
            
            result = Mathematics.round(4.572525153, -1) ;
            assertEquals( result , 5 , "Mathematics.round(4.572525153, -1) failed" ) ;
            
            result = Mathematics.round(NaN, 0) ;
            assertEquals( result , NaN , "Mathematics.round(NaN, 0) failed" ) ;
            
            result = Mathematics.round(4.572525153, NaN) ;
            assertEquals( result , 5 , "Mathematics.round(4.572525153, NaN) failed" ) ;
            
        }
        
        public function testSign():void
        {
            var result:* ;
            
            result = Mathematics.sign( 10 ) ;
            assertEquals( result , 1 , "Mathematics.sign(10) failed" ) ;

            result = Mathematics.sign( -10 ) ;
            assertEquals( result , -1 , "Mathematics.sign(-10) failed" ) ;
            
            result = Mathematics.sign( 0 ) ;
            assertEquals( result , 1 , "Mathematics.sign(0) failed" ) ;            
            
            try
            {
                result = Mathematics.sign( NaN ) ;
                fail( "Mathematics.sign(NaN) failed 01." ) ;  
            }
            catch( e1:IllegalOperationError )
            {
                //
            }
            catch( e2:Error )
            {
                fail( "Mathematics.sign(NaN) failed 02." ) ;  
            }
            
        }   
        
    }
}
