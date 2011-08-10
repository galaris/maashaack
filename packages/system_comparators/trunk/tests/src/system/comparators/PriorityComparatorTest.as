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

package system.comparators 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.process.samples.PriorityClass;    
    
    public class PriorityComparatorTest extends TestCase 
    {

        public function PriorityComparatorTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var c:PriorityComparator = new PriorityComparator() ;
            assertNotNull( c , "The PriorityComparator constructor failed." ) ;
        }
        
        public function testCompare():void
        {
            
            var p1:PriorityClass = new PriorityClass(0) ;
            var p2:PriorityClass = new PriorityClass(100) ;
            
            var c:PriorityComparator = new PriorityComparator() ;

            assertEquals( c.compare( p1 , p1 ) ,  0  , "01 - The PriorityComparator compare method failed." ) ;
            assertEquals( c.compare( p1 , p2 ) ,  1  , "02 - The PriorityComparator compare method failed." ) ;
            assertEquals( c.compare( p2 , p1 ) ,  -1 , "03 - The PriorityComparator compare method failed." ) ;
            assertEquals( c.compare( p2 , p2 ) ,  0  , "04 - The PriorityComparator compare method failed." ) ;

        }        
        
        public function testCompareErrors():void
        {
            
            var p:PriorityClass = new PriorityClass() ;
            var c:PriorityComparator = new PriorityComparator() ;
            
            try
            {
                 c.compare( p , 2 ) ;
                 fail( "01-01 - The PriorityComparator compare method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - The PriorityComparator compare method failed." ) ;
                assertEquals( e.message,  "PriorityComparator compare([object PriorityClass],2) failed, the two arguments must be Priority objects."  , "01-03 - The PriorityComparator compare method failed." ) ;
            }
            
            try
            {
                 c.compare( 1 , p ) ;
                 fail( "02-01 - The PriorityComparator compare method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "02-02 - The PriorityComparator compare method failed." ) ;
                assertEquals( e.message,  "PriorityComparator compare(1,[object PriorityClass]) failed, the two arguments must be Priority objects."  , "02-03 - The PriorityComparator compare method failed." ) ;
            }
            
            try
            {
                 c.compare( 1 , 2 ) ;
                 fail( "03-01 - The PriorityComparator compare method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "03-02 - The PriorityComparator compare method failed." ) ;
                assertEquals( e.message,  "PriorityComparator compare(1,2) failed, the two arguments must be Priority objects."  , "03-03 - The PriorityComparator compare method failed." ) ;
            } 
            
        }          
        
    }
}
