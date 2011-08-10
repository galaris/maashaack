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
 
package system.reflection 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Enum;
    
    public class MemberTypeTest extends TestCase 
    {
        public function MemberTypeTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var mt:MemberType = new MemberType(10,"hello") ;
            assertNotNull( mt                  , "01 - MemberType constructor failed.") ;
            assertEquals( String(mt) , "hello" , "02 - MemberType constructor failed.") ;
            assertEquals( int(mt)    , 10      , "03 - MemberType constructor failed.") ;
        }
        
        public function testInherit():void
        {
            var mt:MemberType = new MemberType(10,"hello") ;
            assertTrue( mt is Enum , "MemberType must extends the Enum class.") ;
        }
        
        public function testVariable():void
        {
            assertEquals( String(MemberType.variable) , "variable" , "01 - MemberType.variable failed.") ;
            assertEquals( int(MemberType.variable)    , 1          , "02 - MemberType.variable failed.") ;
        }
        
        public function testConstant():void
        {
            assertEquals( String(MemberType.constant) , "constant" , "01 - MemberType.constant failed.") ;
            assertEquals( int(MemberType.constant)    , 2          , "02 - MemberType.constant failed.") ;
        }
        
        public function testAccessor():void
        {
            assertEquals( String(MemberType.accessor) , "accessor" , "01 - MemberType.accessor failed.") ;
            assertEquals( int(MemberType.accessor)    , 3          , "02 - MemberType.accessor failed.") ;
        }
        
        public function testmethod():void
        {
            assertEquals( String(MemberType.method) , "method" , "01 - MemberType.method failed.") ;
            assertEquals( int(MemberType.method)    , 4        , "02 - MemberType.method failed.") ;
        }
    }
}
