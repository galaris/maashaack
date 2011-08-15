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
    
    import graphics.geom.Quaternion;
    
    public class QuaternionsTest extends TestCase 
    {
        public function QuaternionsTest(name:String = "")
        {
            super(name);
        }
        
        public function testSlerp():void
        {
            var q1:Quaternion ;
            var q2:Quaternion ;
            
            var slerp:Quaternion ;
            
            q1 = new Quaternion(1,2,3,4) ;
            q2 = new Quaternion(10,20,30,40) ;
            
            ///////////
            
            slerp = Quaternions.slerp(q1, q2, 0) ;
            assertEquals(slerp.x , 1 , "01 - slerp x failed.") ;
            assertEquals(slerp.y , 2 , "01 - slerp y failed.") ;
            assertEquals(slerp.z , 3 , "01 - slerp z failed.") ;
            assertEquals(slerp.w , 4 , "01 - slerp w failed.") ;
            
            ///////////
            
            slerp = Quaternions.slerp(q1, q2, 0.2) ;
            assertEquals(slerp.x ,  2.8 , "02 - slerp x failed.") ;
            assertEquals(slerp.y ,  5.6 , "02 - slerp y failed.") ;
            assertEquals(slerp.z ,  8.4 , "02 - slerp z failed.") ;
            assertEquals(slerp.w , 11.2 , "02 - slerp w failed.") ;
            
            ///////////
            
            slerp = Quaternions.slerp(q1, q2, 0.4) ;
            assertEquals(slerp.x ,  4.6 , "02 - slerp x failed.") ;
            assertEquals(slerp.y ,  9.2 , "02 - slerp y failed.") ;
            assertEquals(slerp.z , 13.8 , "02 - slerp z failed.") ;
            assertEquals(slerp.w , 18.4 , "02 - slerp w failed.") ;
            
            ///////////
            
            slerp = Quaternions.slerp(q1, q2, 0.5) ;
            assertEquals(slerp.x ,  5.5 , "03 - slerp x failed.") ;
            assertEquals(slerp.y , 11   , "03 - slerp y failed.") ;
            assertEquals(slerp.z , 16.5 , "03 - slerp z failed.") ;
            assertEquals(slerp.w , 22   , "03 - slerp w failed.") ;
            
            ///////////
            
            slerp = Quaternions.slerp(q1, q2, 0.8) ;
            assertEquals(slerp.x ,  8.2 , "04 - slerp x failed.") ;
            assertEquals(slerp.y , 16.4 , "04 - slerp y failed.") ;
            assertEquals(slerp.z , 24.6 , "04 - slerp z failed.") ;
            assertEquals(slerp.w , 32.8 , "04 - slerp w failed.") ;
            
            ///////////
            
            slerp = Quaternions.slerp(q1, q2, 1) ;
            assertEquals(slerp.x , 10 , "05 - slerp x failed.") ;
            assertEquals(slerp.y , 20 , "05 - slerp y failed.") ;
            assertEquals(slerp.z , 30 , "05 - slerp z failed.") ;
            assertEquals(slerp.w , 40 , "05 - slerp w failed.") ;
        }
    }
}
