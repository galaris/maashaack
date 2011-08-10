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

package system 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.samples.ComparatorClass;
    
    public class ComparatorTest extends TestCase 
    {
        public function ComparatorTest(name:String = "")
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var c:ComparatorClass = new ComparatorClass();
            
            assertTrue( c is Comparator ) ;
            
            assertEquals( c.compare(10,20) , -1 , "01 - compare(10,20) method failed." ) ;
            assertEquals( c.compare(10,10) ,  0 , "02 - compare(10,10) method failed." ) ;
            assertEquals( c.compare(20,10) ,  1 , "03 - compare(20,10) method failed." ) ;
            
            assertEquals( c.compare(10,20,ComparatorClass.INVERSE) ,  1 , "04 - compare(10,20,true) method failed." ) ;
            assertEquals( c.compare(10,10,ComparatorClass.INVERSE) ,  0 , "05 - compare(10,10,true) method failed." ) ;
            assertEquals( c.compare(20,10,ComparatorClass.INVERSE) , -1 , "06 - compare(20,10,true) method failed." ) ;            
            
        }
    }
}
