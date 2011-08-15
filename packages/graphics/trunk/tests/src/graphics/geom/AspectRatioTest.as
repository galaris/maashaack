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
    
    public class AspectRatioTest extends TestCase 
    {
        public function AspectRatioTest( name:String = "" )
        {
            super( name );
        }
        
        public var ar:AspectRatio;
        
        public function setUp():void
        {
            ar = new AspectRatio(320,240) ;
        }
        
        public function tearDown():void
        {
            ar = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( ar, "01 - constructor is null") ;
            
            assertTrue( ar is Dimension   , "02 - constructor is an instance of Dimension." ) ;
            assertTrue( ar is AspectRatio , "03 - constructor is an instance of AspectRatio." ) ;
            
            var ar1:AspectRatio = new AspectRatio() ;
            
            ar1.verbose = true ;
            
            assertEquals( ar1.width  , 0 , "04_01 - constructor failed with 0 argument : " + ar1) ;
            assertEquals( ar1.height , 0 , "04_02 - constructor failed with 0 argument : " + ar1) ;
            
            assertEquals( ar.width  , 320, "05_01 - constructor failed : " + ar) ;
            assertEquals( ar.height , 240, "06_01 - constructor failed : " + ar) ;
        }
        
        public function testGcd():void
        {
            
            assertEquals( ar.gcd , 80 , "01 - AspectRatio gcd property failed." ) ;
            
            var a:AspectRatio = new AspectRatio(0,0) ;
            
            assertEquals( a.gcd , 0 , "02 - AspectRatio gcd property failed." ) ;
        }
        
        public function testHeight():void
        {
            assertEquals( ar.height , 240 , "01 - AspectRatio height property failed." ) ;
            
            ar.lock() ;
            ar.width = 640 ;
            assertEquals( ar.height , 480 , "02 - AspectRatio height property failed." ) ;
            
            ar.unlock() ;
            ar.height = 500 ;
            ar.width  = 320 ;
            assertEquals( ar.height , 500 , "03 - AspectRatio height property failed." ) ;
            
            ar.height = 240 ;
            assertEquals( ar.height , 240 , "04 - AspectRatio height property failed." ) ;
        }
        
        public function testVerbose():void
        {
            // test verbose and toString()
            ar.verbose = true ;
            assertEquals( ar.toString() , "[AspectRatio width:320 height:240 ratio:{4:3}]" , "01 - AspectRatio verbose property failed." ) ;
            ar.verbose = false ;
            assertEquals( ar.toString() , "4:3" , "02 - AspectRatio verbose property failed." ) ;
        }
        
        public function testWidth():void
        {
            
            assertEquals( ar.width , 320 , "01 - AspectRatio width property failed." ) ;
            
            ar.lock() ;
            ar.height = 480 ;
            assertEquals( ar.width , 640 , "02 - AspectRatio width property failed." ) ;
            
            ar.unlock() ;
            ar.width  = 1000 ;
            ar.height = 240 ;            
            assertEquals( ar.width , 1000 , "03 - AspectRatio width property failed." ) ;
            
            ar.width = 320 ;
            assertEquals( ar.width , 320 , "04 - AspectRatio width property failed." ) ;
            
        }          
          
        public function testClone():void
        {
            var clone:AspectRatio = ar.clone( ) as AspectRatio ;
            
            assertNotNull( clone, "01 - AspectRatio clone method failed.") ;
            
            assertEquals( ar.width  , clone.width  , "02 - AspectRatio clone method failed." ) ;
            assertEquals( ar.height , clone.height , "03 - AspectRatio clone method failed." ) ;
            assertNotSame( ar , clone , "04 - AspectRatio clone method failed." ) ;
            
        }
        
        public function testEquals():void
        {
            var a:* = new AspectRatio( 320 , 240 ) ;
            var b:* = new AspectRatio( 640 , 480 ) ;
            var c:* = new AspectRatio( 200 , 480 ) ;
            var d:* = new Array() ;
            var e:* = null ;
            
            assertTrue( ar.equals(a) , "01-01 - AspectRatio equals method failed.") ;
            assertTrue( ar.equals(b) , "01-02 - AspectRatio equals method failed.") ;
            
            assertFalse( ar.equals(c) , "02 - AspectRatio equals method failed.") ;
            assertFalse( ar.equals(d) , "03 - AspectRatio equals method failed.") ;
            assertFalse( ar.equals(e) , "04 - AspectRatio equals method failed.") ;
        }
        
        public function testIsLocked():void
        {
            
            // test lock(), unlock() and isLocked() methods
            
            assertFalse(ar.isLocked(), "01 - AspectRatio isLocked method failed.") ;
            
            ar.lock() ;
            
            assertTrue(ar.isLocked(), "02 - AspectRatio isLocked method failed.") ;
            
            ar.unlock() ;
            
            assertFalse(ar.isLocked(), "03 - AspectRatio isLocked method failed.") ;
        }
    }
}