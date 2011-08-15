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

package system 
{
    import library.ASTUce.framework.TestCase;
    
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    public class ByteArraysTest extends TestCase 
    {
        public function ByteArraysTest(name:String = "")
        {
            super(name);
        }
        
        public function testClone():void
        {
            var ba0:ByteArray = new ByteArray();
            var ba1:ByteArray;
            
            ba0.writeByte( 1 );
            ba0.writeByte( 2 );
            ba0.writeByte( 3 );
            ba0.writeByte( 4 );
            ba0.writeByte( 5 );
            
            ba1 = ByteArrays.clone( ba0 ) as ByteArray;
            
            assertNotNull( ba1 , "01 - ByteArrays.clone failed.");
            assertEquals( ba0.position , ba1.position , "02 - ByteArrays.clone failed.");
        }
        
        public function testClone2():void
        {
            var bmd:BitmapData = new BitmapData(80, 40, true);
            var seed:int = int(Math.random() * int.MAX_VALUE);
            bmd.noise(seed);
            var bounds:Rectangle = new Rectangle(0, 0, bmd.width, bmd.height);
            var pixels:ByteArray = bmd.getPixels(bounds);
            pixels.position = 2 ;
            var clone:ByteArray = ByteArrays.clone( pixels ) as ByteArray ;
            assertNotNull( clone , "01 - ByteArrays.clone failed.") ;
            assertEquals( pixels.position , clone.position , "02 - ByteArrays.clone failed.") ;
        }
        
        public function testEquals():void
        {
            var bmd:BitmapData = new BitmapData(80, 40, true);
            var seed:int = int(Math.random() * int.MAX_VALUE);
            bmd.noise(seed);
            var bounds:Rectangle = new Rectangle(0, 0, bmd.width, bmd.height);
            var pixels:ByteArray = bmd.getPixels(bounds);
            var clone:ByteArray = ByteArrays.clone( pixels ) as ByteArray ;
            assertTrue( ByteArrays.equals( clone, pixels ) , "01 - ByteArrays.equals failed.") ;
            clone.clear() ;
            assertFalse( ByteArrays.equals( clone, pixels ) , "02 - ByteArrays.equals failed.") ;
            pixels.clear() ;
            assertTrue( ByteArrays.equals( clone, pixels ) , "03 - ByteArrays.equals failed.") ;
        }
        
    }
}
