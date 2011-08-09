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
    import buRRRn.ASTUce.framework.TestCase;

    public class EdgeMetricsTest extends TestCase 
    {
        public function EdgeMetricsTest(name:String = "")
        {
            super( name );
        }
        
        public var e:EdgeMetrics ;
        
        public function setUp():void
        {
            e = new EdgeMetrics() ;
        }
        
        public function tearDown():void
        {
            e = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( e, "01 - EdgeMetrics constructor not must be null") ;
            assertTrue( e is EdgeMetrics , "02 - Must be an instance of EdgeMetrics.") ;
            
            assertEquals( e.left   , 0, "03-01 - EdgeMetrics.EMPTY failed") ;
            assertEquals( e.top    , 0, "03-02 - EdgeMetrics.EMPTY failed") ;
            assertEquals( e.right  , 0, "03-03 - EdgeMetrics.EMPTY failed") ;
            assertEquals( e.bottom , 0, "03-04 - EdgeMetrics.EMPTY failed") ; 
            
            var em:EdgeMetrics  ;
            
            em = new EdgeMetrics(10,20,30,40) ;
            
            assertEquals( em.left   , 10, "04-01 - EdgeMetrics.EMPTY failed") ;
            assertEquals( em.top    , 20, "04-02 - EdgeMetrics.EMPTY failed") ;
            assertEquals( em.right  , 30, "04-03 - EdgeMetrics.EMPTY failed") ;
            assertEquals( em.bottom , 40, "04-04 - EdgeMetrics.EMPTY failed") ;
            
        }
        
        public function testInterface():void
        {
            assertTrue( e is Geometry , "EdgeMetrics must implement the Geometry interface.") ;
        }
        
        public function testEMPTY():void
        {
            var em:EdgeMetrics = EdgeMetrics.EMPTY ;
            assertEquals( em.top, 0, "01 - EdgeMetrics.EMPTY failed") ;
            assertEquals( em.left, 0, "02 - EdgeMetrics.EMPTY failed") ;
            assertEquals( em.right, 0, "03 - EdgeMetrics.EMPTY failed") ;
            assertEquals( em.bottom, 0, "04 - EdgeMetrics.EMPTY failed") ;
        }
        
        public function testHorizontal():void
        {
            assertEquals( e.horizontal , 0 ) ;
            e.left  = 10 ;
            e.right = 20 ;
            assertEquals( e.horizontal , 30 ) ;
        }
        
        public function testVertical():void
        {
            assertEquals( e.vertical , 0 ) ;
            e.top    = 10 ;
            e.bottom = 20 ;
            assertEquals( e.vertical , 30 ) ;
        }
        
        public function testClone():void
        {
            var clone:EdgeMetrics = e.clone() as EdgeMetrics ;
            assertNotNull( clone , "01 - EdgeMetrics clone failed") ;
        }
        
        public function testEquals():void
        {
            var e1:EdgeMetrics = new EdgeMetrics() ;
            var e2:EdgeMetrics = new EdgeMetrics(10,20,30,40) ;
            var e3:EdgeMetrics = new EdgeMetrics(10,20,30,40) ;
            
            assertTrue  ( e1.equals(e1) , "01-01 - EdgeMetrics.equals method failed.") ;
            assertFalse ( e1.equals(e2) , "01-02 - EdgeMetrics.equals method failed.") ;
            assertFalse ( e1.equals(e3) , "01-03 - EdgeMetrics.equals method failed.") ;
            
            assertFalse ( e2.equals(e1) , "02-01 - EdgeMetrics.equals method failed.") ;
            assertTrue  ( e2.equals(e2) , "02-02 - EdgeMetrics.equals method failed.") ;
            assertTrue  ( e2.equals(e3) , "01-03 - EdgeMetrics.equals method failed.") ;
            
            assertFalse ( e3.equals(e1) , "03-01 - EdgeMetrics.equals method failed.") ;
            assertTrue  ( e3.equals(e2) , "03-02 - EdgeMetrics.equals method failed.") ;
            assertTrue  ( e3.equals(e3) , "03-03 - EdgeMetrics.equals method failed.") ;
        }
        
        public function testToObject():void
        {
            var o:Object ;
            
            o = e.toObject() ;
            assertEquals( o.left   , e.left   , "01 - toObject failed." ) ;
            assertEquals( o.top    , e.top    , "02 - toObject failed." ) ;
            assertEquals( o.right  , e.right  , "03 - toObject failed." ) ;
            assertEquals( o.bottom , e.bottom , "04 - toObject failed." ) ;
            
            var em:EdgeMetrics = new EdgeMetrics(10,20,30,40) ; 
            o = em.toObject() ;
            assertEquals( o.left   , em.left   , "01 - toObject failed." ) ;
            assertEquals( o.top    , em.top    , "02 - toObject failed." ) ;
            assertEquals( o.right  , em.right  , "03 - toObject failed." ) ;
            assertEquals( o.bottom , em.bottom , "04 - toObject failed." ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( e.toSource() , "new graphics.geom.EdgeMetrics(0,0,0,0)", "01 - toSource failed." ) ;
        }
        
        public function testToString():void
        {
            assertEquals( e.toString() , "[EdgeMetrics left:0 top:0 right:0 bottom:0]", "01 - toString failed." ) ;
        }
    }
}