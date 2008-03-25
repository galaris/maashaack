
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system
    {
    import buRRRn.ASTUce.framework.*;
    
    import system.IEquatable;
    
    public class EqualityTest extends TestCase
        {
        
        public function EqualityTest( name:String="" )
            {
            super( name );
            }
        
        public function testBasic():void
            {
            var eq1:Equatable = new Equatable( "a", "b" );
            var eq2:Equatable = new Equatable( "a", "b" );
            
            assertTrue( eq1 is IEquatable );
            assertEquals( eq1, eq2 );
            assertEquals( eq1, new Equatable( "a", "b" ) );
            }
        
        }
    
    }
