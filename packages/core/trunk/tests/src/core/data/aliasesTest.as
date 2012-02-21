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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
package core.data 
{
    import library.ASTUce.framework.TestCase;
    
    public class aliasesTest extends TestCase 
    {
        public function aliasesTest(name:String = "")
        {
            super( name );
        }
        
        public var alias:aliases ;
        
        public function setUp():void
        {
            alias = new aliases() ;
        }
        
        public function tearDown():void
        {
            alias = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( alias ) ;
        }
        
        public function testLength():void
        {
            assertEquals( 0 , alias.length , "#1" ) ;
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            alias.register( "Sprite"    , "flash.display.Sprite"    ) ;
            assertEquals( 2 , alias.length , "#2" ) ;
            alias.unregister("MovieClip") ;
            assertEquals( 1 , alias.length , "#3" ) ;
            alias.clear() ;
            assertEquals( 0 , alias.length , "#4" ) ;
        }
        
        public function testContainsAlias():void
        {
            assertFalse( alias.containsAlias("MovieClip") , "#1-1" ) ;
            assertFalse( alias.containsAlias("") , "#1-2" ) ;
            assertFalse( alias.containsAlias(null) , "#1-3" ) ;
            
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            alias.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertTrue( alias.containsAlias("MovieClip") , "#2" ) ;
            assertTrue( alias.containsAlias("Sprite") , "#3" ) ;
        }
        
        public function testContainsValue():void
        {
            assertFalse( alias.containsValue("flash.display.MovieClip") , "#1-1" ) ;
            assertFalse( alias.containsValue("") , "#1-2" ) ;
            assertFalse( alias.containsValue(null) , "#1-3" ) ;
            
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            alias.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertTrue( alias.containsValue("flash.display.MovieClip") , "#2" ) ;
            assertTrue( alias.containsValue("flash.display.Sprite") , "#3" ) ;
        }
        
        public function testGetAliases():void
        {
            assertNull( alias.getAliases() , "#1" ) ;
            
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            alias.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertEquals( 2 , alias.getAliases().length , "#2" ) ;
            
            assertTrue( alias.getAliases().indexOf("MovieClip") > -1 , "#3-1" ) ;
            assertTrue( alias.getAliases().indexOf("Sprite")    > -1 , "#3-2" ) ;
        }
        
        public function testGetValue():void
        {
            assertNull( alias.getValue(null)     , "#1" ) ;
            assertNull( alias.getValue("")       , "#2" ) ;
            assertNull( alias.getValue("unknow") , "#3" ) ;
            
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            
            assertEquals( "flash.display.MovieClip" , alias.getValue("MovieClip") , "#4" ) ;
        }
        
        public function testGetValues():void
        {
            assertNull( alias.getValues() , "#1" ) ;
            
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            alias.register( "Sprite"    , "flash.display.Sprite"    ) ;
            
            assertEquals( 2 , alias.getValues().length , "#2" ) ;
            
            assertTrue( alias.getValues().indexOf("flash.display.MovieClip") > -1 , "#3-1" ) ;
            assertTrue( alias.getValues().indexOf("flash.display.Sprite")    > -1 , "#3-2" ) ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( alias.isEmpty() , "#1" ) ;
            alias.register( "MovieClip" , "flash.display.MovieClip" ) ;
            assertFalse( alias.isEmpty() , "#1" ) ;
        }
        
        public function testRegister():void
        {
            assertFalse( alias.register(null,null) , "#1-1" ) ;
            assertFalse( alias.register(null,"")   , "#1-2" ) ;
            assertFalse( alias.register("",null)   , "#1-3" ) ;
            assertFalse( alias.register("","")     , "#1-4" ) ;
            
            assertTrue( alias.register( "MovieClip" , "flash.display.MovieClip" ) , "#2-1" ) ;
            assertTrue( alias.register( "MovieClip" , "flash.display.MovieClip" ) , "#2-2" ) ;
            assertTrue( alias.register( "MovieClip" , "flash.MovieClip" )         , "#2-3" ) ;
        }
        
        public function testUnregister():void
        {
            assertFalse( alias.unregister(null) , "#1-1" ) ;
            assertFalse( alias.unregister("")   , "#1-2" ) ;
            
            assertFalse( alias.unregister("unknonw") , "#1-3" ) ;
            
            alias.register( "MovieClip" , "flash.display.MovieClip" )  ;
            
            assertTrue( alias.unregister("MovieClip") , "#2-1" ) ;
            assertFalse( alias.unregister("MovieClip") , "#2-2" ) ;
        }
    }
}