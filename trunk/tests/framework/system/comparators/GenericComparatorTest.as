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
    
    public class GenericComparatorTest extends TestCase 
    {
        public function GenericComparatorTest(name:String = "")
        {
            super(name);
        }
                
        public function testConstructor():void
        {
            var c:GenericComparator ;
            var s:StringComparator  = StringComparator.comparator ;
                
            c = new GenericComparator( "label", s ) ;
            
            assertNotNull ( c               , "01-01 - The GenericComparator constructor failed." ) ;
            assertTrue    ( c is Comparator , "01-02 - The GenericComparator constructor failed." ) ;
            
            try
            {
                c = new GenericComparator( null, s ) ;
                fail( "02-01 - The GenericComparator constructor failed." ) ;
            }
            catch(e:Error)
            {
                assertEquals
                ( 
                   e.message ,
                   "The GenericComparator 'sortBy' property not must be 'null'" , 
                   "02-02 - The GenericComparator constructor failed."
                ) ;
            }
            
            try
            {
                c = new GenericComparator( "label", null ) ;
                fail( "03-01 - The GenericComparator constructor failed." ) ;
            }
            catch(e:Error)
            {
                assertEquals
                ( 
                   e.message ,
                   "The GenericComparator 'comparator' property not must be 'null'" , 
                   "03-02 - The GenericComparator constructor failed."
                ) ;
            }
        }
        
        public function testCompare():void
        {
            var c:GenericComparator ;
            var s:StringComparator  = StringComparator.comparator ;
            
            var o1:Object = { label:"1"   } ;
            var o2:Object = { label:"1"   } ;
            var o3:Object = { label:"11"  } ;
            var o4:Object = { label:"111" } ;
            
            c = new GenericComparator( "label", s ) ;
            
            assertEquals( c.compare( o1 , o1 ) ,  0 , "01 - The ComparableComparator compare method failed." ) ;
            assertEquals( c.compare( o1 , o2 ) ,  0 , "02 - The ComparableComparator compare method failed." ) ;
            assertEquals( c.compare( o2 , o1 ) ,  0 , "03 - The ComparableComparator compare method failed." ) ;
            assertEquals( c.compare( o2 , o2 ) ,  0 , "04 - The ComparableComparator compare method failed." ) ;
            
            assertEquals( c.compare( o1 , o3 ) ,  -1 , "05 - The ComparableComparator compare method failed." ) ;
            assertEquals( c.compare( o1 , o4 ) ,  -1 , "06 - The ComparableComparator compare method failed." ) ;
            
            assertEquals( c.compare( o3 , o1 ) ,  1 , "07 - The ComparableComparator compare method failed." ) ;
            assertEquals( c.compare( o4 , o2 ) ,  1 , "08 - The ComparableComparator compare method failed." ) ;
        }
    }
}
