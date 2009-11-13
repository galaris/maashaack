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
    import flash.utils.getTimer;
    
    import buRRRn.ASTUce.framework.TestCase;
    
    /**
     * A TestCase that expects to run its tests within a maximum elapsed time (timeout).
     * <p>To use TimedTestCase, create a TestCase like : </p>
     * <pre class="prettyprint">
     * class MyTimedTest extends TimedTestCase
     *    {
     *     
     *     public function MyTimedTest( name:String = "", timeout:int = 100 )
     *        {
     *        super( name, timeout );
     *        }
     *     
     *     public function testSomething():void
     *        {
     *        //some asserts here
     *        }
     *     
     *     public function testOtherthing():void
     *        {
     *        //some other asserts here
     *        }
     *     
     *     }
     * </pre>
     * <p>After, if you want to pass all your test cases in a test suite :</p>
     * <pre class="prettyprint">
     * var suite:TestSuite = new TestSuite( "Timed Tests" );
     * suite.addTestSuite( MyTimedTest );
     * suite.addTest( new MyTimedTest( "testSomething", 50 ) );
     * </pre>
     * <p><b>Notes :</b> You can access the elapsedTime within the test.</p>
     * <pre class="prettyprint">
     *   public function testSomething():void
     *       {
     *       trace( "elapsed: " + elapsedTime );
     *       }
     * </pre>
     * <p>- the elapsedTime variable will be unique for each tests run.</p>
     * <p>- you can define the global default timeout in the TimedTestCase as a static property</p>
     * <pre class="prettyprint">
     *   TimedTestCase.timeout = 500;
     * </pre>
     * <p>This global timeout allow you to create your timed test case without the need of a timeout argument.</p>
     * <pre class="prettyprint">
     *   TimedTestCase.timeout = 500;
     *   
     *   class MyTimedTest extends TimedTestCase
     *       {
     *        
     *       public function MyTimedTest( name:String = "" )
     *          {
     *         super( name );
     *          }
     *       ...
     *       //by default each tests will run with a timeout of 500ms
     *       }
     * </pre>
     */
    public class TimedTestCase extends TestCase
        {
        
        /**
         * @private
         */
        private static var _timeout:int = 100; //default

        /**
         * @private
         */
        private var _maxElapsedTime:int;

        /**
         * @private
         */
        private var _startTime:int;
       
        /**
         * @private
         */
        private var _elapsedTime:int;
        
        /**
         * @private
         */
        private var _timeExceeded:Boolean;
        
        /**
         * Creates a new TimedTestCase instance.
         * @param name The name of the TestCase.
         * @param maxElapsedTime The max elapsed time of this TestCase.
         */
        public function TimedTestCase( name:String = "", maxElapsedTime:int = -1 )
            {
            super( name );
            
            if( maxElapsedTime < 0 )
                {
                maxElapsedTime = timeout;
                }
            
            _maxElapsedTime = maxElapsedTime;
            _elapsedTime    = 0;
            _timeExceeded   = false;
            }
        
        /**
         * Indicates the elapsedTime value of this TestCase.
         */
        protected function get elapsedTime():int
            {
             if( _elapsedTime == 0 )
                {
                _elapsedTime = getTimer() - _startTime;
                }
            
            return _elapsedTime;
            }        
        
        /**
         * The timeout value of this timed TestCase.
         */
        public static function get timeout():int
            {
            return _timeout;
            }
        
        /**
         * @private
         */
        public static function set timeout( milliseconds:int ):void
            {
            if( milliseconds < 0 )
                {
                milliseconds = -milliseconds;
                }
            
            _timeout = milliseconds;
            }
        
        /**
         * Runs the test.
         */
        protected override function runTest():void
            {
            _startTime = getTimer();
            
            super.runTest();
            
            if( elapsedTime > _maxElapsedTime )
                {
                _timeExceeded = true;
                fail( "Maximum elapsed time (" + _maxElapsedTime + " ms) exceeded!" );
                }
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString( ...args ):String
            {
            if( _timeExceeded )
                {
                return super.toString() + " (exceeded: " + elapsedTime + " ms)";
                }
            
            return super.toString() + " (timed: " + elapsedTime + " ms)";
            }
        
        }
    
    }

