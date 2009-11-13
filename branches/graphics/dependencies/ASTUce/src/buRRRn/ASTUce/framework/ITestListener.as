
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
     * A Listener for test progress.
     */
    public interface ITestListener
        {
        
        /**
         * An error occurred.
         */
        function addError( test:ITest, e:Error ):void;
        
        /**
         * A failure occurred.
         */
        function addFailure( test:ITest, afe:AssertionFailedError ):void;
        
        /**
         * A valid test occurred.
         */
        function addValid( test:ITest ):void;
        
        /**
         * A test ended.
         */
        function endTest( test:ITest ):void;
        
        /**
         * A test started.
         */
        function startTest( test:ITest ):void;
        
        }
    
    }

