
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
     * An ITest can be run and collect its results.
     * @see TestResult
     */
    public interface ITest
        {
        
        /**
         * Counts the number of test cases that will be run by this test.
         */
        function get countTestCases():int;
        
        //function get name():String;
        
        /**
         * Runs a test and collects its result in a TestResult instance.
         */
        function run( result:TestResult ):void;
        
        /**
         * Returns a string representation of the object.
         * Returns a string representation of the object.
         */
        function toString( ...args ):String;
        
        }
    
    }

