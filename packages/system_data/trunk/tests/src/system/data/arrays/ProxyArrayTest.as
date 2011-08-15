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
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.Reflection;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    
    import flash.utils.Proxy;    

    public class ProxyArrayTest extends TestCase 
    {

        public function ProxyArrayTest(name:String = "")
        {
            super( name );
        }

        public function testConstructor():void
        {
            var ar:ProxyArray ;
            
            ar = new ProxyArray() ;
            
            assertNotNull(ar, "01-01 - The ProxyArray constructor failed.") ;
            assertTrue( ar is Proxy , "01-02 - The ProxyArray constructor failed.") ;
            assertTrue( Reflection.getClassInfo( ar ).isDynamic() , "01-03 - The ProxyArray constructor failed.") ;
            
            ar = new ProxyArray( [2,3,4] ) ;
            
            assertNotNull(ar, "02-01 - The ProxyArray constructor failed.") ;
            assertEquals(ar.length , 3 , "02-02 - The ProxyArray constructor failed.") ;
        } 
        
        public function testClear():void
        {
            var ar:ProxyArray = new ProxyArray() ;
            ar.push( "item2" ) ;
            ar.push( "item3" ) ;
            ar.clear() ;
            assertEquals( ar.length , 0 , "The ProxyArray clear method failed." ) ;
        }          
        
        public function testIsEmpty():void
        {
            var ar:ProxyArray = new ProxyArray() ;
            assertTrue( ar.isEmpty() , "01 - The ProxyArray isEmpty method failed." ) ;
            ar.push( "item2" ) ;
            assertFalse( ar.isEmpty() , "02 - The ProxyArray isEmpty method failed." ) ;
        }         
        
        public function testIterator():void
        {
            var ar:ProxyArray = new ProxyArray() ;
            var it:Iterator   = ar.iterator() ;
            assertNotNull( it , "01 - The iterator failed." ) ;
            assertTrue( it is ArrayIterator , "02 - The iterator failed." ) ;
        }          
        
        public function testProxy():void
        {
            
            var ar:ProxyArray = new ProxyArray() ;
            
            // use Array method
            
            ar.push( "item1" ) ;
             
            assertEquals( ar.toString() , '[item1]' , "01 - The ProxyArray proxy failed." ) ;
            
            ar.push( "item2" ) ;
            ar.push( "item3" ) ;
            
            assertEquals( ar.toString() , '[item1,item2,item3]' , "02 - The ProxyArray proxy failed." ) ;
            
            // use Array property
            
            assertEquals( ar.length , 3 , "03 - The ProxyArray proxy failed." ) ;
            
            // use Array []
            
            assertEquals( ar[1] , "item2" , "04 - The ProxyArray proxy failed." ) ;
            
            // for..in
            
            var count:uint ;
            for( var prop:String in ar )
            {
                prop ;
                count ++ ;
            }
            
            assertEquals( count , 3 , "05 - The ProxyArray proxy failed." ) ;
            
        }
        
        public function testToArray():void
        {
            var ar:ProxyArray = new ProxyArray() ;
            
            ArrayAssert.assertEquals( ar.toArray() , [] , "01 - The ProxyArray toArray failed." ) ;
            
            ar.push( "item1" ) ;
            ar.push( "item2" ) ;
            ar.push( "item3" ) ;            
            
            ArrayAssert.assertEquals( ar.toArray() , ["item1", "item2", "item3"] , "02 - The ProxyArray toArray failed." ) ;            
        }          
                
        
        public function testToSource():void
        {
            var ar:ProxyArray = new ProxyArray() ;
            
            assertEquals( ar.toSource() , 'new system.data.arrays.ProxyArray()' , "01 - The ProxyArray proxy failed." ) ;
            
            ar.push( "item1" ) ;
            ar.push( "item2" ) ;
            ar.push( "item3" ) ;            
            
            assertEquals( ar.toSource() , 'new system.data.arrays.ProxyArray(["item1","item2","item3"])' , "01 - The ProxyArray proxy failed." ) ;            
        }          
        
        public function testToString():void
        {
            var ar:ProxyArray = new ProxyArray() ;
            
            assertEquals( ar.toString() , '[]' , "02 - The ProxyArray proxy failed." ) ;
            
            ar.push( "item1" ) ;
            ar.push( "item2" ) ;
            ar.push( "item3" ) ;            
                                    
            assertEquals( ar.toString() , '[item1,item2,item3]' , "02 - The ProxyArray proxy failed." ) ;            
        }        
        
    }
}
