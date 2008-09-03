/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;    

    public class CloneableTest extends TestCase 
    {
        
        public function CloneableTest(name:String = "")
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var c:CloneableClass = new CloneableClass();
            
            assertTrue( c is Cloneable ) ;
            
            var clone:CloneableClass = c.clone() ;
            
            assertNotSame( c , clone ) ;
            assertEquals( c.index , clone.index ) ;
            
        }        
        
    }
}

import system.Cloneable;

class CloneableClass implements Cloneable
{
    
    public function CloneableClass( index:uint=0 )
    {
        this.index = index ;	
    }
    
    public var index:uint ;
    
    public function clone():*
    {
    	return new CloneableClass( index ) ;
    }
}
