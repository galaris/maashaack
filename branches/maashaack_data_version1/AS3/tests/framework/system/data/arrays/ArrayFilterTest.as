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

package system.data.arrays 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import flash.events.EventDispatcher;    

    public class ArrayFilterTest extends TestCase 
    {

        public function ArrayFilterTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
        	
        	var af:ArrayFilter ;
        	
        	af = new ArrayFilter() ;
        	
        	assertNotNull( af , "01-01 - ArrayFilter constructor failed." ) ;
        	assertTrue( af is EventDispatcher , "01-02 - ArrayFilter constructor failed." ) ;
        	assertEquals( af.filter , 0 ,  "01-03 - ArrayFilter constructor failed." ) ;
        	
        	af = new ArrayFilter( ArrayFilter.CASEINSENSITIVE ) ;
            assertNotNull( af , "02-01 - ArrayFilter constructor failed." ) ;
        	assertEquals( af.filter , ArrayFilter.CASEINSENSITIVE ,  "02-02 - ArrayFilter constructor failed." ) ;
        	
        	
            af = new ArrayFilter( ArrayFilter.DESCENDING, new EventDispatcher()   ) ;
            assertNotNull( af , "03-01 - ArrayFilter constructor failed." ) ;
            assertEquals( af.filter , ArrayFilter.DESCENDING ,  "03-02 - ArrayFilter constructor failed." ) ;
        	
        }
        
        public function testCASEINSENSITIVE():void
        {
            assertEquals( ArrayFilter.CASEINSENSITIVE , 1 , "The constant ArrayFilter.CASEINSENSITIVE failed." ) ;	
        }

        public function testDESCENDING():void
        {
            assertEquals( ArrayFilter.DESCENDING , 2 , "The constant ArrayFilter.DESCENDING failed." ) ;  
        }
        
        public function testNONE():void
        {
            assertEquals( ArrayFilter.NONE , 0 , "The constant ArrayFilter.NONE failed." ) ;  
        }
                
        public function testNUMERIC():void
        {
            assertEquals( ArrayFilter.NUMERIC , 16 , "The constant ArrayFilter.NUMERIC failed." ) ;  
        }        

        public function testRETURNINDEXEDARRAY():void
        {
            assertEquals( ArrayFilter.RETURNINDEXEDARRAY , 8 , "The constant ArrayFilter.RETURNINDEXEDARRAY failed." ) ;  
        }
     
        public function testUNIQUESORT():void
        {
            assertEquals( ArrayFilter.UNIQUESORT , 4 , "The constant ArrayFilter.UNIQUESORT failed." ) ;  
        }
        
        public function testFilter():void
        {
            
            var af:ArrayFilter ;
            
            af = new ArrayFilter() ;
            
            af.filter = ArrayFilter.NONE ;
            assertEquals( af.filter , ArrayFilter.NONE , "01 - The ArrayFilter filter property failed." ) ;  
            
            af.filter = ArrayFilter.DESCENDING | ArrayFilter.NUMERIC  ;
            assertEquals( af.filter , ArrayFilter.DESCENDING | ArrayFilter.NUMERIC , "02 - The ArrayFilter filter property failed." ) ;
            
        } 
        
        public function testUseEvent():void
        {
            var af:ArrayFilter = new ArrayFilter() ;
            
            assertTrue( af.useEvent , "01 - The ArrayFilter useEvent property failed." ) ;  
            
            af.useEvent = false ;
            assertFalse( af.useEvent , "02 - The ArrayFilter useEvent property failed." ) ;
            
            af.useEvent = true ;
            assertTrue( af.useEvent , "03 - The ArrayFilter useEvent property failed." ) ;
        } 
        
        public function testContains():void
        {
            
            //TODO 
            
//            assertTrue
//            ( 
//                ArrayFilter.contains( ArrayFilter.NUMERIC , ArrayFilter.DESCENDING ) , 
//                "01-01 - The ArrayFilter.contains method failed." 
//            ) ;
            
            //assertTrue( ArrayFilter.contains(ArrayFilter.NUMERIC | Array.NUMERIC    ,ArrayFilter.DESCENDING )  , "01-02 - The ArrayFilter.contains method failed." ) ;  
            //assertTrue( ArrayFilter.contains(ArrayFilter.NUMERIC | Array.DESCENDING ,ArrayFilter.DESCENDING )  , "01-03 - The ArrayFilter.contains method failed." ) ;
            //assertFalse( ArrayFilter.contains(0 ,  ArrayFilter.NUMERIC ), "01-02 - The ArrayFilter.contains method failed." ) ;
            
            //assertTrue( ArrayFilter.contains(ArrayFilter.NUMERIC ,  ArrayFilter.NUMERIC ), "02-01 - The ArrayFilter.contains method failed." ) ;  
            //assertFalse( ArrayFilter.contains(ArrayFilter.NUMERIC ,  ArrayFilter.NONE ), "02-02 - The ArrayFilter.contains method failed." ) ;
            
        }
        
        public function testIsCaseInsensitive():void
        {
            
            var af:ArrayFilter = new ArrayFilter() ;
            assertFalse( af.isCaseInsensitive() , "01 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.setCaseInsensitive(true) ;
            assertTrue( af.isCaseInsensitive() , "02 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.setCaseInsensitive(false) ;
            assertFalse( af.isCaseInsensitive() , "03 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.filter = ArrayFilter.CASEINSENSITIVE ;
            assertTrue( af.isCaseInsensitive() , "04 - The ArrayFilter isCaseInsensitive method failed.") ;
            
            af.filter = ArrayFilter.NONE ;
            assertFalse( af.isCaseInsensitive() , "05 - The ArrayFilter isCaseInsensitive method failed.") ;
            
        }              
        
    }
}
