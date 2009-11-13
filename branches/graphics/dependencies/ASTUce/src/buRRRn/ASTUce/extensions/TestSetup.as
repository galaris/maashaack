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
     * A Decorator to set up and tear down additional fixture state.
     * Subclass TestSetup and insert it into your tests when you want to set up additional state once before the tests are run.
     */
    public class TestSetup extends TestDecorator
        {
        
        /**
         * Creates a new TestSetup instance.
         */
        public function TestSetup( test:ITest )
            {
            super( test );
            }
        
        /**
         * Runs the TestSetup.
         */
        public override function run( result:TestResult ):void
            {
            var self:TestSetup = this;
            var p:Protectable = new Protectable();
                p.protect = function():void
                    {
                    self["setUp"]();
                    self["basicRun"]( result );
                    self["tearDown"]();
                    };
            
            result.runProtected( this, p );
            }
        
        /**
         * Sets up the fixture.
         * <p><b>Implement as :</b></p>
         * <pre class="prettyprint">
         * public function setUp():void
         *     {
         *     //...
         *     }
         * </pre>
         * <p>To set up additional fixture state.</p>
         */
        prototype.setUp = function():void
            {
            
            };
        
        /**
         * Tears down the fixture. Implement as :
         * <pre class="prettyprint">
         * public function tearDown():void
         *     {
         *     //...
         *     }
         * </pre>
         * to tear down additional fixture state.
         */
        prototype.tearDown = function():void
            {
            
            };
        
        }
    
    }

