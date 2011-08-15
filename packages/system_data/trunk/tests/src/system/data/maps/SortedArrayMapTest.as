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

package system.data.maps 
{
    import library.ASTUce.framework.TestCase;
    
    import system.Sortable;
    import system.comparators.NumberComparator;
    import system.comparators.StringComparator;
    import system.data.Iterator;
    import system.data.Map;    

    public class SortedArrayMapTest extends TestCase 
    {

        public function SortedArrayMapTest(name:String = "")
        {
            super(name);
        }
        
        public var m:SortedArrayMap ;

        public function setUp():void
        {
            m = new SortedArrayMap() ;
        }

        public function tearDown():void
        {
            m = undefined ;
        }          
        
        public function testCASEINSENSITIVE():void
        {
            assertEquals( SortedArrayMap.CASEINSENSITIVE , 1 , "SortedArrayMap.CASEINSENSITIVE value failed." ) ;
        }

        public function testDESCENDING():void
        {
            assertEquals( SortedArrayMap.DESCENDING , 2 , "SortedArrayMap.DESCENDING value failed." ) ;
        }
        
        public function testKEY():void
        {
            assertEquals( SortedArrayMap.KEY , "key" , "SortedArrayMap.KEY value failed." ) ;
        }                

        public function testNONE():void
        {
            assertEquals( SortedArrayMap.NONE , 0 , "SortedArrayMap.NONE value failed." ) ;
        }    
     
        public function testNUMERIC():void
        {
            assertEquals( SortedArrayMap.NUMERIC , 16 , "SortedArrayMap.NUMERIC value failed." ) ;
        }       

        public function testRETURNINDEXEDARRAY():void
        {
            assertEquals( SortedArrayMap.RETURNINDEXEDARRAY , 8 , "SortedArrayMap.RETURNINDEXEDARRAY value failed." ) ;
        }    
        
        public function testUNIQUESORT():void
        {
            assertEquals( SortedArrayMap.UNIQUESORT , 4 , "SortedArrayMap.UNIQUESORT value failed." ) ;
        }  
        
        public function testVALUE():void
        {
            assertEquals( SortedArrayMap.VALUE , "value" , "SortedArrayMap.VALUE value failed." ) ;
        }
        
        public function testConstructor():void
        {
            var map:SortedArrayMap = new SortedArrayMap( ["key1","key2"] , ["value1","value2"] ) ;
            
            assertNotNull( map , "0 - The SortedArrayMap constructor failed." ) ;
            
            assertEquals( map.sortBy , SortedArrayMap.KEY,  "0 - The SortedArrayMap constructor failed, the sortBy property must be initialize with the 'key' flag." ) ;
            
            assertEquals( map.get("key1") , "value1" , "1 - The SortedArrayMap constructor failed : map.get('key1')." ) ;
            assertEquals( map.get("key2") , "value2" , "2 - The SortedArrayMap constructor failed : map.get('key2')." ) ;        
            
            var m1:SortedArrayMap = new SortedArrayMap() ;
            assertEquals( m1.size() , 0 , "3 - The SortedArrayMap constructor failed." ) ;
            
            var m2:SortedArrayMap = new SortedArrayMap( null , ["value1", "value2"] ) ;
            assertEquals( m2.size() , 0 , "4 - The SortedArrayMap constructor failed." ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( m is Sortable , "SortedArrayMap must implement the system.Sortable interface." ) ;   
        }
        
        public function testComparator():void
        {
            var s:StringComparator = new StringComparator() ;
                
            m.comparator = s ;
            assertEquals( m.comparator , s , "01 - The SortedArrayMap comparator property failed." ) ;
            
            m.comparator = null ;
            assertNull( m.comparator , "02 - The SortedArrayMap comparator property failed." ) ;
        }
        
        public function testOptions():void
        {
            
            m.options = SortedArrayMap.CASEINSENSITIVE ;
            assertEquals( m.options , SortedArrayMap.CASEINSENSITIVE , "01 - The SortedArrayMap options property failed." ) ;
            
            m.options = SortedArrayMap.DESCENDING ;
            assertEquals( m.options , SortedArrayMap.DESCENDING , "02 - The SortedArrayMap options property failed." ) ;
            
            m.options = SortedArrayMap.NONE ;
            assertEquals( m.options , SortedArrayMap.NONE , "03 - The SortedArrayMap options property failed." ) ;
            
            m.options = SortedArrayMap.NUMERIC ;
            assertEquals( m.options , SortedArrayMap.NUMERIC , "04 - The SortedArrayMap options property failed." ) ;
            
            m.options = SortedArrayMap.RETURNINDEXEDARRAY;
            assertEquals( m.options , SortedArrayMap.RETURNINDEXEDARRAY , "05 - The SortedArrayMap options property failed." ) ;
            
            m.options = SortedArrayMap.UNIQUESORT;
            assertEquals( m.options , SortedArrayMap.UNIQUESORT , "06 - The SortedArrayMap options property failed." ) ;
            
            m.options = SortedArrayMap.DESCENDING | SortedArrayMap.CASEINSENSITIVE ;
            assertEquals( m.options , SortedArrayMap.DESCENDING | SortedArrayMap.CASEINSENSITIVE , "06 - The SortedArrayMap options property failed." ) ;            
            
        }                

        public function testSortBy():void
        {
            m.sortBy = SortedArrayMap.KEY ;
            assertEquals( m.sortBy , SortedArrayMap.KEY , "01 - The SortedArrayMap sortBy property failed." ) ;
            
            m.sortBy = SortedArrayMap.VALUE ;
            assertEquals( m.sortBy , SortedArrayMap.VALUE , "02 - The SortedArrayMap sortBy property failed." ) ;
            
            m.sortBy = "test" ;
            assertEquals( m.sortBy , SortedArrayMap.KEY , "03 - The SortedArrayMap sortBy property failed." ) ;

            m.sortBy = null ;
            assertEquals( m.sortBy , SortedArrayMap.KEY , "04 - The SortedArrayMap sortBy property failed." ) ;            
            
        }
        
        public function testSort():void
        {
            var map:SortedArrayMap = new SortedArrayMap() ;
            
            map.put( 1 , 4 ) ;
            map.put( 3 , 2 ) ;
            map.put( 4 , 3 ) ;
            map.put( 2 , 1 ) ;
            
            map.comparator = new NumberComparator() ;
            
            map.options = SortedArrayMap.DESCENDING ;
            map.sort() ;
            
            assertEquals
            ( 
                map.toString() , 
                "{4:3,3:2,2:1,1:4}" , 
                "01 - The SortedArrayMap sort() method failed with sortBy='key'." 
            ) ;
            
            map.options = SortedArrayMap.NONE ;
            map.sort() ;

            assertEquals
            ( 
                map.toString() , 
                "{1:4,2:1,3:2,4:3}" , 
                "02 - The SortedArrayMap sort() method failed with sortBy='key'." 
            ) ;
            
            map.sortBy = SortedArrayMap.VALUE ;
            
            map.options = SortedArrayMap.DESCENDING ;
            map.sort() ;
            
            assertEquals
            ( 
                map.toString() , 
                "{1:4,4:3,3:2,2:1}" , 
                "03 - The SortedArrayMap sort() method failed with sortBy='value'." 
            ) ;            
            
            map.options = SortedArrayMap.NONE ;
            map.sort() ;
            
            assertEquals
            ( 
                map.toString() , 
                "{2:1,3:2,4:3,1:4}" , 
                "04 - The SortedArrayMap sort() method failed with sortBy='value'." 
            ) ;              
            
        }         
        
        public function testSortOn():void
        {
            var map:SortedArrayMap = new SortedArrayMap() ;
            
            map.put( { id:5 } , { name:'name4' } ) ;
            map.put( { id:1 } , { name:'name1' } ) ;
            map.put( { id:3 } , { name:'name5' } ) ;
            map.put( { id:2 } , { name:'name2' } ) ;
            map.put( { id:4 } , { name:'name3' } ) ;
            
            var formatResult:Function = function( map:Map ):String
            {
            
                var vit:Iterator = map.iterator() ;
                var kit:Iterator = map.keyIterator() ;
                var str:String = "{" ;
            
                var key:*   ;
                var value:* ;
                
                while( vit.hasNext() )
                {
                    value = vit.next() ;
                    key   = kit.next() ;
                    str += key.id + ":" + value.name ;
                    if (vit.hasNext())
                    {
                        str += "," ;
                    }
                }
                str += "}" ;
                return str ;
            };
            
            // original Map
            
            assertEquals
            (
                formatResult( map ) ,
                "{5:name4,1:name1,3:name5,2:name2,4:name3}" ,
                "01 - The SortedArrayMap sortOn() method failed."
            ) ;
            
            // sort by key with sort() method
            
            map.sortBy = SortedArrayMap.KEY ; // default
            map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
            map.sortOn("id") ;

            assertEquals
            (
                formatResult( map ) ,
                "{5:name4,4:name3,3:name5,2:name2,1:name1}" ,
                "02 - The SortedArrayMap sortOn() method failed."
            ) ;            
            
            map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
            map.sortOn("id") ;
            
            assertEquals
            (
                formatResult( map ) ,
                "{5:name4,4:name3,3:name5,2:name2,1:name1}" ,
                "03 - The SortedArrayMap sortOn() method failed."
            ) ;             
            
            // sort by value with sort() method
            
            map.sortBy = SortedArrayMap.VALUE ;
            map.options = SortedArrayMap.DESCENDING ;
            map.sortOn("name") ;
                        
            assertEquals
            (
                formatResult( map ) ,
                "{3:name5,5:name4,4:name3,2:name2,1:name1}" ,
                "04 - The SortedArrayMap sortOn() method failed."
            ) ;             
                        
            map.options = SortedArrayMap.NONE ;
            map.sortOn("name") ;
            
            assertEquals
            (
                formatResult( map ) ,
                "{1:name1,2:name2,4:name3,5:name4,3:name5}" ,
                "04 - The SortedArrayMap sortOn() method failed."
            ) ;                
            
        }        
        
    }
}
