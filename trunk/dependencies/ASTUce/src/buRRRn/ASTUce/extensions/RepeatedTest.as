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
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)

*/
package buRRRn.ASTUce.extensions
    {
    import buRRRn.ASTUce.framework.*;
    
    /**
     *  A Decorator that runs a test repeatedly.
     */
    public class RepeatedTest extends TestDecorator
        {
        	
        /**
         * @private
         */
        private var _timesRepeat:int;
        
        /**
         * Creates a new RepeatedTest instance.
         * @param test The ITest reference of this object.
         * @param repeat The number of iteration of this repeated test.
         */
        public function RepeatedTest( test:ITest, repeat:int )
            {
            super( test );
            
            if( repeat < 0 )
                {
                throw new ArgumentError( "Repetition count must be > 0" );
                }
            
            _timesRepeat = repeat;
            }
        
        /**
         * The number of test cases.
         */
        public override function get countTestCases():int
            {
            return super.countTestCases * _timesRepeat;
            }
        
        /**
         * Run the test.
         */
        public override function run( result:TestResult ):void
            {
            var i:int;
            for( i=0; i<_timesRepeat; i++ )
                {
                if( result.shouldStop )
                    {
                    break;
                    }
                
                super.run( result );
                }
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString( ...args ):String
            {
            return super.toString() + " (repeated)";
            }
        
        }
    
    }

