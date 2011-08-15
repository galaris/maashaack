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

package graphics.geom 
{
    import library.ASTUce.framework.TestCase;
    
    public class RingTest extends TestCase 
    {
        public function RingTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var r:Ring = new Ring() ;
            assertNotNull( r                 , "01 - constructor failed.") ;
            assertNull   ( r.center          , "02 - clone method failed." ) ;
            assertNull   ( r.up              , "03 - clone method failed." ) ;
            assertEquals ( r.innerRadius , 0 , "04 - clone method failed." ) ;
            assertEquals ( r.outerRadius , 1 , "05 - clone method failed." ) ;
        }
        
        public function testConstructorWithArguments():void
        {
            var r:Ring = new Ring(new Vector3(0,0,0), new Vector3(10,20,30),10,20) ;
            assertNotNull( r                                    , "01 - constructor failed." ) ;
            assertEquals( r.center      , new Vector3(0,0,0)    , "02 - clone method failed." ) ;
            assertEquals( r.up          , new Vector3(10,20,30) , "03 - clone method failed." ) ;
            assertEquals( r.innerRadius , 10                    , "04 - clone method failed." ) ;
            assertEquals( r.outerRadius , 20                    , "05 - clone method failed." ) ;
        }
        
        public function testInterface():void
        {
        	var r:Ring = new Ring() ;
            assertTrue( r is Geometry , "Must implements the Geometry interface.") ;
        }   
            
        public function testClone():void
        {
            var r:Ring ; 
            var c:Ring ;
            r = new Ring(new Vector3(0,0,0), new Vector3(10,20,30),10,20) ;
            c = r.clone() as Ring ;
            assertNotNull( c                            , "01 - clone method failed." ) ;
            assertEquals( r.center      , c.center      , "02 - clone method failed." ) ;
            assertEquals( r.up          , c.up          , "03 - clone method failed." ) ;
            assertEquals( r.innerRadius , c.innerRadius , "04 - clone method failed." ) ;
            assertEquals( r.outerRadius , c.outerRadius , "05 - clone method failed." ) ;
        }
        
        public function testCloneEmptyRing():void
        {
            var r:Ring ; 
            var c:Ring ;
            r = new Ring() ;
            c = r.clone() as Ring ;
            assertNotNull( c                            , "01 - clone method failed." ) ;
            assertEquals( r.center      , c.center      , "02 - clone method failed." ) ;
            assertEquals( r.up          , c.up          , "03 - clone method failed." ) ;
            assertEquals( r.innerRadius , c.innerRadius , "04 - clone method failed." ) ;
            assertEquals( r.outerRadius , c.outerRadius , "05 - clone method failed." ) ;
        }
        
        public function testEquals():void
        {
            var r0:Ring ;
            var r1:Ring = new Ring() ;
            var r2:Ring = new Ring() ;
            var r3:Ring = new Ring(new Vector3(0,0,0), new Vector3(10,20,30),10,20) ;
            var r4:Ring = new Ring(new Vector3(0,0,0), new Vector3(10,20,30),10,20) ;
            var r5:Ring = new Ring(new Vector3(1,1,1), new Vector3(10,20,30),10,20) ;
            var r6:Ring = new Ring(new Vector3(0,0,0), new Vector3(11,21,31),10,20) ;
            var r7:Ring = new Ring(new Vector3(0,0,0), new Vector3(10,20,30),11,20) ;
            var r8:Ring = new Ring(new Vector3(0,0,0), new Vector3(10,20,30),10,21) ;
                        
            assertFalse ( r1.equals( r0 ) , "01-01 - equals method failed.") ; // null
            assertTrue  ( r1.equals( r1 ) , "01-02 - equals method failed.") ; // same
            assertTrue  ( r1.equals( r2 ) , "01-02 - equals method failed.") ; // equals but not the same reference
            assertFalse ( r1.equals( r4 ) , "01-03 - equals method failed.") ; // no equals
            
            assertFalse ( r3.equals( r0 ) , "02-01 - equals method failed.") ;
            assertFalse ( r3.equals( r1 ) , "02-02 - equals method failed.") ;
            assertFalse ( r3.equals( r2 ) , "02-03 - equals method failed.") ;
            assertTrue  ( r3.equals( r3 ) , "02-04 - equals method failed.") ; // same
            assertTrue  ( r3.equals( r4 ) , "02-05 - equals method failed.") ; // equals but not the same reference
            assertFalse ( r3.equals( r5 ) , "02-06 - equals method failed.") ;
            assertFalse ( r3.equals( r6 ) , "02-07 - equals method failed.") ;
            assertFalse ( r3.equals( r7 ) , "02-08 - equals method failed.") ;
            assertFalse ( r3.equals( r8 ) , "02-09 - equals method failed.") ;
        }
        
        public function testToSource():void
        {
            var r:Ring = new Ring() ;
            assertEquals( r.toSource() , "new graphics.geom.Ring(null,null,0,1)", "01 - toSource failed." ) ;
        }
        
        public function testToString():void
        {
            var r:Ring = new Ring() ;
            assertEquals( r.toString() , "[Ring]", "toString failed." ) ;
        }
        
    }
}