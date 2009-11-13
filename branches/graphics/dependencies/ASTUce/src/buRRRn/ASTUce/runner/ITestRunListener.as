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
package buRRRn.ASTUce.runner
    {
    
    /**
     * A listener interface for observing the execution of a test run.
     */
    public interface ITestRunListener
        {
        
        /**
         * Invoked when the test is ended.
         */
        function testEnded( testName:String ):void        
        
        /**
         * Invoked when the test is failed.
         */
        function testFailed( status:TestRunStatus, testName:String, trace:String ):void        
        
        /**
         * Invoked when the test process is ending.
         */  
        function testRunEnded( elapsedTime:Number ):void        
        
        /**
         * Invoked when the test process is started.
         */
        function testRunStarted( testSuiteName:String, testCount:int ):void
        
        /**
         * Invoked when the test process is stopped.
         */
        function testRunStopped( elapsedTime:Number ):void
        
        /**
         * Invoked when the test is started.
         */
        function testStarted( testName:String ):void
        
        }
    
    }

