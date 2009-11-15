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
     * A TestCase that expects an Error of class _expected to be thrown. The other way to check that an expected error is thrown is:
     * <pre class="prettyprint">
     * try
     *     {
     *     shouldThrow();
     *     }
     * catch( e:SpecialError )
     *     {
     *     return;
     *     }
     *     fail( "Expected SpecialError" );
     * </pre>
     * <p>To use ErrorTestCase, create a TestCase like : </p>
     * <pre class="prettyprint">
     * new ErrorTestCase( "testShouldThrow", SpecialError );
     * </pre>
     */
    public class ErrorTestCase extends TestCase
        {
        
        /**
         * @private
         */
        private var _expected:Class;
        
        /**
         * Creates a new ErrorTestCase instance.
         * @param name the name of the test case.
         * @param The error class.
         */
        public function ErrorTestCase( name:String = "", error:Class = null )
            {
            super( name );
            _expected = error;
            }
        
        /**
         * Run the test.
         */
        protected override function runTest():void
            {
            try
                {
                super.runTest();
                }
            catch( e:* )
                {
                if( e is _expected )
                    {
                    return;
                    }
                else
                    {
                    throw e;
                    }
                }
            
            fail( "Expected exception " + _expected );
            }
        
        }
    
    }

