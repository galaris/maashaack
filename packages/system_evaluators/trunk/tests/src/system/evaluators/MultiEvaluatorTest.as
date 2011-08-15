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
    
    import system.evaluators.samples.CustomEvaluator;
    
    /**
     * The MultiEvaluatorTest test case.
     */
    public class MultiEvaluatorTest extends TestCase 
    {
        /**
         * Creates a new MultiEvaluatorTest instance.
         */
        public function MultiEvaluatorTest(name:String = "")
        {
            super(name);
        }
        
        public var evaluator:MultiEvaluator ;
        
        public function setUp():void
        {
            evaluator = new MultiEvaluator() ;
        }
        
        public function testConstructor():void
        {
            var e:MultiEvaluator = new MultiEvaluator(new CustomEvaluator()) ;
            
            assertNotNull(evaluator, "01 - The MultiEvaluator instance not must be null.") ;
            assertNotNull(e, "02 - The MultiEvaluator instance not must be null.") ;
        }
        
        public function testInterface():void
        {
            assertTrue(evaluator is Evaluable ) ;
        }
        
        public function testAutoClear():void
        {
            assertFalse(evaluator.autoClear, "#1") ;
            
            evaluator.autoClear = true ;
            
            assertTrue(evaluator.autoClear, "#2") ;
            
            evaluator.autoClear = false ;
            
            assertFalse(evaluator.autoClear, "#3") ;
        }
        
        public function testAdd():void
        {
            var c1:CustomEvaluator = new CustomEvaluator() ;
            var c2:CustomEvaluator = new CustomEvaluator() ;
            var c3:CustomEvaluator = new CustomEvaluator() ;
            var c4:CustomEvaluator = new CustomEvaluator() ;
            var c5:CustomEvaluator = new CustomEvaluator() ;
            var c6:CustomEvaluator = new CustomEvaluator() ;
            var c7:CustomEvaluator = new CustomEvaluator() ;
            
            var e:MultiEvaluator = new MultiEvaluator() ;
            e.add(c1) ;
            assertEquals(e.size() , 1 , "#1");
            e.add(c2,c3,c4) ;
            assertEquals(e.size() , 4 , "#2");
            e.add([c5,c6],c7) ;
            assertEquals(e.size() , 7 , "#3");
            e.add() ;
            assertEquals(e.size() , 7 , "#4");
            e.add("hello world") ;
            assertEquals(e.size() , 7 , "#5");
            e.clear() ;
        }
        
        public function testClear():void
        {
            var c:CustomEvaluator = new CustomEvaluator() ;
            var e:MultiEvaluator = new MultiEvaluator(c) ;
            e.clear() ;
            assertEquals(e.size() , 0 , "The MultiEvaluator clear method failed, the evaluator must be empty.");
        }
        
        public function testEval():void
        {
            var c:CustomEvaluator = new CustomEvaluator() ;
            var e:MultiEvaluator = new MultiEvaluator(c) ;
            assertEquals(e.eval("hello world") , "hello world" , "The MultiEvaluator eval method failed.");
        }
        
        public function testRemove():void
        {
            var c:CustomEvaluator = new CustomEvaluator() ;
            var e:MultiEvaluator = new MultiEvaluator() ;
            e.add(c) ;
            e.remove(c) ;
            assertEquals(e.size() , 0 , "The MultiEvaluator remove method failed.");
        }
        
        public function testSize():void
        {
            var c1:CustomEvaluator = new CustomEvaluator() ;
            var c2:CustomEvaluator = new CustomEvaluator() ;
            var e:MultiEvaluator = new MultiEvaluator(c1) ;
            e.add(c2) ;
            assertEquals(e.size() , 2 , "The MultiEvaluator size method failed.");
        } 
    }
}