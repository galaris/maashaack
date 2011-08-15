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
package graphics.filters 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;

    import system.process.Lockable;

    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.filters.BitmapFilter;
    import flash.filters.BlurFilter;
    import flash.filters.DropShadowFilter;

    public class FiltersTest extends TestCase 
    {
        public function FiltersTest(name:String = "")
        {
            super(name);
        }
        
        public var display:DisplayObject ;
        
        public var filter1:BitmapFilter ;
        public var filter2:BitmapFilter ;
        
        public var filters:Filters ;
        
        public function setUp():void
        {
            display = new Shape() ;
            filters = new Filters( display ) ;
            filter1 = new DropShadowFilter() ;
            filter2 = new BlurFilter() ;
        }
        
        public function tearDown():void
        {
            display = null ;
            filters = null ;
            filter1 = null ;
            filter2 = null ;
        }
        
        public function testInterface():void
        {
            assertTrue( filters is Lockable ) ; 
        }
        
        public function testConstructor():void
        {
            assertNotNull( filters ) ;
            assertEquals( filters.display , display ) ;
        }
        
        public function testConstructorEmptyArgument():void
        {
            filters = new Filters() ;
            assertNotNull( filters ) ;
        }
        
        public function testDisplay():void
        {
            assertEquals( filters.display , display ) ;
            filters.display = null ;
            assertNull( filters.display ) ;
        }
        
        public function testNumFilters():void
        {
            assertEquals( filters.numFilters , 0 , "01 - numFilters failed.") ;
            filters.addFilter( filter1 ) ;
            assertEquals( filters.numFilters , 1 , "02 - numFilters failed.") ;
            filters.addFilter( filter1 ) ;
            assertEquals( filters.numFilters , 1 , "02 - numFilters failed.") ;
            filters.addFilter( filter2 ) ;
            assertEquals( filters.numFilters , 2 , "03 - numFilters failed.") ;
        }
        
        public function testAddFilter():void
        {
            assertTrue( filters.addFilter( filter1 ) ) ;
            assertFalse( filters.addFilter( filter1 ) ) ;
        }
        
        public function testHasFilter():void
        {
            assertFalse( filters.hasFilter( filter1 ) ) ;
            filters.addFilter( filter1 ) ;
            assertTrue( filters.hasFilter( filter1 ) ) ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( filters.isEmpty() ) ;
            filters.addFilter( filter1 ) ;
            assertFalse( filters.isEmpty() ) ;
        }
        
        public function testLockable():void
        {
            assertFalse( filters.isLocked() ) ;
            filters.lock() ;
            assertTrue( filters.isLocked() ) ;
            filters.unlock() ;
            assertFalse( filters.isLocked() ) ;
        }
        
        public function testRemoveFilter():void
        {
            filters.addFilter( filter1 ) ;
            assertTrue( filters.removeFilter( filter1 ) ) ;
            assertFalse( filters.removeFilter( filter1 ) ) ;
            assertTrue( filters.isEmpty() ) ;
            filters.addFilter( filter1 ) ;
            filters.addFilter( filter2 ) ;
            assertTrue( filters.removeFilter() ) ;
            assertTrue( filters.isEmpty() ) ;
        }
        
        public function testSynchronise():void
        {
            display.filters = [ filter1 , filter2 ] ;
            filters.synchronise() ;
            ArrayAssert.assertEquals( filters.toArray() , display.filters ) ;
        }
        
        public function testUpdate():void
        {
            filters.addFilter( filter1 ) ;
            filters.addFilter( filter2 ) ;
            filters.update() ;
            ArrayAssert.assertEquals( filters.toArray() , display.filters ) ;
            //filters.removeFilter() ;
            //assertNull( display.filters ) ;
        }
    }
}
