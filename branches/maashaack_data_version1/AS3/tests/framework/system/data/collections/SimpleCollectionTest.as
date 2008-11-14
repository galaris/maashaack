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
  Portions created by the Initial Developers are Copyright (C) 2006-2008
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

package system.data.collections 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Serializable;
    import system.data.Collection;
    import system.data.Iterable;    

    public class SimpleCollectionTest extends TestCase
    {

        public function SimpleCollectionTest(name:String = "")
        {
            super( name );
        }
        
        public var c:SimpleCollection ;
        
        public function setUp():void
        {
            c = new SimpleCollection() ;
        }

        public function tearDown():void
        {
            c = undefined ;
        }             
        
        public function testConstructor():void
        {
        	assertNotNull(c, "01 - SimpleCollection constructor failed.") ;
        	
        	var ar:Array = [2,3,4] ;
        	
        	var co:SimpleCollection = new SimpleCollection(ar) ; 
        	
        	assertNotNull(co, "02 - SimpleCollection constructor failed.") ;
        	assertEquals(co.size(), ar.length, "03 - SimpleCollection constructor failed.") ;
        	
        }
        
        public function testInterface():void
        {
            assertTrue( c is Collection   , "01 - SimpleCollection implements the Collection interface.") ;
            assertTrue( c is Cloneable    , "02 - SimpleCollection implements the Collection interface.") ;
            assertTrue( c is Iterable     , "03 - SimpleCollection implements the Collection interface.") ;
            assertTrue( c is Serializable , "04 - SimpleCollection implements the Collection interface.") ;
        }        
        
        public function testAdd():void
        {
        }
        
        public function testAddAll():void
        {
        }        
        
        public function testClear():void
        {
        }
        
        public function testClone():void
        {
        }
        
        public function testContains():void
        {
        
        }
        
        public function testContainsAll():void
        {
        
        }        
        
        public function testGet():void
        {
        }
        
        public function testIndexOf():void
        {
        }
        
        public function testIsEmpty():void
        {
        }
        
        public function testIterator():void
        {
        }        
        
        public function testRemove():void
        {
        }
        
        public function testRemoveAll():void
        {
        
        }        
        
        public function testRetainAll():void
        {
        
        } 
        
        public function testSize():void
        {
        }
        
        public function testToArray():void
        {
        }
                
        public function testToSource():void
        {
        }
        
    }
}
