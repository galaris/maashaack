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

package graphics.colors 
{    import library.ASTUce.framework.TestCase;

    public class CMYTest extends TestCase 
    {        public function CMYTest(name:String = "")
        {            super(name);        }
        
        public function testConstructor():void
        {
            var cmy:CMY ;
            
            cmy = new CMY() ;
            assertNotNull( cmy , "01-01 - Constructor failed." ) ;
            assertEquals(cmy.c , 0 , "01-02 Constructor failed with the c parameter.") ;
            assertEquals(cmy.m , 0 , "01-03 Constructor failed with the m parameter.") ;
            assertEquals(cmy.y , 0 , "01-04 Constructor failed with the y parameter.") ;
            
            cmy = new CMY(1,1,1) ;
            assertNotNull( cmy     , "02-01 - Constructor failed." ) ;
            assertEquals(cmy.c , 1 , "02-02 Constructor failed with the c parameter.") ;
            assertEquals(cmy.m , 1 , "02-03 Constructor failed with the m parameter.") ;
            assertEquals(cmy.y , 1 , "02-04 Constructor failed with the y parameter.") ;
        }
        
        public function testInterface():void
        {
            var cmy:CMY = new CMY() ;
            assertTrue( cmy is ColorSpace    , "CMY must implements the ColorSpace interface.") ;
        }
        
        public function testC():void
        {
            var cmy:CMY ;
            
            cmy = new CMY() ;
            assertEquals(cmy.c , 0 , "01 - c property failed.") ;
            
            cmy.c = 0.5 ;
            assertEquals(cmy.c , 0.5 , "02 - c property failed.") ;
            
            cmy.c = 1 ;
            assertEquals(cmy.c , 1 , "03 - c property failed.") ;
            
            cmy.c = 2 ;
            assertEquals(cmy.c , 1 , "04 - c property failed.") ;
        }
        
        public function testM():void
        {
            var cmy:CMY ;
            
            cmy = new CMY() ;
            assertEquals(cmy.m , 0 , "01 - m property failed.") ;
            
            cmy.m = 0.5 ;
            assertEquals(cmy.m , 0.5 , "02 - m property failed.") ;
            
            cmy.m = 1 ;
            assertEquals(cmy.m , 1 , "03 - m property failed.") ;
            
            cmy.m = 2 ;
            assertEquals(cmy.m , 1 , "04 - m property failed.") ;
        }
        
        public function testY():void
        {
            var cmy:CMY ;
            
            cmy = new CMY() ;
            assertEquals(cmy.y , 0 , "01 - y property failed.") ;
            
            cmy.y = 0.5 ;
            assertEquals(cmy.y , 0.5 , "02 - y property failed.") ;
            
            cmy.y = 1 ;
            assertEquals(cmy.y , 1 , "03 - y property failed.") ;
            
            cmy.y = 2 ;
            assertEquals(cmy.y , 1 , "04 - y property failed.") ;
        }
        
        public function testClone():void
        {
            var cmy:CMY = new CMY(1,1,1) ;
            var clone:CMY = cmy.clone() as CMY ;
            assertNotNull( clone , "01 - clone() failed." ) ;
            assertEquals(cmy.c , clone.c , "02  - clone() failed.") ;
            assertEquals(cmy.m , clone.m , "03 - clone() failed.") ;
            assertEquals(cmy.y , clone.y , "04 - clone() failed.") ;
        }
        
        public function testDifference():void
        {
            var cmy:CMY ;
            
            cmy = new CMY(1,1,1) ;
            cmy.difference();
            assertEquals(cmy.c , 0 , "01-01 - difference() failed.") ;
            assertEquals(cmy.m , 0 , "01-02 - difference() failed.") ;
            assertEquals(cmy.y , 0 , "01-03 - difference() failed.") ;
            
            cmy = new CMY(0,0,0) ;
            cmy.difference();
            assertEquals(cmy.c , 1 , "02-01 - difference() failed.") ;
            assertEquals(cmy.m , 1 , "02-02 - difference() failed.") ;
            assertEquals(cmy.y , 1 , "02-03 - difference() failed.") ;
        }
        
        public function testEquals():void
        {
            var cmy1:CMY = new CMY( 1   , 1   , 1   ) ;
            var cmy2:CMY = new CMY( 1   , 1   , 1   ) ;
            var cmy3:CMY = new CMY( 0.1 , 1   , 1   ) ;
            var cmy4:CMY = new CMY( 1   , 0.1 , 1   ) ;
            var cmy5:CMY = new CMY( 1   , 1   , 0.1 ) ;
            
            assertTrue( cmy1.equals(cmy1) , "01-01 - equals() failed.") ;
            assertTrue( cmy1.equals(cmy2) , "01-02 - equals() failed.") ;
            
            assertFalse( cmy1.equals(null) , "02-01 - equals() failed.") ;
            assertFalse( cmy1.equals(2)    , "02-01 - equals() failed.") ;
            
            assertFalse( cmy1.equals( cmy3 ) , "03-01 - equals() failed.") ;
            assertFalse( cmy1.equals( cmy4 ) , "03-02 - equals() failed.") ;
            assertFalse( cmy1.equals( cmy5 ) , "03-03 - equals() failed.") ;

        }
        
        public function testInterpolate():void 
        {
           var cmy1:CMY = new CMY(0,0,0) ;
           var cmy2:CMY = new CMY(1,1,1) ;
           
           var cmy:CMY ;
           
           cmy = cmy1.interpolate( cmy2 , 0 ) ;
           assertEquals(cmy , new CMY(0,0,0) , "01 - interpolate() failed.") ;
           
           cmy = cmy1.interpolate( cmy2 ) ;
           assertEquals(cmy , new CMY(1,1,1) , "02 - interpolate() failed.") ;
           
           cmy = cmy1.interpolate( cmy2 , .5 ) ;
           assertEquals(cmy , new CMY(.5,.5,.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var cmy:CMY = new CMY() ;
            cmy.set(0.2,0.3,0.4) ;
            assertEquals(cmy.c , 0.2 , "01-01 - set() failed.") ;
            assertEquals(cmy.m , 0.3 , "01-02 - set() failed.") ;
            assertEquals(cmy.y , 0.4 , "01-03 - set() failed.") ;
        }
        
        public function testToObject():void
        {
            var cmy:CMY  = new CMY(0.4,0.5,0.6) ;
            var o:Object = cmy.toObject() ;
            assertEquals( cmy.c , o.c , "01 - toObject() failed.") ;
            assertEquals( cmy.m , o.m , "02 - toObject() failed.") ;
            assertEquals( cmy.y , o.y , "03 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var cmy:CMY = new CMY(0.4,0.5,0.6) ;
            assertEquals( cmy.toSource() , "new graphics.colors.CMY(0.4,0.5,0.6)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var cmy:CMY = new CMY(0.4,0.5,0.6) ;
            assertEquals( cmy.toString() , "[CMY c:0.4 m:0.5 y:0.6]" , "toString() failed.") ;
        }
    }}