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

package system.data.lists 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.Comparator;
    import system.Sortable;
    import system.comparators.AlphaComparator;
    import system.comparators.NumberComparator;
    import system.comparators.StringComparator;    

    public class SortedArrayListTest extends TestCase 
    {

        public function SortedArrayListTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var list:SortedArrayList ;
            
            list = new SortedArrayList() ;
            assertNotNull( list , "The SortedArrayList constructor failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), [], "01-02 - SortedArrayList constructor failed.") ;
            
            // initialize with an Array
                        
            list = new SortedArrayList([2,3,4]) ; 
            assertNotNull(list, "02-01 - SortedArrayList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "02-02 - SortedArrayList constructor failed.") ;
            
            // initialize with a Collection
            
            list = new SortedArrayList( new SortedArrayList([2,3,4])) ; 
            assertNotNull(list, "03-01 - SortedArrayList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "03-02 - SortedArrayList constructor failed.") ;
            
            // initialize with the capacity value
            
            list = new SortedArrayList( 3 ) ; 
            assertNotNull(list, "04-01 - SortedArrayList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [undefined,undefined,undefined], "04-02 - SortedArrayList constructor failed.") ;            
            
            // initialize with comparator and options
            
            var comp:Comparator = new NumberComparator() ;
            
            list = new SortedArrayList( [4,2,3] , comp , 0 ) ; 
            
            assertNotNull( list                      , "05-01 - SortedArrayList constructor failed." ) ;
            assertEquals( list.comparator , comp     , "05-02 - SortedArrayList constructor failed." ) ;
            assertEquals( list.options    , 0        , "05-03 - SortedArrayList constructor failed." ) ;
            ArrayAssert.assertEquals( list.toArray() , [2,3,4], "05-04 - SortedArrayList constructor failed." ) ;
             
        } 

        public function testInterface():void
        {
            var list:SortedArrayList = new SortedArrayList() ;
            assertTrue( list is Sortable , "SortedArrayList must implement the Sortable interface" ) ;
        }      

        public function testComparator():void
        {
            var s:StringComparator = new StringComparator() ;
            var l:SortedArrayList = new SortedArrayList() ;
            
            l.comparator = s ;
            assertEquals( l.comparator , s , "01 - The SortedArrayList comparator property failed." ) ;
            
            l.comparator = null ;
            assertNull( l.comparator , "02 - The SortedArrayMap SortedArrayList property failed." ) ;
        }
        
        public function testOptions():void
        {
            var l:SortedArrayList = new SortedArrayList() ;
            l.options = 0 ;
            assertEquals( l.options , 0 , "01 - The SortedArrayList options property failed." ) ;
            
            l.options = Array.DESCENDING ;
            assertEquals( l.options , Array.DESCENDING , "02 - The SortedArrayList options property failed." ) ;
        }                

        public function testSort():void
        {
            var list:SortedArrayList ;
            
            list = new SortedArrayList( ["pink" , "red" , "blue" , "black" ] ) ;
            list.sort( new AlphaComparator() ) ;
            assertEquals ( list.toString() , "{black,blue,pink,red}" , "01 - The SortedArrayList sort() method failed." ) ;
            
            list = new SortedArrayList( [ 4 ,3 , 24, 12 ] ) ;
            list.comparator = new NumberComparator() ; 
            assertEquals ( list.toString() , "{3,4,12,24}" , "02 - The SortedArrayList sort() method failed." ) ;
            
        }         
        
        public function testSortOn():void
        {
            var list:SortedArrayList = new SortedArrayList() ;
            
            list.add( { name:'name4' } ) ;
            list.add( { name:'name1' } ) ;
            list.add( { name:'name5' } ) ;
            list.add( { name:'name2' } ) ;
            list.add( { name:'name3' } ) ;
            
            list.sortOn("name", Array.DESCENDING) ;

            assertEquals( (list.get(0)).name , "name5" , "01-01 - The SortedArrayList sortOn() method failed." ) ;
            assertEquals( (list.get(1)).name , "name4" , "01-02 - The SortedArrayList sortOn() method failed." ) ;            
            assertEquals( (list.get(2)).name , "name3" , "01-03 - The SortedArrayList sortOn() method failed." ) ;
            assertEquals( (list.get(3)).name , "name2" , "01-04 - The SortedArrayList sortOn() method failed." ) ;
            assertEquals( (list.get(4)).name , "name1" , "01-05 - The SortedArrayList sortOn() method failed." ) ;
            
            list.sortOn("name") ;

            assertEquals( (list.get(0)).name , "name1" , "02-01 - The SortedArrayList sortOn() method failed." ) ;
            assertEquals( (list.get(1)).name , "name2" , "02-02 - The SortedArrayList sortOn() method failed." ) ;            
            assertEquals( (list.get(2)).name , "name3" , "02-03 - The SortedArrayList sortOn() method failed." ) ;
            assertEquals( (list.get(3)).name , "name4" , "02-04 - The SortedArrayList sortOn() method failed." ) ;
            assertEquals( (list.get(4)).name , "name5" , "02-05 - The SortedArrayList sortOn() method failed." ) ;
            
        } 
        
    }
}
