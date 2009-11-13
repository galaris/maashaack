
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
    
     // TODO refactor with MessageBroadcaster ?
     // TODO add an AsyncTestResult working with flash.events ?

    /**
     * A TestResult collects the results of executing a test case.
     * <p>It is an instance of the Collecting Parameter pattern.</p>
     * <p>The test framework distinguishes between *failures* and *errors*.</p>
     * <p>A failure is anticipated and checked for with assertions.</p>
     * <p>Errors are unanticipated problems like an <ArgumentError>.</p>
     * <p><b>Note : </b></p>
     * <p>A little difference with JUnit is the addition of addValid calls, which is used to indicate 
     * to a ITestListener that a "test run" ran without problems.</p>
     * <p>While implementing the command line interface I noticed that the writing of test runs as "...F...E.." was not 
     * in sync, if you ran 3 tests without errors/failures you did obtained the exact count "...", but if you ran
     * 3 test which contained 1 failure you obtained ".F.." and as my goal was to display a symbol corresponding
     * to either an error/a failure or a valid test, then I added the addValid to allow to do that.
     * </p>
     * @see ITest
     */
    public class TestResult
        {
        private   var _stop:Boolean;
        
        protected var _failures:Array;
        protected var _errors:Array;
        protected var _listeners:Array;
        protected var _runTests:int;
        
        /**
         * Creates a new TestResult instance.
         */
        public function TestResult()
            {
            _failures  = [];
            _errors    = [];
            _listeners = [];
            _runTests  = 0;
            _stop      = false;
            }
        
        /**
         * Indicates the number of detected errors.
         */
        public function get errorCount():int
            {
            return _errors.length;
            }
        
        /**
         * Returns an Array for the errors.
         */
        public function get errors():Array
            {
            return _errors;
            }
        
        /**
         * Returns the number of detected failures.
         */
        public function get failureCount():int
            {
            return _failures.length;
            }
        
        /**
         * Returns an Array for the failures.
         */
        public function get failures():Array
            {
            return _failures;
            }
        
        /**
         * Indicates the number of run tests.
         */
        public function get runCount():int
            {
            return _runTests;
            }
        
        /**
         * Checks whether the test run should stop.
         */
        public function get shouldStop():Boolean
            {
            return _stop;
            }
       
        /**
         * Adds an error to the list of errors. The passed in exception caused the error.
         */
        public function addError( test:ITest, e:Error ):void
            {
            var i:int;
            var listeners:Array = cloneListeners();
            
            _errors.push( new TestFailure( test, e ) );
            
            for( i=0; i<listeners.length; i++ )
                {
                listeners[i].addError( test, e );
                }
            }
        
        /**
         * Adds a failure to the list of failures. The passed in exception caused the failure.
         */
        public function addFailure( test:ITest, afe:AssertionFailedError ):void
            {
            var i:int;
            var listeners:Array = cloneListeners();
            
            _failures.push( new TestFailure( test, afe ) );
            
            for( i=0; i<listeners.length; i++ )
                {
                listeners[i].addFailure( test, afe );
                }
            }
        
        /**
         * Adds a a valid test to the listeners.
         */
        public function addValid( test:ITest ):void
            {
            var i:int;
            var listeners:Array = cloneListeners();
            
            for( i=0; i<listeners.length; i++ )
                {
                listeners[i].addValid( test );
                }
            }
        
        /**
         * Registers a TestListener.
         */
        public function addListener( listener:ITestListener ):void
            {
            _listeners.push( listener );
            }
        
        /**
         * Returns a copy of the listeners.
         */
        public function cloneListeners():Array
            {
            return _listeners.concat(); //shalllow copy
            }
        
        /**
         * Informs the result that a test was completed.
         */
        public function endTest( test:ITest ):void
            {
            var i:int;
            var listeners:Array = cloneListeners();
            
            for( i=0; i<listeners.length; i++ )
                {
                listeners[i].endTest( test );
                }
            }
        
        /**
         * Unregisters a TestListener.
         */
        public function removeListener( listener:ITestListener ):void
            {
            var index:int = _listeners.indexOf( listener );
            
            if( index > -1 )
                {
                _listeners.splice( index, 1 );
                }
            }
        
        /**
         * Runs a TestCase.
         */
        public function run( test:TestCase ):void
            {
            startTest( test );
            
            var p:Protectable = new Protectable();
            p.protect = function():void
                {
                test.runBare();
                };
            
            runProtected( test, p );
            endTest( test );
            }
        
        /**
         * Runs a TestCase.
         * <p><b>Note :</b>Yes, you can catch errors by error type :)</p>
         */
        public function runProtected( test:ITest, p:Protectable ):void
            {
            try
                {
                p.protect();
                }
            catch( afe:AssertionFailedError )
                {
                addFailure( test, afe );
                return;
                }
            catch( e:Error )
                {
                addError( test, e );
                return;
                }
            
            addValid( test );
            }
        
        /**
         * Informs the result that a test will be started.
         */
        public function startTest( test:ITest ):void
            {
            var i:int;
            var count:int = test.countTestCases;
            var listeners:Array = cloneListeners();
            
            //trace( "_runTests: " + _runTests );
            _runTests += count;
            
            for( i=0; i<listeners.length; i++ )
                {
                listeners[i].startTest( test );
                }
            }
        
        /**
         * Marks that the test run should stop.
         */
        public function stop():void
            {
            _stop = true;
            }
        
        /**
         * Returns whether the entire test was successful or not.
         * @return whether the entire test was successful or not.
         */
        public function wasSuccessful():Boolean
            {
            return (failureCount == 0) && (errorCount == 0);
            }
        
        }
    
    }

