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

package system.data.sets 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Set;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayIterator;
    
    public class HashSetTest extends TestCase 
    {
        public function HashSetTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var s:HashSet = new HashSet() ;
            
            assertNotNull(s, "#01-01") ;
            ArrayAssert.assertEquals( s.toArray(), [], "#01-02") ;
            
            // initialize with an Array
            
//            var s1:HashSet ;
//            s1 = new HashSet([2,3,4]) ; 
//            assertNotNull(s1, "02-01 - HashSet constructor failed.") ;
//            ArrayAssert.assertEquals( s1.toArray(), [2,3,4], "02-02 - HashSet constructor failed.") ;
//            
//            // initialize with a Collection
//            
//            var s2:HashSet ;
//            
//            s2 = new HashSet(s1) ; 
//            assertNotNull(s2, "03-01 - HashSet constructor failed.") ;
//            ArrayAssert.assertEquals( s2.toArray(), [2,3,4], "03-02 - HashSet constructor failed.") ;
//            
//            // initialize with an Iterable object
//            
//            s2 = new HashSet( new ArrayMap(["key1","key2"], ["value1","value2"]) as Iterable ) ; 
//            assertNotNull(s2, "04-01 - HashSet constructor failed.") ;
//            assertEquals(s2.size(), 2 , "04-02 - HashSet constructor failed.") ;
            
            // duplicate entries
            
//            var co3:HashSet = new HashSet([1,1,2,3,4,4,5,5,5]) ; 
//            assertNotNull(co3, "#05-01") ;
//            ArrayAssert.assertEquals( co3.toArray(), [1,2,3,4,5], "#05-02") ;
        }
        
        public function testInterface():void
        {
            var s:HashSet = new HashSet() ;
            assertTrue( s is Set          , "01") ;
            assertTrue( s is Collection   , "02") ;
            assertTrue( s is Cloneable    , "03") ;
            assertTrue( s is Equatable    , "04") ;
            assertTrue( s is Iterable     , "05") ;
            assertTrue( s is Serializable , "06") ; 
        }
        
        public function testAdd():void 
        {
            var s:HashSet = new HashSet() ;
            assertTrue  ( s.add(2)         , "01" ) ;
            assertFalse ( s.add(2)         , "02" ) ;
            assertTrue  ( s.add(null)      , "03" ) ;
            assertFalse ( s.add(undefined) , "04" ) ;
        }
        
        public function testClear():void
        {
            var s:HashSet = new HashSet([2,3,4]) ;
            var old:int = s.size() ;
            s.clear() ; 
            assertTrue( old > s.size(), "01") ;
            ArrayAssert.assertEquals( s.toArray(), [], "02") ;
            assertTrue( s.isEmpty(), "03") ;
        }
        
        public function testClone():void
        {
            var s:HashSet = new HashSet([2,3,4]) ;
            var clone:HashSet = s.clone() as HashSet ;
            assertNotNull( clone, "01") ;
            assertFalse( clone == s, "02") ;  
            ArrayAssert.assertEquals( clone.toArray(), s.toArray(), "03") ;
        }
        
        public function testContains():void 
        {
            var s:HashSet = new HashSet() ;
            s.add("item") ;
            assertTrue( s.contains("item") ,  "01") ;
            assertFalse( s.contains("test") ,  "02") ;
        }
        
        public function testEquals():void
        {
            
            var s1:HashSet = new HashSet([1,2,3,4]) ;
            var s2:HashSet = new HashSet([1,2,3,4]) ;
            var s3:HashSet = new HashSet([2,3]) ;
            var s4:HashSet = new HashSet([5,6,7,8]) ;
            
            assertTrue  ( s1.equals(s1) , "01-01" ) ;
            assertTrue  ( s1.equals(s2) , "01-02" ) ;
            assertFalse ( s1.equals(s3) , "01-03" ) ;
            assertFalse ( s1.equals(s4) , "01-04" ) ; // same size
            
            assertTrue  ( s2.equals(s1) , "02-01" ) ;
            assertTrue  ( s2.equals(s2) , "02-02" ) ;
            assertFalse ( s2.equals(s3) , "02-03" ) ;
            assertFalse ( s3.equals(s4) , "02-04" ) ;
            
            assertFalse ( s3.equals(s1) , "03-01" ) ;
            assertFalse ( s3.equals(s2) , "03-02" ) ;
            assertTrue  ( s3.equals(s3) , "03-03" ) ;
            assertFalse ( s3.equals(s4) , "03-04" ) ;
            
            var c:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            assertFalse ( s1.equals(c) , "04" ) ;
            
        }
        
        public function testGet():void
        {
            var s:HashSet = new HashSet() ;
            s.add("test") ;
            assertEquals( s.get(0) , "test" ,  "01") ;
            assertUndefined( s.get(1)       ,  "02" ) ;
        }
        
        public function testIndexOf():void
        {
            var s:HashSet = new HashSet() ;
            s.add("item1") ;
            
            assertEquals( s.indexOf("item4") , -1 ,  "01") ;
            assertEquals( s.indexOf("item1") , 0  ,  "02") ;
        }
        
        public function testIsEmpty():void 
        {
            var s:HashSet = new HashSet() ;
            assertTrue( s.isEmpty() , "01 - HashSet isEmpty failed.") ;
            s.add("test") ;
            assertFalse( s.isEmpty() , "02 - HashSet isEmpty failed.") ;
            s.remove("test") ;
            assertTrue( s.isEmpty() , "03 - HashSet isEmpty failed.") ;
        }

        public function testIterator():void 
        {
            var s:HashSet   = new HashSet() ;
            var it:Iterator = s.iterator() ;
            assertTrue  ( it is Iterator      , "01 - HashSet iterator failed." ) ;
            assertTrue  ( it is ArrayIterator , "02 - HashSet iterator failed." ) ;
        }

        public function testRemove():void 
        {
            var s:HashSet = new HashSet() ;
            
            s.add("item1") ;
            s.add("item2") ;
            
            assertTrue  ( s.remove("item1") , "01 - HashSet remove failed." ) ;
            assertFalse ( s.remove("item5") , "02 - HashSet remove failed." ) ;
        }
        
        public function testSize():void 
        {
            var s:HashSet = new HashSet() ;
            assertEquals( s.size() , 0 ,  "01 - HashSet size failed.") ;
            s.add("test") ;
            assertEquals( s.size() , 1 ,  "02 - HashSet size failed.") ;
        }
        
        public function testToArray():void 
        {
            var s:HashSet ;
            var a:Array ;
            
            // initialize with an Array
            
            s = new HashSet() ;
            a = s.toArray() ;
            
            assertNotNull( a , "01-02 - HashSet toArray failed.") ;
            ArrayAssert.assertEquals( a , [], "01-02 - HashSet toArray failed.") ;
            
            s.add(2) ;
            s.add(3) ;
            s.add(4) ; 
            
            a = s.toArray() ;
            
            assertNotNull( a , "02-02 - HashSet constructor failed.") ;
        }
        
        public function testToSource():void
        {
            var s:HashSet = new HashSet() ;
            assertEquals(s.toSource() , "new system.data.sets.HashSet()" , "01 - HashSet toSource failed" ) ;
        }
        
        public function testToString():void
        {
            var s:HashSet = new HashSet() ;
            assertEquals(s.toString() , "{}", "HashSet toString failed") ;
        }
    }
}
