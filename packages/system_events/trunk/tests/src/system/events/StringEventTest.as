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

package system.events 
{
    import library.ASTUce.framework.TestCase;
        
    public class StringEventTest extends TestCase 
    {

        public function StringEventTest(name:String = "")
        {
            super( name );
        }        
        
        public function testConstructor():void
        {
            var e:StringEvent ;
            
            e = new StringEvent( "type" , "hello" ) ;
            assertNotNull( e , "01-01 - StringEvent constructor failed.") ;
            assertEquals( e.string, "hello", "01-02 - StringEvent constructor failed.") ;
            
            e = new StringEvent( "type" ) ;
            assertNotNull( e , "02-01 - StringEvent constructor failed.") ;
            assertNull( e.string, "02-02 - StringEvent constructor failed.") ;             
            
        }        
        
        public function testInherit():void
        {
            var e:StringEvent = new StringEvent( "type" ) ;
            assertTrue( e is BasicEvent, "01 - StringEvent must extends the BasicEvent class.") ;
        }          
        
        public function testStringProperty():void
        {
            var e:StringEvent = new StringEvent( "type" ) ;
            
            assertNull( e.string , "01 - StringEvent string property failed.") ;  
            
            e.string = "test1" ;
            assertEquals( e.string, "test1" , "02 - StringEvent string property failed.") ;  
            
            e.string = "test2" ;
            assertEquals( e.string, "test2" , "03 - StringEvent string property failed.") ;  
        }        
        
        public function testClone():void
        {
            var e:StringEvent = new StringEvent( "type" , "hello world") ;
            var c:StringEvent = e.clone() as StringEvent ;
            assertNotNull( c , "01 - StringEvent clone() failed.") ;
            assertEquals( e.string , c.string, "02 - StringEvent clone() failed.") ;  
        }       
        
        
    }
}
