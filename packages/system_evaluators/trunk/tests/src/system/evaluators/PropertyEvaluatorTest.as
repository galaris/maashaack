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

package system.evaluators 
{
    import library.ASTUce.framework.TestCase;

    /**
     * The PropertyEvaluatorTest test case.
     */
    public class PropertyEvaluatorTest extends TestCase 
    {
        /**
         * Creates a new PropertyEvaluatorTest instance.
         */
        public function PropertyEvaluatorTest(name:String = "")
        {
            super(name);
        }
        
        public var obj:Object ;
        public var e1:PropertyEvaluator ;
        public var e2:PropertyEvaluator ; 
        
        public function setUp():void
        {
            obj = 
            {
                message : "hello world", 
                title   : "my title", 
                menu    :
                {
                    title : "my menu title", label : "my label"
                }
            };
                
            e1 = new PropertyEvaluator() ;
            e2 = new PropertyEvaluator(obj) ;
        }
        
        public function teadDown():void
        {
            obj = null ;
            e1  = null ;
            e2  = null ;
        }
        
        public function testInstances():void
        {
            assertNotNull(e1, "01 - The PropertyEvaluator instance not must be null.") ;
            assertNotNull(e2, "01 - The PropertyEvaluator instance not must be null.") ;
            assertTrue(e1 is Evaluable, "The PropertyEvaluator instance implements IEvaluator failed.") ;
        }
        
        public function testEvalValidExpression():void
        {
            var expression:String ;
            
            expression = "message" ;
            assertEquals(obj.message, e2.eval(expression), "01.1 - The eval method failed with the expression : '" + expression + "'") ;
                
            expression = "title" ;
            assertEquals(obj.title, e2.eval(expression), "01.2 - The eval method failed with the expression : '" + expression + "'") ;
            
            expression = "menu.title" ;
            assertEquals(obj.menu.title, e2.eval(expression), "01.3 - The eval method failed with the expression : '" + expression + "'") ;
            
            expression = "menu.label" ;
            assertEquals(obj.menu.label, e2.eval(expression), "01.4 - The eval method failed with the expression : '" + expression + "'") ;
        }
        
        public function testEvalInvalidExpression():void
        {
            var expression:String ;
            
            expression = "unknow" ;
            assertNull(e2.eval(expression), "02.1 - The eval method failed with the expression : '" + expression + "'") ;
            
            expression = "menu.unknow" ;
            assertNull(e2.eval(expression), "02.2 - The eval method failed with the expression : '" + expression + "'") ;
            
            expression = "" ;
            assertNull(e2.eval(expression), "02.3 - The eval method failed with the expression : '" + expression + "'") ;  
        }
        
        public function testEvalUndefineable():void
        {
            var expression:String ;
            
            e2.undefineable = "empty" ;
            
            expression = "unknow" ;
            assertEquals(e2.undefineable, e2.eval(expression), "03 - The eval method failed with the expression : '" + expression + "'") ;
        }
        
        public function testEvalThrowError():void
        {
            var expression:String ;
            
            e2.throwError = true ;
            
            try
            {    
                e2.eval("unknow") ;
                fail("04.1 - The eval method failed with the expression : '" + expression + "' the throwError mode is true and an exception must be throwing.") ;
            }
            catch( e:Error )
            {
                assertEquals("EvalError: [object PropertyEvaluator] eval failed with the expression : unknow", e.toString(), "04.2 - The eval method failed with the expression : '" + expression + "'") ;                    
            }
        }
    }
}