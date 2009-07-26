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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.logging 
{
    import buRRRn.ASTUce.framework.TestCase;

    public class LoggerLevelTest extends TestCase 
    {
        public function LoggerLevelTest( name:String = "" )
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var enum:LoggerLevel = new LoggerLevel(999999 , "test") ;
            assertNotNull( enum , "01 - LoggerLevel constructor failed.") ;
            assertEquals( enum.toString() , "test" , "02 - LoggerLevel constructor failed, the toString() method of the LoggerLevel class failed.") ;
            assertEquals( enum.valueOf() , 999999 , "03 - LoggerLevel constructor failed, the valueOf() method of the LoggerLevel class failed.") ;
        }
        
        public function testALL():void
        {
            assertEquals( LoggerLevel.ALL, new LoggerLevel( 0 , "ALL" ) , "LoggerLevel.ALL failed.") ;
        }
        
        public function testDEBUG():void
        {
            assertEquals( LoggerLevel.DEBUG, new LoggerLevel( 2 , "DEBUG" ) , "LoggerLevel.DEBUG failed.") ;
        }
        
        public function testERROR():void
        {
            assertEquals( LoggerLevel.ERROR, new LoggerLevel( 8 , "ERROR" ) , "LoggerLevel.ERROR failed.") ;
        }
        
        public function testFATAL():void
        {
            assertEquals( LoggerLevel.FATAL, new LoggerLevel( 1000 , "FATAL" ) , "LoggerLevel.FATAL failed.") ;
        }
        
        public function testINFO():void
        {
            assertEquals( LoggerLevel.INFO, new LoggerLevel( 4 , "INFO" ) , "LoggerLevel.INFO failed.") ;
        }
        
        public function testWARN():void
        {
            assertEquals( LoggerLevel.WARN, new LoggerLevel( 6 , "WARN" ) , "LoggerLevel.WARN failed.") ;
        }
    }
}
