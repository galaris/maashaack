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
    import graphics.Geometry;

    import library.ASTUce.framework.TestCase;

    import flash.geom.Rectangle;

    public class DimensionTest extends TestCase 
    {
        public function DimensionTest( name:String = "" )
        {
            super( name );
        }
        
        public var d:Dimension;
        
        public function setUp():void
        {
            d = new Dimension(100,200) ;
        }
        
        public function tearDown():void
        {
            d = undefined ;
        }
        
        public function testConstructor():void
        {
            var dim:Dimension = new Dimension() ;
            assertEquals( dim.width  , 0 , "01 - failed" ) ;
            assertEquals( dim.height , 0 , "02 - failed") ;
        }
        
        public function testConstructorWithDimensionArgument():void
        {
            var dim:Dimension = new Dimension( d ) ;
            assertEquals( dim.width  , 100, "01 - failed with a Dimension argument.") ;
            assertEquals( dim.height , 200, "02 - failed with a Dimension argument.") ;
        }
        
        public function testConstructorWithWidthHeightArguments():void
        {
            var dim:Dimension = new Dimension( 50 , 60 ) ;
            assertEquals( dim.width  , 50, "failed with a width value in the first argument.") ;
            assertEquals( dim.height , 60, "failed with a height value in the second argument.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( d is Geometry  , "implements Geometry failed.") ;
        }
        
        public function testToSource():void
        {
            assertEquals( d.toSource() , "new graphics.geom.Dimension(100,200)", "DIM_03 - toSource failed : " + d.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( d.toString() , "[Dimension width:100 height:200]", "DIM_04 - toString failed : " + d.toString() ) ;
        }
        
        public function testWidth():void
        {
            assertEquals( d.width , 100, "DIM_05 - width property failed : " + d.width ) ;
        }
        
        public function testHeight():void
        {
            assertEquals( d.height , 200, "DIM_06 - height property failed : " + d.height ) ;
        }
        
        public function testClone():void
        {
            var clone:Dimension = d.clone() ;
            clone.width = 10 ;
            clone.height = 20 ;
            assertTrue( clone is Dimension , "DIM_09 - clone method failed, must return a Dimension reference." ) ;
            assertFalse( d.width == clone.width, "DIM_09 - clone property failed, d.width:" + d.width + " must be different of clone.width:" + clone.width ) ;
            assertFalse( d.height == clone.height, "DIM_09 - clone property failed, d.height:" + d.height + " must be different of clone.height:" + clone.height ) ;
        }
        
        public function testDecreaseSize():void
        {
            var clone:Dimension = d.clone() ;
            clone.decreaseSize( new Dimension(50,50) ) ;
            assertEquals( clone.width, 50, "DIM_11_01 - decreaseSize method failed, width : " + clone.width ) ;
            assertEquals( clone.height, 150, "DIM_11_02 - decreaseSize method failed, height : " + clone.height ) ;
        }
        
        public function testEquals():void
        {
            var e:Dimension = new Dimension(100, 200) ;
            assertTrue( d.equals(e) , "DIM_12 - equals method failed.") ;
        }
        
        public function testGetBounds():void
        {
            var bounds:Rectangle = d.getBounds(10, 40) ;
            assertTrue( bounds is Rectangle, "DIM_13_01 - getBounds method failed, the method must return a Rectangle reference.") ;    
            assertEquals( bounds.x, 10, "DIM_13_02 - getBounds method failed, x : " + bounds.x ) ;
            assertEquals( bounds.y, 40, "DIM_13_03 - getBounds method failed, y : " + bounds.y ) ;
            assertEquals( bounds.width, 100, "DIM_13_04 - getBounds method failed, width : " + bounds.width ) ;
            assertEquals( bounds.height, 200, "DIM_13_05 - getBounds method failed, height : " + bounds.height ) ;
        }
        
        public function testIncreaseSize():void
        {
            var clone:Dimension = d.clone() ;
            clone.increaseSize( new Dimension(50,50) ) ;
            assertEquals( clone.width, 150, "DIM_14_01 - increaseSize method failed, width : " + clone.width ) ;
            assertEquals( clone.height, 250, "DIM_14_02 - increaseSize method failed, height : " + clone.height ) ;
        }
        
        public function testSetSize():void
        {
            var clone:Dimension = d.clone() ;
            clone.setSize(250,250) ;
            assertEquals( clone.width, 250, "DIM_15_01 - setSize method failed, width : " + clone.width ) ;
            assertEquals( clone.height, 250, "DIM_15_02 - setSize method failed, height : " + clone.height ) ;
        }
    }
}