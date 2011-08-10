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

package system.data.queues 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Comparator;
    import system.comparators.NumberComparator;
    import system.comparators.StringComparator;
    import system.data.collections.ArrayCollection;
    import system.data.maps.ArrayMap;
    
    public class PriorityQueueTest extends TestCase 
    {
        public function PriorityQueueTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var q:PriorityQueue = new PriorityQueue() ;
            
            assertNotNull(q, "01-01 - PriorityQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [], "01-02 - PriorityQueue constructor failed.") ;
            
            // initialize with an Array
            
            q = new PriorityQueue([2,3,4]) ; 
            assertNotNull(q, "02-01 - PriorityQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [2,3,4], "02-02 - PriorityQueue constructor failed.") ;
            
            // initialize with a Collection
            
            q = new PriorityQueue(new ArrayCollection([2,3,4])) ; 
            assertNotNull(q, "03-01 - PriorityQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [2,3,4], "03-02 - PriorityQueue constructor failed.") ;
            
            // initialize with an Iterable object
            
            q = new PriorityQueue(new ArrayMap(["key1","key2","key3"],["value1","value2","value3"])) ; 
            assertNotNull(q, "04-01 - PriorityQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), ["value1","value2","value3"], "04-02 - PriorityQueue constructor failed.") ;
            
            // initialize with a Comparator and an option value.
            
            var c:Comparator = new StringComparator() ;
            
            q = new PriorityQueue(null, c , Array.DESCENDING) ; 
            assertNotNull(q, "05-01 - PriorityQueue constructor failed.") ;
            assertEquals( q.comparator, c, "05-02 - PriorityQueue constructor failed.") ;
            assertEquals( q.options, Array.DESCENDING, "05-03 - PriorityQueue constructor failed.") ;
        }
        
        public function testComparator():void
        {
            var q:PriorityQueue = new PriorityQueue([3,1,2]) ;
            
            q.comparator = new NumberComparator() ;
            
            ArrayAssert.assertEquals( q.toArray(), [1,2,3], "01 - PriorityQueue comparator property failed.") ;
            
            q.comparator = new StringComparator() ;
            
            ArrayAssert.assertEquals( q.toArray(), [3,2,1], "01 - PriorityQueue comparator property failed.") ;
        }
        
        public function testOptions():void
        {
            var c:Comparator    = new NumberComparator() ;
            var q:PriorityQueue = new PriorityQueue([10,2,11,1], c ) ;
            
            q.options = PriorityQueue.NONE ;
            ArrayAssert.assertEquals( q.toArray(), [1,2,10,11], "01 - PriorityQueue options property failed.") ;
            
            q.options = Array.DESCENDING ;
            ArrayAssert.assertEquals( q.toArray(), [11,10,2,1], "02 - PriorityQueue options property failed.") ;
           
            q.options = Array.NUMERIC ;                   
            ArrayAssert.assertEquals( q.toArray(), [1,2,10,11], "03 - PriorityQueue options property failed.") ;
        }
        
        public function testClone():void
        {
            var comp:Comparator = new NumberComparator() ;
            
            var q:PriorityQueue = new PriorityQueue([1,2], comp , Array.DESCENDING) ;
            var c:PriorityQueue = q.clone() as PriorityQueue ;
            
            assertNotNull(c, "01 - The PriorityQueue clone method failed.") ;
            ArrayAssert.assertEquals( c.toArray(), q.toArray(), "02 - PriorityQueue clone method failed.") ;
            
        }
        
        public function testEnqueue():void
        {
            var comp:Comparator = new NumberComparator() ;
            var q:PriorityQueue = new PriorityQueue([1,2], comp , Array.DESCENDING) ;
            
            assertTrue( q.enqueue(4) , "01 - The PriorityQueue enqueue method failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [4,2,1], "02 - PriorityQueue enqueue method failed.") ;
        }
        
        public function testSort():void
        {
            var q:PriorityQueue = new PriorityQueue([1,4,10,2,11,3]) ;
            
            q.sort( Array.DESCENDING ) ;
            
            ArrayAssert.assertEquals( q.toArray(), [4,3,2,11,10,1], "01 - PriorityQueue sort method failed.") ;
            
            q.comparator = new NumberComparator() ;
            
            ArrayAssert.assertEquals( q.toArray(), [1,2,3,4,10,11], "02 - PriorityQueue sort method failed.") ;
        }
    }
}
