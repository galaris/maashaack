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

package system.ioc
{
    import buRRRn.ASTUce.framework.TestCase;

    import system.data.Iterator;
    import system.data.iterators.MapIterator;
    
    public class TypeAliasesTest extends TestCase
    {
        public function TypeAliasesTest(name:String = "")
        {
            super(name);
        }
        
        public var aliases:TypeAliases ;
        
        public function setUp():void
        {
            aliases = new TypeAliases() ;
        }
        
        public function tearDown():void
        {
            aliases = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( aliases ) ;
        }
        
        public function testLength():void
        {
            assertEquals( 0 , aliases.length ) ;
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            assertEquals( 1 , aliases.length ) ;
        }
        
        public function testClear():void
        {
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            aliases.clear() ;
            assertEquals( 0 , aliases.length ) ;
        }
        
        public function testContainsAlias():void
        {
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            assertTrue( aliases.containsAlias("Blur") );
            assertFalse( aliases.containsAlias("unknow") );
        }
        
        public function testContainsValue():void
        {
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            assertTrue( aliases.containsValue("flash.filters.BlurFilter") );
            assertFalse( aliases.containsValue("unknow") );
        }
        
        public function testGetAliases():void
        {
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            aliases.put("Shadow", "flash.filters.DropShadowFilter") ;
            var ar:Array = aliases.getAliases() ;
            assertTrue( ar.indexOf("Blur") > -1 ) ;
            assertTrue( ar.indexOf("Shadow") > -1 ) ;
        }
        
        public function testGetMap():void
        {
            assertNotNull( aliases.getMap() ) ;
        }
        
        public function testGetValue():void
        {
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            assertEquals( "flash.filters.BlurFilter" ,  aliases.getValue( "Blur" ) ) ;
            assertNull( aliases.getValue( "Shadow" ) ) ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( aliases.isEmpty() ) ;
            aliases.put("Blur", "flash.filters.BlurFilter") ;
            assertFalse( aliases.isEmpty() ) ;
        }
        
        public function testIterator():void
        {
            assertNotNull( aliases.iterator() as Iterator ) ;
            assertNotNull( aliases.iterator() as MapIterator ) ;
        }
    }
}