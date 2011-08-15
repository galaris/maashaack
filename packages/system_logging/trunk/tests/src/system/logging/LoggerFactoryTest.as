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

    import system.errors.InvalidChannelError;

    public class LoggerFactoryTest extends TestCase 
    {
        public function LoggerFactoryTest(name:String = "")
        {
            super(name);
        }
        
        public var factory:LoggerFactory ;
        
        public function setUp():void
        {
            factory = new LoggerFactory() ;
        }
        
        public function tearDown():void
        {
            factory = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( factory , "The LoggerFactory reference not must be null.") ;
        }
        
        public function testGetLogger():void
        {
            var logger1:Logger = factory.getLogger("channel1") ;
            var logger2:Logger = factory.getLogger("channel1") ;
            var logger3:Logger = factory.getLogger("channel2") ;
            assertEquals( logger1 , logger2 , "The getLogger() method failed." ) ;
            assertNotSame( logger1 , logger3 , "The getLogger() method failed." ) ;
        }
        
        public function testGetLoggerWithNullChannel():void
        {
            try
            {
                factory.getLogger( null ) ;
                fail("01 - The getLogger() method must throw an InvalidChannelError error.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is InvalidChannelError , "02 - The getLogger() method must throw an InvalidChannelError error.") ;
                assertEquals( e.message , "Channels must be at least one character in length." , "03 - The getLogger() method must throw an InvalidChannelError error." ) ;
            }
        }
        
        public function testGetLoggerWithEmptyChannel():void
        {
            try
            {
                factory.getLogger( "" ) ;
                fail("01 - The getLogger() method must throw an InvalidChannelError error.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is InvalidChannelError , "02 - The getLogger() method must throw an InvalidChannelError error.") ;
                assertEquals( e.message , "Channels must be at least one character in length." , "03 - The getLogger() method must throw an InvalidChannelError error." ) ;
            }
        }
        
        public function testGetLoggerWithIllegalCharacters():void
        {
            var chars:String = LoggerStrings.ILLEGALCHARACTERS ;
            var a:Array      = chars.split("") ;
            var l:int        = a.length ;
            while( --l > -1 ) 
            {
                _isIllegalCharacters( a[l] ) ;
            }
        }
        
        public function testGetLoggerWithWildCard():void
        {
            try
            {
                factory.getLogger( "*" ) ;
                fail("01 - The getLogger() method must throw an InvalidChannelError error.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is InvalidChannelError , "02 - The getLogger() method must throw an InvalidChannelError error.") ;
                assertEquals( e.message , "Channels can not contain any of the following characters : []~$^&/\\(){}<>+=`!#%?,:;'\"@" , "03 - The getLogger() method must throw an InvalidChannelError error." ) ;
            }
        }
        
        private function _isIllegalCharacters( char:String ):void
        {
            try
            {
                factory.getLogger( char ) ;
                fail("The getLogger() method must throw an InvalidChannelError error with the character : " + char ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is InvalidChannelError , "02 - The getLogger() method must throw an InvalidChannelError error with the character : " + char ) ;
                assertEquals( e.message , "Channels can not contain any of the following characters : []~$^&/\\(){}<>+=`!#%?,:;'\"@" , "03 - The getLogger() method must throw an InvalidChannelError error with the character : " + char ) ;
            }
        }
    }
}
