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

package system.process 
{
    import buRRRn.ASTUce.framework.TestCase ;
    
    public class TimeoutPolicyTest extends TestCase 
    {
        public function TimeoutPolicyTest( name:String = "" )
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var policy:TimeoutPolicy = new TimeoutPolicy(9999) ;
            assertNotNull( policy , "TimeoutPolicy constructor failed, the instance not must be null." ) ;
        }
        
        public function testINFINITY():void
        {
            var policy:TimeoutPolicy = TimeoutPolicy.INFINITY ;
            assertEquals( policy.valueOf() , 0, "TimeoutPolicy.INFINITY failed." ) ;
        }
        
        public function testLIMIT():void
        {
            var policy:TimeoutPolicy = TimeoutPolicy.LIMIT ;
            assertEquals( policy.valueOf() , 1, "TimeoutPolicy.LIMIT failed." ) ;
        }
        
        public function testValueOf():void
        {
            var policy:TimeoutPolicy = new TimeoutPolicy(9999) ;
            assertEquals( policy.valueOf() , 9999, "TimeoutPolicy valueOf() failed." ) ;
        }
        
        public function testToSource():void
        {
            var source:String ;
            
            source = TimeoutPolicy.INFINITY.toSource() ;
            assertEquals( source , "new system.process.TimeoutPolicy(0)"  , "01 - TimeoutPolicy toSource() failed." ) ;
            
            source = TimeoutPolicy.LIMIT.toSource() ;
            assertEquals( source , "new system.process.TimeoutPolicy(1)"  , "02 - TimeoutPolicy toSource() failed." ) ;
        }
           
        public function testToString():void
        {
            var source:String ;
            
            source = TimeoutPolicy.INFINITY.toString() ;
            assertEquals( source , "0"  , "01 - TimeoutPolicy toString() failed." ) ;
        }
    }
}
