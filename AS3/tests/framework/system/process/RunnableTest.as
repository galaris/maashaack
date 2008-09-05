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

package system.process 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.process.Runnable;                        

    public class RunnableTest extends TestCase 
    {

        public function RunnableTest(name:String = "")
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var c:RunnableClass = new RunnableClass();
            
            assertTrue( c is Runnable ) ;
            
            try
            {
            	c.run() ;
            	fail( "The Runnable interface failed, the RunnableClass must throw an error") ;
            }
            catch( e1:Error )
            {
            	//assertEquals( e1.toString() , "run invoked 0" , "The Runnable interface failed.") ;
            }

            try
            {
                c.run(2,3,4) ;
                fail( "The Runnable interface failed, the RunnableClass must throw an error") ;
            }
            catch( e2:Error )
            {
                //assertEquals( e2.toString() , "run invoked 3" , "The Runnable interface failed.") ;
            }

            
        }
    
        
        
    }
}

import system.process.Runnable;

class RunnableClass implements Runnable
{

    public function RunnableClass()
    {
        //    
    }
    
    public function run(...arguments:Array):void
    {
    	throw new Error( "run invoked " + arguments.length ) ;
    }
}