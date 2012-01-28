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

package graphics 
{
    import library.ASTUce.framework.TestCase;
    
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    
    public class LineStyleTest extends TestCase 
    {
        public function LineStyleTest(name:String = "")
        {
            super( name );
        }
        
        public var style:LineStyle ;
        
        public function setUp():void
        {
            style = new LineStyle(0,0xFFFFFF,0.5,true,"normal", CapsStyle.ROUND ,JointStyle.BEVEL,2) ;
        }
        
        public function tearDown():void
        {
            style = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( style ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( style is ILineStyle ) ;
            assertTrue( style is Geometry   ) ;
        }
        
        public function testEMTPY():void
        {
           assertEquals( LineStyle.EMPTY , new LineStyle() ) ;
        }
        
        public function testClone():void
        {
            var clone:LineStyle = style.clone() as LineStyle ;
            assertNotNull( clone , "clone failed") ;
            assertEquals(clone, style,"clone failed") ;
        }
        
        public function testEquals():void
        {
            assertEquals( style , new LineStyle(0,0xFFFFFF,0.5,true,"normal",CapsStyle.ROUND ,JointStyle.BEVEL,2) ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( style.toSource() , 'new graphics.LineStyle(0,16777215,0.5,true,"normal","round","bevel",2)' ) ;
        }
        
        public function testAlpha():void
        {
            assertEquals( style.alpha , 0.5 , "alpha failed." ) ;
        }
        
        public function testCaps():void
        {
            assertEquals( style.caps , CapsStyle.ROUND , "caps failed." ) ;
        }
        
        public function testColor():void
        {
            assertEquals( style.color , 0xFFFFFF , "color failed." ) ;
        }
        
        public function testJoins():void
        {
            assertEquals( style.joints , JointStyle.BEVEL , "joints failed." ) ;
        }
        
        public function testMiterLimit():void
        {
            assertEquals( style.miterLimit , 2 , "miterLimit failed." ) ;
        }
        
        public function testPixelHinting():void
        {
            assertEquals( style.pixelHinting , true , "pixelHinting failed." ) ;
        }
        
        public function testScaleMode():void
        {
            assertEquals( style.scaleMode , "normal" , "scaleMode failed." ) ;
        }
        
        public function testThickness():void
        {
            assertEquals( style.thickness , 0 , "thickness failed." ) ;
            style.thickness = 10 ;
            assertEquals( style.thickness , 10 , "thickness failed." ) ;
        }
    }
}
