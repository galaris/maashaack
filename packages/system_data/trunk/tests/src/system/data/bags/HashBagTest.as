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
 
package system.data.bags 
{
    import library.ASTUce.framework.TestCase;
    
    import system.data.collections.ArrayCollection;            

    public class HashBagTest extends TestCase 
    {

        public function HashBagTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var b:HashBag ;
                        
            b = new HashBag() ;
            
            assertNotNull( b , "01 - HashBag constructor failed." ) ;
            
            b = new HashBag(null) ;
            
            assertNotNull( b , "02 - HashBag constructor failed." ) ;
            
            var co:ArrayCollection = new ArrayCollection([1,2,3,3,4]) ;
            
            b = new HashBag( co ) ;            
            
            assertEquals( b.size()      , 5 , "03-01 - HashBag constructor failed."  ) ;
            assertEquals( b.getCount(1) , 1 , "03-02 - HashBag constructor failed."  ) ;
            assertEquals( b.getCount(2) , 1 , "03-03 - HashBag constructor failed."  ) ;
            assertEquals( b.getCount(3) , 2 , "03-04 - HashBag constructor failed."  ) ;
            assertEquals( b.getCount(4) , 1 , "03-05 - HashBag constructor failed."  ) ;
            
        }
        
        public function testClone():void 
        {
            var bag:HashBag = new HashBag() ;
            bag.add("item1") ;
            bag.add("item2") ;                  
            bag.add("item2") ;
            
            var clone:HashBag = bag.clone() as HashBag ;
            
            assertNotNull( clone         , "01 - HashBag clone failed." ) ;
            assertNotSame( bag   , clone , "02 - HashBag clone failed." ) ;
            
            assertEquals( clone.size() , bag.size() , "03 - HashBag clone failed." ) ;
            
            assertEquals( clone.getCount("item1") , bag.getCount("item1") , "04-01 - HashBag clone failed." ) ;
            assertEquals( clone.getCount("item2") , bag.getCount("item2") , "04-02 - HashBag clone failed." ) ;
            
        }   
        
        public function testToSource():void 
        {
            var bag:HashBag  ;

            bag = new HashBag() ;
            
            assertEquals( bag.toSource() , 'new system.data.bags.HashBag()' , "01 - HashBag toSource failed : " + bag ) ;
            
            bag.add("item1") ;
            
            assertEquals( bag.toSource() , 'new system.data.bags.HashBag(new system.data.lists.ArrayList(["item1"]))' , "02 - HashBag toSource failed : " + bag ) ; 
                       
        }         
               
        
    }
}
