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
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package
    {
    import flash.display.Sprite;
    
    import system.*;
    import system.diagnostics.VirtualMachine;
    
    /* to help diagnose the order of initialization
       
       example of result:
        ------------------------------------------------------
        global$init()
        global/system::about(true,true)
        global$init()
        global/system::info(true,true)
        global$init()
        system::Version$cinit()
        system::Version(0,1,0,0)
        Object()
        system::Version/set major(0)
        global$init()
        Math$cinit()
        Math$/_min()
        system::Version/set minor(1)
        Math$/_min()
        system::Version/set build(0)
        Math$/_min()
        system::Version/set revision(0)
        Math$/_min()
        String/split(" ",4294967295)
        String$/_split()
        global/parseInt()
        system::Version/set revision(255)
        Math$/_min()
        global$init()
        system::Environment$cinit()
        system::Environment$/get host()
        system::Environment$/_getHostID()
        etc.
    */
    public class Framework_Diagnostics extends Sprite
        {
        
        public function Framework_Diagnostics()
            {
            VirtualMachine.beginTrace();
            
            system.about( true, true );
            
            VirtualMachine.endTrace();
            }
        
        }
    }

