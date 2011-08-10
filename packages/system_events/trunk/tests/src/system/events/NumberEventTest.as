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
    import buRRRn.ASTUce.framework.TestCase;    

    public class NumberEventTest extends TestCase 
    {

        public function NumberEventTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var e:NumberEvent ;
            
            e = new NumberEvent( "type" , 10 ) ;
            assertNotNull( e , "01-01 - NumberEvent constructor failed.") ;
            assertEquals( e.number, 10, "01-02 - NumberEvent constructor failed.") ;
            
            e = new NumberEvent( "type" ) ;
            assertNotNull( e , "02-01 - NumberEvent constructor failed.") ;
            assertEquals( e.number, NaN, "02-02 - NumberEvent constructor failed.") ;             
            
        }        
        
        public function testInherit():void
        {
            var e:NumberEvent = new NumberEvent( "type" ) ;
            assertTrue( e is BasicEvent, "01 - NumberEvent must extends the BasicEvent class.") ;
        }          
        
        public function testNumberProperty():void
        {
            var e:NumberEvent = new NumberEvent( "type" ) ;
            
            assertEquals( e.number , NaN,  "01 - NumberEvent string number failed.") ;  
            
            e.number = -10.5 ;
            assertEquals( e.number, -10.5 , "02 - NumberEvent number number failed.") ;  
            
            e.number = 101 ;
            assertEquals( e.number, 101 , "03 - NumberEvent number number failed.") ;  
        }        
        
        public function testClone():void
        {
            var e:NumberEvent = new NumberEvent( "type" , 999999) ;
            var c:NumberEvent = e.clone() as NumberEvent ;
            assertNotNull( c , "01 - NumberEvent clone() failed.") ;
            assertEquals( e.number , c.number, "02 - NumberEvent clone() failed.") ;  
        }   
        
    }
}
