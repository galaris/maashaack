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

package system.data.queues 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Collection;
    import system.data.Queue;
    import system.data.collections.ArrayCollection;
    import system.data.maps.ArrayMap;    

    public class LinearQueueTest extends TestCase 
    {

        public function LinearQueueTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var q:LinearQueue = new LinearQueue() ;
            
            assertNotNull(q, "01-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [], "01-02 - LinearQueue constructor failed.") ;
            
            // initialize with an Array
                        
            q = new LinearQueue([2,3,4]) ; 
            assertNotNull(q, "02-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [2,3,4], "02-02 - LinearQueue constructor failed.") ;
            
            // initialize with a Collection
            
            q = new LinearQueue(new ArrayCollection([2,3,4])) ; 
            assertNotNull(q, "03-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [2,3,4], "03-02 - LinearQueue constructor failed.") ;
            
            // initialize with an Iterable object
            
            q = new LinearQueue(new ArrayMap(["key1","key2","key3"],["value1","value2","value3"])) ; 
            assertNotNull(q, "04-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), ["value1","value2","value3"], "04-02 - LinearQueue constructor failed.") ;
            
        }
        
        public function testInherit():void
        {
            var q:LinearQueue = new LinearQueue() ;
            assertTrue( q is ArrayCollection , "LinearQueue must extends the ArrayCollection class.") ;          
        }        
        
        public function testInterface():void
        {
        	var q:LinearQueue = new LinearQueue() ;
        	assertTrue( q is Queue , "01 - LinearQueue must implements the Queue interface.") ;        	
        	assertTrue( q is Collection , "02 - LinearQueue must implements the Queue interface.") ;
        }

    }

}
