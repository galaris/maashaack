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
  Portions created by the Initial Developers are Copyright (C) 2006-2008
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

    public class SortedArrayMapTest extends TestCase 
    {

        public function SortedArrayMapTest(name:String = "")
        {
            super(name);
        }
        
        public var m:SortedArrayMap ;

        public function setUp():void
        {
            m = new SortedArrayMap() ;
        }

        public function tearDown():void
        {
            m = undefined ;
        }          
        
        public function testCASEINSENSITIVE():void
        {
            assertEquals(SortedArrayMap.CASEINSENSITIVE, 1, "SortedArrayMap.CASEINSENSITIVE value failed.") ;
        }

        public function testDESCENDING():void
        {
            assertEquals(SortedArrayMap.DESCENDING, 2, "SortedArrayMap.DESCENDING value failed.") ;
        }
        
        public function testKEY():void
        {
            assertEquals(SortedArrayMap.KEY, "key", "SortedArrayMap.KEY value failed.") ;
        }                

        public function testNONE():void
        {
            assertEquals(SortedArrayMap.NONE, 0 , "SortedArrayMap.NONE value failed.") ;
        }    
     
        public function testNUMERIC():void
        {
            assertEquals(SortedArrayMap.NUMERIC, 16, "SortedArrayMap.NUMERIC value failed.") ;
        }       

        public function testRETURNINDEXEDARRAY():void
        {
            assertEquals(SortedArrayMap.RETURNINDEXEDARRAY, 8, "SortedArrayMap.RETURNINDEXEDARRAY value failed.") ;
        }    
        
        public function testUNIQUESORT():void
        {
            assertEquals(SortedArrayMap.UNIQUESORT, 4, "SortedArrayMap.UNIQUESORT value failed.") ;
        }  
        
        public function testVALUE():void
        {
            assertEquals(SortedArrayMap.VALUE, "value", "SortedArrayMap.VALUE value failed.") ;
        }
        
        public function testConstructor():void
        {
        	
        }
        
        public function testComparator():void
        {
            
        }
        
        public function testOptions():void
        {
            
        }                

        public function testSortBy():void
        {
            
        }
        
        public function testSort():void
        {
            
        }         
        
        public function testSortOn():void
        {
            
        }        
        
    }
}
