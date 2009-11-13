
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
     * TestWarning, an enclosure for information on tests that generate warnings.
     */
    public class TestWarning extends TestCase
        {
        
        /**
         * @private
         */
        private var _message:String;
        
        /**
         * @private
         */
        private var _detail:String;
        
        /**
         * Creates a new TestWarning instance.
         */
        public function TestWarning( message:String = "", detail:String = "" )
            {
            super( "warning" );
            _message = message;
            _detail  = detail;
            }
        
        /**
         * Runs the test.
         */
        protected override function runTest():void
            {
            fail( _detail );
            }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString( ...args ):String
            {
            return name + "(" + _message + ")";
            }
        
        }
    }

