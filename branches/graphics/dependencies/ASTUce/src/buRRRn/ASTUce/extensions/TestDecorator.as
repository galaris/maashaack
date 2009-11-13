
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

package buRRRn.ASTUce.extensions
    {
    import buRRRn.ASTUce.framework.*;
    
    /**
     * A Decorator for Tests.
     * <p>Use TestDecorator as the base class for defining new test decorators.</p>
     * <p>Test decorator subclasses can be introduced to add behaviour before or after a test is run.</p>
     */
    public class TestDecorator extends Assert implements ITest
        {
        	
        /**
         * @private
         */
        private var _test:ITest;
        
        public function TestDecorator( test:ITest )
            {
            _test = test;
            }
        
        /**
         * The number of test cases.
         */
        public function get countTestCases():int
            {
            return _test.countTestCases;
            }
        
        /**
         * Indicates the ITest reference of this decorator.
         */
        public function get test():ITest
            {
            return _test;
            }
        
        /**
         * Runs the specified TestResult with this run method.
         */
        public function basicRun( result:TestResult ):void
            {
            _test.run( result );
            }
        
        /**
         * Runs the TestResult.
         */
        public function run( result:TestResult ):void
            {
            basicRun( result );
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString( ...args ):String
            {
            return _test.toString.apply( _test, args );
            }
        
        }
    
    }

