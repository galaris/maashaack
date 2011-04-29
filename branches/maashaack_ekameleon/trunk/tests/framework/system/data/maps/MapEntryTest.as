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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Entry;
    
    public class MapEntryTest extends TestCase 
    {
        public function MapEntryTest(name:String = "")
        {
            super( name );
        }
        
        public var entry:MapEntry ;
        
        public function setUp():void
        {
            entry = new MapEntry( "key", "value" );
        }
        
        public function tearDown():void
        {
            entry = undefined ;
        }
        
        public function testConstructor():void
        {
            var e:MapEntry ;
            
            assertNotNull( entry , "1 - The constructor failed, the object not must be null.") ;
            
            e = new MapEntry() ;
            assertNotNull( e            , "2-1 - The constructor failed, the object not must be null.") ;
            assertEquals(e.key   , null , "2-2 - The constructor failed, the key of the entry not must be null.") ;
            assertEquals(e.value , null , "2-3 - The constructor failed, the key of the entry not must be null.") ;
            
            e = new MapEntry("key") ;
            assertNotNull( e             , "3-1 - The constructor failed, the object not must be null.") ;
            assertEquals(e.key   , "key" , "3-2 - The constructor failed, the key of the entry not must be null.") ;
            assertEquals(e.value , null  , "3-3 - The constructor failed, the key of the entry not must be null.") ;
            
            e = new MapEntry(null, "value") ;
            assertNotNull( e               , "4-1 - The constructor failed, the object not must be null.") ;
            assertEquals(e.key   , null    , "4-2 - The constructor failed, the key of the entry not must be null.") ;
            assertEquals(e.value , "value" , "4-3 - The constructor failed, the key of the entry not must be null.") ;
        } 
        
        public function testInterface():void
        {
            assertTrue( entry is Entry , "The interface failed, the object must implement the Entry interface.") ;
        }
        
        public function testKey():void
        {
            assertEquals( entry.key , "key" , "MapEntry.key failed with the key method" ) ;
        }
        
        public function testValue():void
        {
            assertEquals( entry.value , "value" , "MapEntry.value failed with the value method" ) ;
        }
        
        public function testClone():void
        {
            var c:MapEntry = entry.clone() ;
            assertNotSame( c , entry , "MapEntry.clone failed with the value method" ) ;
            assertEquals(entry.key   , c.key   , "The key of the entry equals with the clone.key.") ;
            assertEquals(entry.value , c.value , "The value of the entry equals with the clone.key.") ;
        }  
        
        public function testToString():void
        {
            assertEquals(entry.toString(), "[MapEntry key:key value:value]"  , "The toString() method failed.") ;
        }
    }
}
