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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
package system.rules 
{
    import library.ASTUce.framework.TestCase;

    public class NotEqualsTest extends TestCase 
    {
        public function NotEqualsTest(name:String = "")
        {
            super( name );
        }
        
        public function test1():void
        {
            var ne:NotEquals ;
            
            ne = new NotEquals( 1 , 1 ) ;
            assertFalse( ne.eval() , "#1" ) ;
            
            ne = new NotEquals( 1 , 2 ) ;
            assertTrue( ne.eval() , "#2" ) ;
        }
        
        public function test2():void
        {
            var ne:NotEquals ;
            
            var cond1:Rule = new BooleanRule( true  ) ;
            var cond2:Rule = new BooleanRule( false ) ;
            var cond3:Rule = new BooleanRule( true  ) ;
            
            ne = new NotEquals( cond1 , cond1 ) ;
            assertFalse( ne.eval() , "#1" ) ;
            
            ne = new NotEquals( cond1 , cond2 ) ;
            assertTrue( ne.eval() , "#2" ) ;
            
            ne = new NotEquals( cond1 , cond3 ) ;
            assertFalse( ne.eval() , "#3"  ) ;
        }
        
        public function test3():void
        {
            var ne:NotEquals ;
            
            var equals:Function = function( o:Object ):Boolean
            {
                return this.id == o.id ;
            };
            
            var o1:Object = { id:1 , equals:equals } ;
            var o2:Object = { id:2 , equals:equals } ;
            var o3:Object = { id:1 , equals:equals } ;
            
            ne = new NotEquals( o1 , o1 ) ;
            assertFalse( ne.eval() , "#1" ) ;
            
            ne = new NotEquals( o1 , o2 ) ;
            assertTrue( ne.eval() , "#2" ) ;
            
            ne = new NotEquals( o1 , o3 ) ;
            assertFalse( ne.eval() , "#3" ) ;
        }
    }
}