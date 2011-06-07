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
package system.process.logic 
{
    import buRRRn.ASTUce.framework.TestCase;
    import system.logic.ElseIf;
    import system.process.Task;
    import system.process.mocks.MockTask;
    import system.rules.BooleanRule;
    import system.rules.Equals;
    import system.rules.Rule;

    public class ElseIfTest extends TestCase
    {
        
        public function ElseIfTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var ei:ElseIf = new ElseIf() ;
            assertNotNull ( ei , "#1" ) ;
        }
        
        public function testRuleBoolean():void
        {
            var ei:ElseIf ;
            
            ei = new ElseIf( true ) ;
            assertTrue( ei.rule is BooleanRule , "#1"  ) ;
            assertTrue( ((ei.rule) as BooleanRule).condition , "#2"  ) ;
        }
        
        public function testRule():void
        {
            var ru:Rule   = new Equals(1,1) ;
            var ei:ElseIf = new ElseIf( ru ) ;
            
            assertTrue( ei.rule is Equals , "#1"  ) ;
            assertEquals( ru , ei.rule , "#2"  ) ;
        }
        
        public function testThen():void
        {
            var task:Task = new MockTask() ;
            var ei:ElseIf ;
            
            ei = new ElseIf( true , task ) ;
            
            assertNotNull( ei.then  , "#1" ) ;
            assertEquals( task , ei.then  , "#2" ) ;
        }
        
        public function testEval():void
        {
            var ru:Rule   ;
            var ei:ElseIf ;
            
            ru = new Equals(1,1) ;
            ei = new ElseIf( ru ) ;
            assertTrue( ei.eval() , "#1" ) ;
            
            ru = new Equals(1,2) ;
            ei = new ElseIf( ru ) ;
            assertFalse( ei.eval() , "#2" ) ;
        }
    }}