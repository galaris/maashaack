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

package system.logging 
{
    import library.ASTUce.framework.TestCase;
    
    import system.Enum;
    
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
        
        public function testDEFAULT_LEVEL_STRING():void
        {
            assertEquals( LoggerLevel.DEFAULT_LEVEL_STRING  , "UNKNOWN" , "DEFAULT_LEVEL_STRING static property failed.") ;
        }
        
        public function testInherit():void
        {
            var enum:LoggerLevel = new LoggerLevel(999999 , "test") ;
            assertTrue( enum is Enum , "Must inherit the Enum class.") ;
        }
        
        public function testNONE():void
        {
            assertEquals( LoggerLevel.NONE, new LoggerLevel(0, "NONE" ) , "LoggerLevel.NONE failed.") ;
        }
        
        public function testALL():void
        {
            assertEquals( LoggerLevel.ALL, new LoggerLevel( 1 , "ALL" ) , "LoggerLevel.ALL failed.") ;
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
            assertEquals( LoggerLevel.FATAL, new LoggerLevel( 16 , "FATAL" ) , "LoggerLevel.FATAL failed.") ;
        }
        
        public function testINFO():void
        {
            assertEquals( LoggerLevel.INFO, new LoggerLevel( 4 , "INFO" ) , "LoggerLevel.INFO failed.") ;
        }
        
        public function testWARN():void
        {
            assertEquals( LoggerLevel.WARN, new LoggerLevel( 6 , "WARN" ) , "LoggerLevel.WARN failed.") ;
        }
        
        public function testWTF():void
        {
            assertEquals( LoggerLevel.WTF, new LoggerLevel( 32 , "WTF" ) , "LoggerLevel.WTF failed.") ;
        }
        
        public function testEquals():void
        {
            var enum:LoggerLevel = new LoggerLevel(999999 , "test") ;
            assertTrue( enum.equals( new LoggerLevel(999999 , "test") ) , "equals method failed." ) ;
        }
        
        public function testGetLevel():void
        {
            assertEquals( LoggerLevel.getLevel(  0 ) , LoggerLevel.NONE  , "00 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel(  1 ) , LoggerLevel.ALL   , "01 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel(  2 ) , LoggerLevel.DEBUG , "02 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel(  4 ) , LoggerLevel.INFO  , "05 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel(  6 ) , LoggerLevel.WARN  , "06 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel(  8 ) , LoggerLevel.ERROR , "07 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel( 16 ) , LoggerLevel.FATAL , "08 - LoggerLevel.getLevel failed." ) ;
            assertEquals( LoggerLevel.getLevel( 32 ) , LoggerLevel.WTF   , "09 - LoggerLevel.getLevel failed." ) ;
            assertNull( LoggerLevel.getLevel( 10 ) , "07 - LoggerLevel.getLevel failed must returns null with an unknow value."  ) ;
        }
        
        public function testGetLevelString():void
        {
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.ALL   ) , "ALL"   , "01 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.DEBUG ) , "DEBUG" , "02 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.ERROR ) , "ERROR" , "03 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.FATAL ) , "FATAL" , "04 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.INFO  ) , "INFO"  , "05 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.WARN  ) , "WARN"  , "06 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( LoggerLevel.WTF   ) , "WTF"   , "07 - LoggerEvent.getLevelString() failed." ) ;
            assertEquals( LoggerLevel.getLevelString( new LoggerLevel(55,"TEST") )  , "UNKNOWN" , "07 - LoggerEvent.getLevelString() failed." ) ;
        }
        
        public function testIsValidLevel():void
        {
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.NONE  ) , "00 - LoggerLevel.NONE is invalid"   ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.ALL   ) , "01 - LoggerLevel.ALL is invalid"   ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.DEBUG ) , "02 - LoggerLevel.DEBUG is invalid" ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.ERROR ) , "03 - LoggerLevel.ERROR is invalid" ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.FATAL ) , "04 - LoggerLevel.FATAL is invalid" ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.INFO  ) , "05 - LoggerLevel.INFO is invalid"  ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.WARN  ) , "06 - LoggerLevel.WARN is invalid"  ) ;
            assertTrue( LoggerLevel.isValidLevel( LoggerLevel.WTF   ) , "07 - LoggerLevel.WTF is invalid"  ) ;
            assertFalse( LoggerLevel.isValidLevel( new LoggerLevel(55,"TEST") ) , "07 - Custom LoggerLevel is invalid"  ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( LoggerLevel.NONE.toSource()  , "system.logging.LoggerLevel.NONE"  , "00 - LoggerLevel.NONE toSource() failed."   ) ;
            assertEquals( LoggerLevel.ALL.toSource()   , "system.logging.LoggerLevel.ALL"   , "01 - LoggerLevel.ALL toSource() failed."   ) ;
            assertEquals( LoggerLevel.DEBUG.toSource() , "system.logging.LoggerLevel.DEBUG" , "02 - LoggerLevel.DEBUG toSource() failed." ) ;
            assertEquals( LoggerLevel.ERROR.toSource() , "system.logging.LoggerLevel.ERROR" , "03 - LoggerLevel.ERROR toSource() failed." ) ;
            assertEquals( LoggerLevel.FATAL.toSource() , "system.logging.LoggerLevel.FATAL" , "04 - LoggerLevel.FATAL toSource() failed." ) ;
            assertEquals( LoggerLevel.INFO.toSource()  , "system.logging.LoggerLevel.INFO"  , "05 - LoggerLevel.INFO toSource() failed."  ) ;
            assertEquals( LoggerLevel.WARN.toSource()  , "system.logging.LoggerLevel.WARN"  , "06 - LoggerLevel.WARN toSource() failed."  ) ;
            assertEquals( LoggerLevel.WTF.toSource()   , "system.logging.LoggerLevel.WTF"   , "07 - LoggerLevel.WTF toSource() failed."  ) ;
        }
    }
}
