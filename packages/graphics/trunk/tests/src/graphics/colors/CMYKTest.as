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

package graphics.colors 
{    import library.ASTUce.framework.TestCase;

    public class CMYKTest extends TestCase 
    {        public function CMYKTest(name:String = "")
        {            super(name);        }
        
        public function testConstructor():void
        {
            var cmyk:CMYK ;
            
            cmyk = new CMYK() ;
            assertNotNull( cmyk , "01-01 - Constructor failed." ) ;
            assertEquals(cmyk.c , 0 , "01-02 Constructor failed with the c parameter.") ;
            assertEquals(cmyk.m , 0 , "01-03 Constructor failed with the m parameter.") ;
            assertEquals(cmyk.y , 0 , "01-04 Constructor failed with the y parameter.") ;
            assertEquals(cmyk.k , 0 , "01-05 Constructor failed with the y parameter.") ;
            
            cmyk = new CMYK(1,1,1,1) ;
            assertNotNull( cmyk     , "02-01 - Constructor failed." ) ;
            assertEquals(cmyk.c , 1 , "02-02 Constructor failed with the c parameter.") ;
            assertEquals(cmyk.m , 1 , "02-03 Constructor failed with the m parameter.") ;
            assertEquals(cmyk.y , 1 , "02-04 Constructor failed with the y parameter.") ;
            assertEquals(cmyk.k , 1 , "02-05 Constructor failed with the y parameter.") ;
        }
        
        public function testInterface():void
        {
            var cmyk:CMYK = new CMYK() ;
            assertTrue( cmyk is ColorSpace ) ;
        }
        
        public function testC():void
        {
            var cmyk:CMYK ;
            
            cmyk = new CMYK() ;
            assertEquals(cmyk.c , 0 , "01 - c property failed.") ;
            
            cmyk.c = 0.5 ;
            assertEquals(cmyk.c , 0.5 , "02 - c property failed.") ;
            
            cmyk.c = 1 ;
            assertEquals(cmyk.c , 1 , "03 - c property failed.") ;
            
            cmyk.c = 2 ;
            assertEquals(cmyk.c , 1 , "04 - c property failed.") ;
        }
        
        public function testM():void
        {
            var cmyk:CMYK ;
            
            cmyk = new CMYK() ;
            assertEquals(cmyk.m , 0 , "01 - m property failed.") ;
            
            cmyk.m = 0.5 ;
            assertEquals(cmyk.m , 0.5 , "02 - m property failed.") ;
            
            cmyk.m = 1 ;
            assertEquals(cmyk.m , 1 , "03 - m property failed.") ;
            
            cmyk.m = 2 ;
            assertEquals(cmyk.m , 1 , "04 - m property failed.") ;
        }
        
        public function testY():void
        {
            var cmyk:CMYK ;
            
            cmyk = new CMYK() ;
            assertEquals(cmyk.y , 0 , "01 - y property failed.") ;
            
            cmyk.y = 0.5 ;
            assertEquals(cmyk.y , 0.5 , "02 - y property failed.") ;
            
            cmyk.y = 1 ;
            assertEquals(cmyk.y , 1 , "03 - y property failed.") ;
            
            cmyk.y = 2 ;
            assertEquals(cmyk.y , 1 , "04 - y property failed.") ;
        }
        
        public function testZ():void
        {
            var cmyk:CMYK;
            
            cmyk = new CMYK() ;
            assertEquals(cmyk.k , 0 , "01 - k property failed.") ;
            
            cmyk.k = 0.5 ;
            assertEquals(cmyk.k , 0.5 , "02 - k property failed.") ;
            
            cmyk.k = 1 ;
            assertEquals(cmyk.k , 1 , "03 - k property failed.") ;
            
            cmyk.k = 2 ;
            assertEquals(cmyk.k , 1 , "04 - k property failed.") ;
        }
        
        public function testClone():void
        {
            var cmyk:CMYK = new CMYK(1,1,1,1) ;
            var clone:CMYK = cmyk.clone() as CMYK ;
            assertNotNull( clone , "01 - clone() failed." ) ;
            assertEquals( cmyk.c , clone.c , "02 - clone() failed.") ;
            assertEquals( cmyk.m , clone.m , "03 - clone() failed.") ;
            assertEquals( cmyk.y , clone.y , "04 - clone() failed.") ;
            assertEquals( cmyk.k , clone.k , "05 - clone() failed.") ;
        }
        
        public function testDifference():void
        {
            var cmyk:CMYK ;
            
            cmyk = new CMYK(1,1,1,1) ;
            cmyk.difference();
            assertEquals(cmyk.c , 0 , "01-01 - difference() failed.") ;
            assertEquals(cmyk.m , 0 , "01-02 - difference() failed.") ;
            assertEquals(cmyk.y , 0 , "01-03 - difference() failed.") ;
            
            cmyk = new CMYK(0,0,0,0) ;
            cmyk.difference();
            assertEquals(cmyk.c , 1 , "02-01 - difference() failed.") ;
            assertEquals(cmyk.m , 1 , "02-02 - difference() failed.") ;
            assertEquals(cmyk.y , 1 , "02-03 - difference() failed.") ;
            assertEquals(cmyk.k , 1 , "02-04 - difference() failed.") ;
        }
        
        public function testEquals():void
        {
            var cmyk1:CMYK = new CMYK( 1   , 1   , 1   , 1   ) ;
            var cmyk2:CMYK = new CMYK( 1   , 1   , 1   , 1   ) ;
            var cmyk3:CMYK = new CMYK( 0.1 , 1   , 1   , 1   ) ;
            var cmyk4:CMYK = new CMYK( 1   , 0.1 , 1   , 1   ) ;
            var cmyk5:CMYK = new CMYK( 1   , 1   , 0.1 , 1   ) ;
            var cmyk6:CMYK = new CMYK( 1   , 1   , 1   , 0.1 ) ;
            
            assertTrue( cmyk1.equals(cmyk1) , "01-01 - equals() failed.") ;
            assertTrue( cmyk1.equals(cmyk2) , "01-02 - equals() failed.") ;
            
            assertFalse( cmyk1.equals(null) , "02-01 - equals() failed.") ;
            assertFalse( cmyk1.equals(2)    , "02-01 - equals() failed.") ;
            
            assertFalse( cmyk1.equals( cmyk3 ) , "03-01 - equals() failed.") ;
            assertFalse( cmyk1.equals( cmyk4 ) , "03-02 - equals() failed.") ;
            assertFalse( cmyk1.equals( cmyk5 ) , "03-03 - equals() failed.") ;
            assertFalse( cmyk1.equals( cmyk6 ) , "03-04 - equals() failed.") ;
        }
        
        public function testInterpolate():void 
        {
           var cmyk1:CMYK = new CMYK(0,0,0,0) ;
           var cmyk2:CMYK = new CMYK(1,1,1,1) ;
           
           var cmyk:CMYK ;
           
           cmyk = cmyk1.interpolate( cmyk2 , 0 ) as CMYK ;
           assertEquals(cmyk , new CMYK(0,0,0,0) , "01 - interpolate() failed.") ;
           
           cmyk = cmyk1.interpolate( cmyk2 )  as CMYK  ;
           assertEquals(cmyk , new CMYK(1,1,1,1) , "02 - interpolate() failed.") ;
           
           cmyk = cmyk1.interpolate( cmyk2 , .5 ) as CMYK  ;
           assertEquals(cmyk , new CMYK(.5,.5,.5,0.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var cmyk:CMYK = new CMYK() ;
            cmyk.set(0.2,0.3,0.4,0.5) ;
            assertEquals(cmyk.c , 0.2 , "01-01 - set() failed.") ;
            assertEquals(cmyk.m , 0.3 , "01-02 - set() failed.") ;
            assertEquals(cmyk.y , 0.4 , "01-03 - set() failed.") ;
            assertEquals(cmyk.k , 0.5 , "01-03 - set() failed.") ;
        }
        
        public function testToObject():void
        {
            var cmyk:CMYK  = new CMYK(0.4,0.5,0.6,0.7) ;
            var o:Object = cmyk.toObject() ;
            assertEquals( cmyk.c , o.c , "01 - toObject() failed.") ;
            assertEquals( cmyk.m , o.m , "02 - toObject() failed.") ;
            assertEquals( cmyk.y , o.y , "03 - toObject() failed.") ;
            assertEquals( cmyk.k , o.k , "03 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var cmyk:CMYK = new CMYK(0.4,0.5,0.6,0.7) ;
            assertEquals( cmyk.toSource() , "new graphics.colors.CMYK(0.4,0.5,0.6,0.7)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var cmyk:CMYK = new CMYK(0.4,0.5,0.6,0.7) ;
            assertEquals( cmyk.toString() , "[CMYK c:0.4 m:0.5 y:0.6 k:0.7]" , "toString() failed.") ;
        }
    }}