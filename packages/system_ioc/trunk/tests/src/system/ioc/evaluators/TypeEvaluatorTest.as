/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/
package system.ioc.evaluators
{
    import buRRRn.ASTUce.framework.TestCase;

    import system.data.maps.HashMap;
    import system.evaluators.Evaluable;
    import system.ioc.ObjectConfig;
    import system.ioc.TypePolicy;
    
    public class TypeEvaluatorTest extends TestCase
    {
        public function TypeEvaluatorTest(name:String = "")
        {
            super(name);
        }
        
        HashMap ; // enforce linkage
        
        public var evaluator:TypeEvaluator ;
        
        public function setUp():void
        {
            var config:ObjectConfig = new ObjectConfig() ;
            
            config.typePolicy = TypePolicy.ALL ; 
            config.typeAliases =
            [
                { alias:"ObjectConfig" , type:"system.ioc.ObjectConfig" }
            ] ;
            
            config.typeExpression   =
            [
                { name:"map"     , value:"system.data.maps" } ,
                { name:"HashMap" , value:"{map}.HashMap"  }
            ] ;
            
            evaluator = new TypeEvaluator( config ) ;
        }
        
        public function tearDown():void
        {
            evaluator = null ;
        }
        
        public function testInterface():void
        {
            assertTrue( evaluator is Evaluable ) ;
        }
        
        public function testEval():void
        {
            assertEquals( ObjectConfig , evaluator.eval( "ObjectConfig" ) ) ;
            assertEquals( HashMap      , evaluator.eval( "{HashMap}" ) ) ;
            
            assertNull( evaluator.eval( "unknow" ) ) ;
            assertNull( evaluator.eval( "{map}.unknow" ) ) ;
        }
        
        public function testEvalThrowError():void
        {
            evaluator.throwError = true ;
            
            try
            {
                evaluator.eval( "unknow" ) ;
                fail("#1 Must notify an EvalError.") ;
            }
            catch( er:Error )
            {
                assertTrue( er is EvalError , "#2" ) ;
            }
        }
    }
}
