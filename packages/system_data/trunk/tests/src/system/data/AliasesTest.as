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

package system.data 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class AliasesTest extends TestCase 
    {
        public function AliasesTest(name:String = "")
        {
            super( name );
        }
        
        public var aliases:Aliases ;
        
        public function setUp():void
        {
            aliases = new Aliases() ;
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
            assertEquals( 0 , aliases.length , "#1" ) ;
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            aliases.register( "Sprite"    , "flash.display.Sprite"    ) ;
            assertEquals( 2 , aliases.length , "#2" ) ;
            aliases.unregister("MovieClip") ;
            assertEquals( 1 , aliases.length , "#3" ) ;
            aliases.clear() ;
            assertEquals( 0 , aliases.length , "#4" ) ;
        }
        
        public function testContainsAlias():void
        {
            assertFalse( aliases.containsAlias("MovieClip") , "#1-1" ) ;
            assertFalse( aliases.containsAlias("") , "#1-2" ) ;
            assertFalse( aliases.containsAlias(null) , "#1-3" ) ;
            
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            aliases.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertTrue( aliases.containsAlias("MovieClip") , "#2" ) ;
            assertTrue( aliases.containsAlias("Sprite") , "#3" ) ;
        }
        
        public function testContainsValue():void
        {
            assertFalse( aliases.containsValue("flash.display.MovieClip") , "#1-1" ) ;
            assertFalse( aliases.containsValue("") , "#1-2" ) ;
            assertFalse( aliases.containsValue(null) , "#1-3" ) ;
            
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            aliases.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertTrue( aliases.containsValue("flash.display.MovieClip") , "#2" ) ;
            assertTrue( aliases.containsValue("flash.display.Sprite") , "#3" ) ;
        }
        
        public function testGetAliases():void
        {
            assertNull( aliases.getAliases() , "#1" ) ;
            
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            aliases.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertEquals( 2 , aliases.getAliases().length , "#2" ) ;
            
            assertTrue( aliases.getAliases().indexOf("MovieClip") > -1 , "#3-1" ) ;
            assertTrue( aliases.getAliases().indexOf("Sprite")    > -1 , "#3-2" ) ;
        }
        
        public function testGetValue():void
        {
            assertNull( aliases.getValue(null)     , "#1" ) ;
            assertNull( aliases.getValue("")       , "#2" ) ;
            assertNull( aliases.getValue("unknow") , "#3" ) ;
            
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            
            assertEquals( "flash.display.MovieClip" , aliases.getValue("MovieClip") , "#4" ) ;
        }
        
        public function testGetValues():void
        {
            assertNull( aliases.getValues() , "#1" ) ;
            
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            aliases.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertEquals( 2 , aliases.getValues().length , "#2" ) ;
            
            assertTrue( aliases.getValues().indexOf("flash.display.MovieClip") > -1 , "#3-1" ) ;
            assertTrue( aliases.getValues().indexOf("flash.display.Sprite")    > -1 , "#3-2" ) ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( aliases.isEmpty() , "#1" ) ;
            aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
            assertFalse( aliases.isEmpty() , "#1" ) ;
        }
        
        public function testRegister():void
        {
            assertFalse( aliases.register(null,null) , "#1-1" ) ;
            assertFalse( aliases.register(null,"")   , "#1-2" ) ;
            assertFalse( aliases.register("",null)   , "#1-3" ) ;
            assertFalse( aliases.register("","")     , "#1-4" ) ;
            
            assertTrue( aliases.register( "MovieClip" , "flash.display.MovieClip" ) , "#2-1" ) ;
            assertTrue( aliases.register( "MovieClip" , "flash.display.MovieClip" ) , "#2-2" ) ;
            assertTrue( aliases.register( "MovieClip" , "flash.MovieClip" )         , "#2-3" ) ;
        }
        
        public function testUnregister():void
        {
            assertFalse( aliases.unregister(null) , "#1-1" ) ;
            assertFalse( aliases.unregister("")   , "#1-2" ) ;
            
            assertFalse( aliases.unregister("unknonw") , "#1-3" ) ;
            
            aliases.register( "MovieClip" , "flash.display.MovieClip" )  ;
            
            assertTrue( aliases.unregister("MovieClip") , "#2-1" ) ;
            assertFalse( aliases.unregister("MovieClip") , "#2-2" ) ;
        }
    }
}