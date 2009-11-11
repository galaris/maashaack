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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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
	import flash.display.JointStyle;
	import flash.display.CapsStyle;
    import buRRRn.ASTUce.framework.TestCase;

    public class LineStyleTest extends TestCase 
    {
        public function LineStyleTest(name:String = "")
        {
            super( name );
        }
        
        public var style:LineStyle ;
        
        public function setUp():void
        {
            style = new LineStyle(0,0xFFFFFF,0.5,true,"normal",CapsStyle.ROUND ,JointStyle.BEVEL,2) ;
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
        }
        
        public function testEMTPY():void
        {
            assertEquals( LineStyle.EMPTY.thickness    ,      NaN , "01 - EMPTY.thickness failed." ) ;
            assertEquals( LineStyle.EMPTY.color        ,        0 , "02 - EMPTY.color failed." ) ;
            assertEquals( LineStyle.EMPTY.alpha        ,        1 , "03 - EMPTY.alpha failed." ) ;
            assertEquals( LineStyle.EMPTY.pixelHinting ,    false , "04 - EMPTY.pixelHinting failed." ) ;
            assertEquals( LineStyle.EMPTY.scaleMode    , "normal" , "05 - EMPTY.scaleMode failed." ) ;
            assertEquals( LineStyle.EMPTY.caps         ,     null , "06 - EMPTY.caps failed." ) ;
            assertEquals( LineStyle.EMPTY.joints       ,     null , "07 - EMPTY.joints failed." ) ;
            assertEquals( LineStyle.EMPTY.miterLimit   ,        3 , "08 - EMPTY.miterLimit failed." ) ;
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
    }
}
