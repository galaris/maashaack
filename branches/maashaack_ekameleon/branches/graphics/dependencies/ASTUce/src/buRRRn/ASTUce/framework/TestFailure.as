
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
package buRRRn.ASTUce.framework
    {
    
    /**
     * A TestFailure collects a failed test together with the caught error.
     */
    public class TestFailure
        {
        
        protected var _failedTest:ITest;
        protected var _thrownError:Error;
        
        /**
         * Creates a TestFailure with the given test and error.
         */
        public function TestFailure( failedTest:ITest, thrownError:Error )
            {
            _failedTest  = failedTest;
            _thrownError = thrownError;
            }
        
        /**
         * Gets the message of the error.
         */
        public function get errorMessage():String
            {
            if( thrownError is ComparisonFailure )
                {
                return thrownError["getMessage"]();
                }
            
            return thrownError.message;
            }
        
        /**
         * Gets the failed test.
         */
        public function get failedTest():ITest
            {
            return _failedTest;
            }
        
        /**
         * Gets the thrown error.
         */
        public function get thrownError():Error
            {
            return _thrownError;
            }
        
        /**
         * Returns a Boolean indicating if the failure was an <code class="prettyprint">AssertionFailedError</code>.
         * @return a Boolean indicating if the failure was an <code class="prettyprint">AssertionFailedError</code>.
         */
        public function isFailure():Boolean
            {
            return (thrownError is AssertionFailedError);
            }
        
        /**
         * Returns a short description of the failure.
         * @return a short description of the failure.
         */
        public function toString():String
            {
            return failedTest + ": " + errorMessage;
            }
        
        /**
         * Returns a full description of the failure. (for the debugger version of Flash Player only).
         * @return a full description of the failure. (for the debugger version of Flash Player only).
         */
        public function trace():String
            {
            return thrownError.getStackTrace();
            }
        
        }
    
    }

