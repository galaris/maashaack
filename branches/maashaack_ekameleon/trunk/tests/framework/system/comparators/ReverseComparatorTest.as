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
    
    import system.Comparator;
    import system.Sortable;
    
    public class ReverseComparatorTest extends TestCase 
    {
        public function ReverseComparatorTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var c:ReverseComparator ;
            var s:StringComparator  = StringComparator.comparator ;
            
            c = new ReverseComparator( s ) ;
            
            assertNotNull ( c               , "01-01 - The ReverseComparator constructor failed." ) ;
            assertTrue    ( c is Comparator , "01-02 - The ReverseComparator constructor failed." ) ;
            
            try
            {
                c = new ReverseComparator( null ) ;
                fail( "02-01 - The ReverseComparator constructor failed." ) ;
            }
            catch(e:Error)
            {
                assertEquals
                ( 
                   e.message ,
                   "The ReverseComparator 'comparator' property not must be 'null'" , 
                   "02-02 - The ReverseComparator constructor failed."
                ) ;
            }
        }
        
        public function testInterface():void
        {
            var c:ReverseComparator = new ReverseComparator( StringComparator.comparator ) ;
            assertTrue( c is Sortable , "The ReverseComparator must implement the system.Sortable interface." ) ;
        }
        
        public function testComparator():void
        {
            var c:ReverseComparator ;
            var s:StringComparator  = StringComparator.comparator ;
            
            c = new ReverseComparator( s ) ; 
            
            assertEquals( c.comparator , s, "01 - The ReverseComparator comparator property failed." ) ;
            
            try
            {
                c.comparator = null ;
                fail( "02 - The ReverseComparator comparator property failed." ) ;
            }
            catch(e:Error)
            {
                assertEquals
                ( 
                   e.message ,
                   "The ReverseComparator 'comparator' property not must be 'null'" , 
                   "03 - The ReverseComparator comparator property failed." 
                ) ;
            }
        }
        
        public function testCompare():void
        {
            var c:ReverseComparator ;
            var s:StringComparator  = StringComparator.comparator ;
            
            var s1:Object = "1"   ;
            var s2:Object = "1"   ;
            var s3:Object = "11"  ;
            var s4:Object = "111" ;
            
            c = new ReverseComparator( s ) ;
            
            assertEquals( c.compare( s1 , s1 ) ,  0 , "01 - The ReverseComparator compare method failed." ) ;
            assertEquals( c.compare( s1 , s2 ) ,  0 , "02 - The ReverseComparator compare method failed." ) ;
            assertEquals( c.compare( s2 , s1 ) ,  0 , "03 - The ReverseComparator compare method failed." ) ;
            assertEquals( c.compare( s2 , s2 ) ,  0 , "04 - The ReverseComparator compare method failed." ) ;
            
            assertEquals( c.compare( s1 , s3 ) ,  1 , "05 - The ReverseComparator compare method failed." ) ;
            assertEquals( c.compare( s1 , s4 ) ,  1 , "06 - The ReverseComparator compare method failed." ) ;
            
            assertEquals( c.compare( s3 , s1 ) ,  -1 , "07 - The ReverseComparator compare method failed." ) ;
            assertEquals( c.compare( s4 , s2 ) ,  -1 , "08 - The ReverseComparator compare method failed." ) ;
        }
    }
}
