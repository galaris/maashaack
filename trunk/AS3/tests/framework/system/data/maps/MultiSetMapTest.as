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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    import buRRRn.ASTUce.framework.TestCase;

    import system.data.Map;
    import system.data.MultiMap;

    public class MultiSetMapTest extends TestCase 
    {

        public function MultiSetMapTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertNotNull(map , "1 - The MultiSetMap constructor failed.") ;
        }

        public function testConstructorWithFactory():void
        {
            
            var init:Map = new HashMap() ;
            init.put( "key1" , "value1" ) ;
            
            var map:MultiSetMap = new MultiSetMap( init , new ArrayMap() ) ;
            
            assertNotNull(map , "1 - The MultiSetMap constructor failed.") ;
            
            assertEquals
            ( 
               map.toSource() , 
               'new system.data.maps.MultiSetMap(new system.data.maps.ArrayMap(["key1"],[new system.data.sets.HashSet(["value1"])]))' ,
               "2 - The MultiSetMap constructor failed." 
            );
            
        }
        
        public function testInherit():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertTrue( map is MultiValueMap , "The MultiSetMap must extends the MultiValueMap class." ) ;
        }
        
        public function testInterface():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertTrue( map is MultiMap , "1 - The MultiSetMap must implement the MultiMap interface." ) ;
            assertTrue( map is Map      , "2 - The MultiSetMap must implement the Map interface." ) ;
        }

        public function testClear():void 
        {
        	var map:MultiSetMap = new MultiSetMap() ;
            map.put("key1" , "value1") ;
            map.clear() ;
            assertTrue( map.isEmpty() , "The MultiSetMap clear failed.") ;
        }
        
        public function testClone():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            var clone:MultiSetMap = map.clone() as MultiSetMap ;
            
            assertNotNull( clone , "01 - The MultiSetMap clone method failed.") ;
            assertNotSame( map, clone , "02 - The MultiSetMap clone method failed.") ;
            
            clone.put("key1", "value1") ;
            
            clone = clone.clone() ;
            
            assertEquals( clone.size() , 1 , "03 - The MultiSetMap clone method failed.") ;
            
        }
   
        
    }
}
