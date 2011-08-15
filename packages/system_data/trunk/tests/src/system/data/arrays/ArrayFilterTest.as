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

package system.data.arrays 
{
    import library.ASTUce.framework.TestCase;
    
    import system.data.arrays.mocks.MockArrayFilterReceiver;
    
    public class ArrayFilterTest extends TestCase 
    {
        public function ArrayFilterTest(name:String = "")
        {
            super( name );
        }
        
        public var af:ArrayFilter ;
        
        public var ml:MockArrayFilterReceiver ;
        
        public function setUp():void
        {
            af = new ArrayFilter() ;
            ml = new MockArrayFilterReceiver(af) ;
        }
        
        public function tearDown():void
        {
            ml.unregister() ;
            ml = undefined ;
            af = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( af , "01-01 - ArrayFilter constructor failed." ) ;
            assertEquals( af.filter , 0 ,  "01-03 - ArrayFilter constructor failed." ) ;
            
            af = new ArrayFilter( ArrayFilter.CASEINSENSITIVE ) ;
            assertNotNull( af , "02-01 - ArrayFilter constructor failed." ) ;
            assertEquals( af.filter , ArrayFilter.CASEINSENSITIVE ,  "02-02 - ArrayFilter constructor failed." ) ;
        }
        
        public function testCASEINSENSITIVE():void
        {
            assertEquals( ArrayFilter.CASEINSENSITIVE , 1 , "The constant ArrayFilter.CASEINSENSITIVE failed." ) ;
        }
        
        public function testDESCENDING():void
        {
            assertEquals( ArrayFilter.DESCENDING , 2 , "The constant ArrayFilter.DESCENDING failed." ) ;  
        }
        
        public function testNONE():void
        {
            assertEquals( ArrayFilter.NONE , 0 , "The constant ArrayFilter.NONE failed." ) ;  
        }
        
        public function testNUMERIC():void
        {
            assertEquals( ArrayFilter.NUMERIC , 16 , "The constant ArrayFilter.NUMERIC failed." ) ;
        }
        
        public function testRETURNINDEXEDARRAY():void
        {
            assertEquals( ArrayFilter.RETURNINDEXEDARRAY , 8 , "The constant ArrayFilter.RETURNINDEXEDARRAY failed." ) ;
        }
        
        public function testUNIQUESORT():void
        {
            assertEquals( ArrayFilter.UNIQUESORT , 4 , "The constant ArrayFilter.UNIQUESORT failed." ) ;
        }
        
        public function testFilter():void
        {
            var af:ArrayFilter ;
            
            af = new ArrayFilter() ;
            
            af.filter = ArrayFilter.NONE ;
            assertEquals( af.filter , ArrayFilter.NONE , "01 - The ArrayFilter filter property failed." ) ;  
            
            af.filter = ArrayFilter.DESCENDING | ArrayFilter.NUMERIC  ;
            assertEquals( af.filter , ArrayFilter.DESCENDING | ArrayFilter.NUMERIC , "02 - The ArrayFilter filter property failed." ) ;
        } 
        
        public function testContains():void
        {
            // test with a specific filter value.
            
            assertFalse
            ( 
                ArrayFilter.contains( ArrayFilter.NUMERIC , ArrayFilter.DESCENDING ) , 
                "01-01 - The ArrayFilter.contains method failed." 
            ) ;
            
            assertFalse
            ( 
                ArrayFilter.contains(ArrayFilter.NUMERIC | Array.NUMERIC , ArrayFilter.DESCENDING )  , 
                "01-02 - The ArrayFilter.contains method failed." 
            ) ;
            
            assertTrue
            ( 
                ArrayFilter.contains(ArrayFilter.NUMERIC | Array.DESCENDING , ArrayFilter.DESCENDING )  , 
                "01-03 - The ArrayFilter.contains method failed." 
            ) ;
            
            assertFalse
            ( 
                ArrayFilter.contains(ArrayFilter.NUMERIC | Array.DESCENDING , 100 )  , 
                "01-04 - The ArrayFilter.contains method failed." 
            ) ;
            
            // test with a NONE(0) filter value.
            
            assertFalse
            ( 
                ArrayFilter.contains(0 , ArrayFilter.NONE ), 
                "02-01 - The ArrayFilter.contains method failed." 
            ) ;
            
            assertFalse
            ( 
                ArrayFilter.contains(0 , ArrayFilter.NUMERIC ), 
                "02-02 - The ArrayFilter.contains method failed." 
             ) ;
            
        }
        
        public function testIsCaseInsensitive():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            assertFalse( af.isCaseInsensitive() , "01 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.setCaseInsensitive(true) ;
            assertTrue( af.isCaseInsensitive() , "02 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.setCaseInsensitive(false) ;
            assertFalse( af.isCaseInsensitive() , "03 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.filter = ArrayFilter.CASEINSENSITIVE ;
            assertTrue( af.isCaseInsensitive() , "04 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.filter = ArrayFilter.NONE ;
            assertFalse( af.isCaseInsensitive() , "05 - The ArrayFilter isCaseInsensitive method failed.") ;
        }
        
        public function testIsDescending():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            assertFalse( af.isDescending() , "01 - The ArrayFilter isDescending method failed.") ;
            
            af.setDescending(true) ;
            assertTrue( af.isDescending() , "02 - The ArrayFilter isDescending method failed.") ;
            
            af.setDescending(false) ;
            assertFalse( af.isDescending() , "03 - The ArrayFilter isDescending method failed.") ;
            
            af.filter = ArrayFilter.DESCENDING ;
            assertTrue( af.isDescending() , "04 - The ArrayFilter isDescending method failed.") ;
            
            af.filter = ArrayFilter.NONE ;
            assertFalse( af.isCaseInsensitive() , "05 - The ArrayFilter isDescending method failed.") ;
        }
        
        public function testIsNone():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            assertTrue( af.isNone() , "01 - The ArrayFilter isNone method failed.") ;
            
            af.filter = ArrayFilter.DESCENDING ;
            af.filter = ArrayFilter.NONE ;
            assertTrue( af.isNone() , "02 - The ArrayFilter isDescending method failed.") ;
            
            af.filter = ArrayFilter.DESCENDING ;
            af.setNone() ;
            assertTrue( af.isNone() , "03 - The ArrayFilter isNone method failed.") ;
        }
        
        public function testIsNumeric():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            assertFalse( af.isNumeric() , "01 - The ArrayFilter isNumeric method failed.") ;
            
            af.setNumeric(true) ;
            assertTrue( af.isNumeric() , "02 - The ArrayFilter isNumeric method failed.") ;
            
            af.setNumeric(false) ;
            assertFalse( af.isNumeric() , "03 - The ArrayFilter isNumeric method failed.") ;
            
            af.filter = ArrayFilter.NUMERIC ;
            assertTrue( af.isNumeric() , "04 - The ArrayFilter isNumeric method failed.") ;
            
            af.filter = ArrayFilter.NONE ;
            assertFalse( af.isNumeric() , "05 - The ArrayFilter isNumeric method failed.") ;
        }
        
        public function testIsReturnIndexedArray():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            assertFalse( af.isReturnIndexedArray() , "01 - The ArrayFilter isReturnIndexedArray method failed.") ;
            
            af.setReturnIndexedArray(true) ;
            assertTrue( af.isReturnIndexedArray() , "02 - The ArrayFilter isReturnIndexedArray method failed.") ;
            
            af.setReturnIndexedArray(false) ;
            assertFalse( af.isReturnIndexedArray() , "03 - The ArrayFilter isReturnIndexedArray method failed.") ;
            
            af.filter = ArrayFilter.RETURNINDEXEDARRAY ;
            assertTrue( af.isReturnIndexedArray() , "04 - The ArrayFilter isReturnIndexedArray method failed.") ;
            
            af.filter = ArrayFilter.NONE ;
            assertFalse( af.isReturnIndexedArray() , "05 - The ArrayFilter isReturnIndexedArray method failed.") ;
        }
        
        public function testIsUniqueSort():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            assertFalse( af.isUniqueSort() , "01 - The ArrayFilter isUniqueSort method failed.") ;
            
            af.setUniqueSort(true) ;
            assertTrue( af.isUniqueSort() , "02 - The ArrayFilter isUniqueSort method failed.") ;
            
            af.setUniqueSort(false) ;
            assertFalse( af.isUniqueSort() , "03 - The ArrayFilter isUniqueSort method failed.") ;
            
            af.filter = ArrayFilter.UNIQUESORT ;
            assertTrue( af.isUniqueSort() , "04 - The ArrayFilter isUniqueSort method failed.") ;
            
            af.filter = ArrayFilter.NONE ;
            assertFalse( af.isUniqueSort() , "05 - The ArrayFilter isUniqueSort method failed.") ;
        }  
        
        public function testNotifyChange():void
        {
            af.notifyChange() ;
            assertTrue( ml.changeCalled , "ArrayFilter notifyChange failed." ) ;
        }
        
        public function testSetCaseInsensitive():void
        {
            // init
                 
            af.filter = ArrayFilter.NUMERIC ;
            
            // first affectation
                        
            ml.reset() ;
            af.setCaseInsensitive(true) ;
           
            assertTrue( ml.changeCalled , "01-01 - ArrayFilter setCaseInsensitive failed." ) ;
            assertTrue( af.isCaseInsensitive() , "01-02 - The ArrayFilter setCaseInsensitive method failed.") ;
            
            // affectation the same filter
            
            ml.reset() ;
            af.setCaseInsensitive(true) ;
           
            assertFalse( ml.changeCalled , "02-01 - ArrayFilter setCaseInsensitive failed." ) ;
            assertTrue( af.isCaseInsensitive() , "02-02 - The ArrayFilter setCaseInsensitive method failed.") ;
            
            // reset affectation
            
            ml.reset() ;
            af.setCaseInsensitive(false) ;
           
            assertTrue( ml.changeCalled , "03-01 - ArrayFilter setCaseInsensitive failed." ) ;
            assertFalse( af.isCaseInsensitive() , "03-02 - The ArrayFilter setCaseInsensitive method failed.") ;
        }
        
        public function testSetDescending():void
        {
            // init
            
            af.filter = ArrayFilter.NUMERIC ;
            
            // first affectation
            
            ml.reset() ;
            af.setDescending(true) ;
           
            assertTrue( ml.changeCalled , "01-01 - ArrayFilter setDescending failed." ) ;
            assertTrue( af.isDescending() , "01-02 - The ArrayFilter setDescending method failed.") ;
            
            // affectation the same filter
            
            ml.reset() ;
            af.setDescending(true) ;
           
            assertFalse( ml.changeCalled , "02-01 - ArrayFilter setDescending failed." ) ;
            assertTrue( af.isDescending() , "02-02 - The ArrayFilter setDescending method failed.") ;  
            
            // reset affectation
            
            ml.reset() ;
            af.setDescending(false) ;
           
            assertTrue( ml.changeCalled , "03-01 - ArrayFilter setDescending failed." ) ;
            assertFalse( af.isDescending() , "03-02 - The ArrayFilter setDescending method failed.") ;
        }
        
        public function testSetNone():void
        {
            // init
                 
            af.filter = ArrayFilter.NUMERIC ;
            
            // first affectation
            
            ml.reset() ;
            af.setNone() ;
           
            assertTrue( ml.changeCalled , "01-01 - ArrayFilter setNone failed." ) ;
            assertTrue( af.isNone() , "01-02 - The ArrayFilter setNone method failed.") ;
            
            // affectation the same filter
            
            ml.reset() ;
            af.setNone() ;
           
            assertFalse( ml.changeCalled , "02-01 - ArrayFilter setNone failed." ) ;
            assertTrue( af.isNone() , "02-02 - The ArrayFilter setNone method failed.") ;  
        }
        
        public function testSetNumeric():void
        {
            // init
            
            af.filter = ArrayFilter.CASEINSENSITIVE ;
            
            // first affectation
            
            ml.reset() ;
            af.setNumeric(true) ;
           
            assertTrue( ml.changeCalled , "01-01 - ArrayFilter setNumeric failed." ) ;
            assertTrue( af.isNumeric() , "01-02 - The ArrayFilter setNumeric method failed.") ;
            
            // affectation the same filter
            
            ml.reset() ;
            af.setNumeric(true) ;
           
            assertFalse( ml.changeCalled , "02-01 - ArrayFilter setNumeric failed." ) ;
            assertTrue( af.isNumeric() , "02-02 - The ArrayFilter setNumeric method failed.") ;
            
            // reset affectation
            
            ml.reset() ;
            af.setNumeric(false) ;
           
            assertTrue( ml.changeCalled , "03-01 - ArrayFilter setNumeric failed." ) ;
            assertFalse( af.isNumeric() , "03-02 - The ArrayFilter setNumeric method failed.") ;
        }
        
        public function testSetReturnIndexedArray():void
        {
            // init
            
            af.filter = ArrayFilter.CASEINSENSITIVE ;
            
            // first affectation
            
            ml.reset() ;
            af.setReturnIndexedArray(true) ;
           
            assertTrue( ml.changeCalled , "01-01 - ArrayFilter setReturnIndexedArray failed." ) ;
            assertTrue( af.isReturnIndexedArray() , "01-02 - The ArrayFilter setReturnIndexedArray method failed.") ;
            
            // affectation the same filter
            
            ml.reset() ;
            af.setReturnIndexedArray(true) ;
            
            assertFalse( ml.changeCalled , "02-01 - ArrayFilter setReturnIndexedArray failed." ) ;
            assertTrue( af.isReturnIndexedArray() , "02-02 - The ArrayFilter setReturnIndexedArray method failed.") ;  
            
            // reset affectation
            
            ml.reset() ;
            af.setReturnIndexedArray(false) ;
            
            assertTrue( ml.changeCalled , "03-01 - ArrayFilter setReturnIndexedArray failed." ) ;
            assertFalse( af.isReturnIndexedArray() , "03-02 - The ArrayFilter setNumeric setReturnIndexedArray failed.") ;
        }
        
        public function testSetUniqueSort():void
        {
            // init
            
            af.filter = ArrayFilter.CASEINSENSITIVE ;
            
            // first affectation
            
            ml.reset() ;
            af.setUniqueSort(true) ;
           
            assertTrue( ml.changeCalled , "01-01 - ArrayFilter setUniqueSort failed." ) ;
            assertTrue( af.isUniqueSort() , "01-02 - The ArrayFilter setUniqueSort method failed.") ;
            
            // affectation the same filter
            
            ml.reset() ;
            af.setUniqueSort(true) ;
           
            assertFalse( ml.changeCalled , "02-01 - ArrayFilter setUniqueSort failed." ) ;
            assertTrue( af.isUniqueSort() , "02-02 - The ArrayFilter setUniqueSort method failed.") ;
            
            // reset affectation
            
            ml.reset() ;
            af.setUniqueSort(false) ;
           
            assertTrue( ml.changeCalled , "03-01 - ArrayFilter setUniqueSort failed." ) ;
            assertFalse( af.isUniqueSort() , "03-02 - The ArrayFilter setUniqueSort method failed.") ;
        }
        
        public function testToSource():void
        {
            af.filter = ArrayFilter.NONE ;
            assertEquals
            ( 
                af.toSource() , 
                'new system.data.arrays.ArrayFilter(0)' , 
                "01 - The ArrayFilter toSource failed." 
            ) ;
            
            af.filter = ArrayFilter.NUMERIC ;
            assertEquals
            ( 
                af.toSource() , 
                'new system.data.arrays.ArrayFilter(16)' , 
                "02 - The ArrayFilter toSource failed." 
            ) ;
            
            af.filter = ArrayFilter.CASEINSENSITIVE | ArrayFilter.DESCENDING ;
            assertEquals
            ( 
                af.toSource() , 
                'new system.data.arrays.ArrayFilter(3)' , 
                "03 - The ArrayFilter toSource failed." 
            ) ;
            
        }
        
        public function testToString():void
        {
            af.filter = ArrayFilter.NONE ;
            assertEquals
            ( 
                af.toString() , 
                '[ArrayFilter 0]' , 
                "01 - The ArrayFilter toString failed." 
            ) ;
            
            af.filter = ArrayFilter.NUMERIC ;
            assertEquals
            ( 
                af.toString() , 
                '[ArrayFilter 16]' ,
                "02 - The ArrayFilter toString failed." 
            ) ;
            
            af.filter = ArrayFilter.CASEINSENSITIVE | ArrayFilter.DESCENDING ;
            assertEquals
            ( 
                af.toString() , 
                '[ArrayFilter 3]' ,
                "03 - The ArrayFilter toString failed." 
            ) ;
        }
    }
}
