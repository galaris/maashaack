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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

    import system.events.LoggerEvent;
    import system.logging.mocks.MockLoggerListener;

    import flash.events.EventDispatcher;

    public class LogLoggerTest extends TestCase 
    {
        public function LogLoggerTest(name:String = "")
        {
            super(name);
        }
        
        public var logger:LogLogger ;
        
        public var listener:MockLoggerListener ;
        
        public function setUp():void
        {
            logger   = new LogLogger( "channel" ) ;
            listener = new MockLoggerListener( logger ) ;
        }
        
        public function tearDown():void
        {
            listener.unregister() ;
            listener = undefined  ;
            logger   = undefined  ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( logger , "LogLogger constructor failed." ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( logger is EventDispatcher , "LogLogger must inherit the EventDispatcher class.") ;
        }
        
        public function testChannel():void
        {
            assertEquals( logger.channel , "channel" , "channel property failed." ) ;
        }
        
        public function testLog():void
        {
            logger.log( "hello {0}" , "world" ) ;
            assertTrue( listener.called    , "LoggerEvent.Log event must be notify." ) ;
            assertEquals( listener.type    , LoggerEvent.LOG   , "LoggerEvent.Log event type isn't valid." );
            assertEquals( listener.message , "hello world"     , "LoggerEvent.Log event message isn't valid." );
            assertEquals( listener.level   , LoggerLevel.ALL , "LoggerEvent.Log event level isn't valid." );
        }
        
        public function testDebug():void
        {
            logger.debug( "hello {0}" , "world" ) ;
            assertTrue( listener.called    , "LoggerEvent.Log event must be notify." ) ;
            assertEquals( listener.type    , LoggerEvent.LOG   , "LoggerEvent.Log event type isn't valid." );
            assertEquals( listener.message , "hello world"     , "LoggerEvent.Log event message isn't valid." );
            assertEquals( listener.level   , LoggerLevel.DEBUG , "LoggerEvent.Log event level isn't valid." );
        }
        
        public function testError():void
        {
            logger.error( "hello {0}" , "world" ) ;
            assertTrue( listener.called    , "LoggerEvent.Log event must be notify." ) ;
            assertEquals( listener.type    , LoggerEvent.LOG   , "LoggerEvent.Log event type isn't valid." );
            assertEquals( listener.message , "hello world"     , "LoggerEvent.Log event message isn't valid." );
            assertEquals( listener.level   , LoggerLevel.ERROR , "LoggerEvent.Log event level isn't valid." );
        }
        
        public function testFatal():void
        {
            logger.fatal( "hello {0}" , "world" ) ;
            assertTrue( listener.called    , "LoggerEvent.Log event must be notify." ) ;
            assertEquals( listener.type    , LoggerEvent.LOG   , "LoggerEvent.Log event type isn't valid." );
            assertEquals( listener.message , "hello world"     , "LoggerEvent.Log event message isn't valid." );
            assertEquals( listener.level   , LoggerLevel.FATAL , "LoggerEvent.Log event level isn't valid." );
        }
        
        public function testInfo():void
        {
            logger.info( "hello {0}" , "world" ) ;
            assertTrue( listener.called    , "LoggerEvent.Log event must be notify." ) ;
            assertEquals( listener.type    , LoggerEvent.LOG   , "LoggerEvent.Log event type isn't valid." );
            assertEquals( listener.message , "hello world"     , "LoggerEvent.Log event message isn't valid." );
            assertEquals( listener.level   , LoggerLevel.INFO  , "LoggerEvent.Log event level isn't valid." );
        }
        
        public function testWarn():void
        {
            logger.warn( "hello {0}" , "world" ) ;
            assertTrue( listener.called    , "LoggerEvent.Log event must be notify." ) ;
            assertEquals( listener.type    , LoggerEvent.LOG   , "LoggerEvent.Log event type isn't valid." );
            assertEquals( listener.message , "hello world"     , "LoggerEvent.Log event message isn't valid." );
            assertEquals( listener.level   , LoggerLevel.WARN  , "LoggerEvent.Log event level isn't valid." );
        }
    }
}
