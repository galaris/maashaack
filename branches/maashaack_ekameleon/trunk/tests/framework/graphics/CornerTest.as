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

package graphics 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    
    public class CornerTest extends TestCase 
    {
        public function CornerTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var corner:Corner ;
            
            corner = new Corner() ;
            assertNotNull(corner, "01-01 - Corner constructor failed.") ;
            assertTrue(corner.tl, "01-02 - Corner constructor failed.") ;
            assertTrue(corner.tr, "01-03 - Corner constructor failed.") ;
            assertTrue(corner.br, "01-04 - Corner constructor failed.") ;
            assertTrue(corner.bl, "01-05 - Corner constructor failed.") ;
            
            corner = new Corner(false, false, false, false) ;
            assertNotNull(corner, "02-01 - Corner constructor failed.") ;
            assertFalse(corner.tl, "02-02 - Corner constructor failed.") ;
            assertFalse(corner.tr, "02-03 - Corner constructor failed.") ;
            assertFalse(corner.br, "02-04 - Corner constructor failed.") ;
            assertFalse(corner.bl, "02-05 - Corner constructor failed.") ;
        }
        
        public function testInterface():void
        {
            var corner:Corner = new Corner() ;
            assertTrue( corner is Cloneable    , "Corner must implements the Cloneable interface.") ;
            assertTrue( corner is Equatable    , "Corner must implements the Equatable interface.") ;
            assertTrue( corner is Serializable , "Corner must implements the Serializable interface.") ;
        }
        
        public function clone():void
        {
            var corner:Corner = new Corner(false, true, false, true) ;
            var clone:Corner  = corner.clone() as Corner ;
            assertNotNull(clone  , "01 - Corner clone failed.") ;
            assertFalse(clone.tl , "02 - Corner clone failed.") ;
            assertTrue(clone.tr  , "03 - Corner clone failed.") ;
            assertFalse(clone.br , "04 - Corner clone failed.") ;
            assertTrue(clone.bl  , "05 - Corner clone failed.") ;
        }
        
        public function testEquals():void
        {
            var c1:Corner = new Corner() ;
            var c2:Corner = new Corner(true  , true  , true  , true  ) ;
            var c3:Corner = new Corner(false , true  , true  , true  ) ;
            var c4:Corner = new Corner(true  , false , true  , true  ) ;
            var c5:Corner = new Corner(false , true  , false , true  ) ;
            var c6:Corner = new Corner(false , true  , true  , false ) ;
            var c7:Corner = new Corner(false , false , false , false ) ;
            
            assertTrue( c1.equals(c1) , "01-01 - Corner.equals failed.") ;
            assertTrue( c1.equals(c2) , "01-02 - Corner.equals failed.") ;
            
            assertFalse( c1.equals(c3) , "02-01 - Corner.equals failed.") ;
            assertFalse( c1.equals(c4) , "02-02 - Corner.equals failed.") ;
            assertFalse( c1.equals(c5) , "02-03 - Corner.equals failed.") ;
            assertFalse( c1.equals(c6) , "02-04 - Corner.equals failed.") ;
            assertFalse( c1.equals(c7) , "02-05 - Corner.equals failed.") ;
        }
        
        public function testToSource():void
        {
            var c:Corner = new Corner(false , false , false , false ) ;
            assertEquals( c.toSource(), "new graphics.Corner(false,false,false,false)", "Corner.toSource failed.") ;
        }
        
        public function testToString():void
        {
            var c:Corner = new Corner(false , false , true , false ) ;
            assertEquals( c.toString(), "[Corner tl:false tr:false br:true bl:false]", "Corner.toString failed.") ;
        }
    }
}
