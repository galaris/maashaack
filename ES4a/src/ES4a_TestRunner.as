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
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package
{
    import flash.display.Sprite;
    
    import buRRRn.ASTUce.*;
    
    import system.*;    

    public class ES4a_TestRunner extends Sprite
        {
        
        public function ES4a_TestRunner()
            {
            
            system.config.serializer.prettyPrinting = true;
            system.about( true, true );
            
            //tests

            buRRRn.ASTUce.config.showConstructorList = false;
            
            //testing ES4a core only
            //Runner.main( system.AllTests.suite() );
            
            //testing everything
            // Runner.main( buRRRn.ASTUce.tests.AllTests.suite(), system.AllTests.suite() );
            
            Runner.main( system.AllTests.suite() );
            
            }
        }
    }


