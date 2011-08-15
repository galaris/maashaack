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

package graphics.geom 
{
    import library.ASTUce.framework.TestCase;
    
    public class Matrix2Test extends TestCase 
    {
        
        public function Matrix2Test(name:String = "")
        {
            super( name );
        }
        
        public var m:Matrix2;
        
        public function setUp():void
        {
            m = new Matrix2() ;
        }
        
        public function tearDown():void
        {
            m = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( m as Matrix2, "constructor failed") ;
            
//            // use four arguments to fill the Matrix2 object
//            
//            m = new Matrix2( 1, 2, 3, 4 ) ;
//            trace( m ) ;
//            
//            // use two Vector2 arguments to fill the 2 columns of the Matrix2 object
//            
//            m = new Matrix2( new Vector2(1,3) , new Vector2(2,4) ) ;
//            trace( m ) ;
//            
//            // use the angle argument
//            
//            m = new Matrix2( 0 ) ;
//            trace( m ) ;
//            
//            m = new Matrix2( 12 ) ;
//            trace( m ) ;
//            
//            // use a Matrix2 to initialize the new Matrix2
//            
//            m = new Matrix2( new Matrix2(1,2,3,4) ) ;
//            trace( m ) ;
            
        }
        
        public function testInterfaces():void
        {
            assertTrue( m is Geometry  , "implements Geometry failed.") ;
        }   
        
        public function testToSource():void
        {
            assertEquals( m.toSource() , "new graphics.geom.Matrix2(1,0,0,1)", "toSource failed : " + m.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( m.toString() , "[Matrix2:[1,0],[0,1]]", "toString failed : " + m.toString() ) ;
        }
        
        public function testClone():void
        {
            var clone:Matrix2 = m.clone() ;
            assertNotNull( clone as Matrix2 , "Matrix2 clone method failed." ) ;
        }
        
        public function testEquals():void
        {
            var ve:Matrix2 = new Matrix2() ;
            assertTrue( m.equals(ve) , "Matrix2 equals method failed.") ;
        }
        
        public function testN11():void
        {
            assertEquals( m.n11, 1, "MA2_08 - n11 property failed : " + m.n11 ) ;
        }
        
        public function testN12():void
        {
            assertEquals( m.n12, 0, "MA2_09 - n12 property failed : " + m.n12 ) ;
        }
        
        public function testN21():void
        {
            assertEquals( m.n21, 0, "MA2_08 - n21 property failed : " + m.n21 ) ;
        }
        
        public function testN22():void
        {   
            assertEquals( m.n22, 1, "MA2_09 - n22 property failed : " + m.n22 ) ;
        }
        
    }
 
}
