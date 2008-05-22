/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.evaluators
    {
    import buRRRn.ASTUce.framework.TestCase;

    public class EdenEvaluatorTest extends TestCase
        {
        
        private var _EE:EdenEvaluator;
        
        public function EdenEvaluatorTest( name:String="" )
            {
            super(name);
            }
        
        public function setUp():void
            {
            _EE = new EdenEvaluator();
            }
        
        public function testSimpleExpressions():void
            {
            assertEquals( "true", _EE.eval( "true" ) );
            assertEquals( "0.5", _EE.eval( "0.5" ) );
            //assertEquals( "5", _EE.eval( "5" ) ); //BUG: eden should return 5
            //assertEquals( "LE", _EE.eval( "\"le\".toUpperCase()" ) ); //BUG: eden should return "LE"
            }
        
        }
    }

