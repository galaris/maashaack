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

package system.logging.targets 
{
    import buRRRn.ASTUce.framework.TestCase;

    public class SOSTargetTest extends TestCase 
    {
        public function SOSTargetTest(name:String = "")
        {
            super(name);
        }
        
        public var target:SOSTarget ;
        
        public function setUp():void
        {
            target = new SOSTarget( "application" , 0xFF0000 , true , "localhost" , 4444 , false ) ;
        }
        
        public function tearDown():void
        {
            target = undefined  ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( target , "Constructor failed.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( target is LineFormattedTarget , "The class must inherit the LineFormattedTarget class.") ;
        }
        
        public function testConnected():void
        {
            assertFalse( target.connected , "The connected property failed." ) ;
        }
        
        public function testHost():void
        {
            assertEquals( target.host , "localhost" , "The host property failed." ) ;
        }
        
        public function testLevelPolicy():void
        {
            assertTrue( target.levelPolicy , "01 - The levelPolicy property failed." ) ;
            target.levelPolicy = false ;
            assertFalse( target.levelPolicy , "02 - The levelPolicy property failed." ) ;
        }
        
        public function testPort():void
        {
            assertEquals( target.port , 4444 , "The port property failed." ) ;
        }
        
        ///// Default LoggerLevel colors

        public function testALL_COLOR():void
        {
            assertEquals( SOSTarget.ALL_COLOR , 0xE6E6E6 , "The SOSTarget.ALL_COLOR static property failed." ) ;
        }
        
        public function testDEBUG_COLOR():void
        {
            assertEquals( SOSTarget.DEBUG_COLOR , 0xDEECFE , "The SOSTarget.DEBUG_COLOR static property failed." ) ;
        }
        
        public function testDEFAULT_COLOR():void
        {
            assertEquals( SOSTarget.DEFAULT_COLOR , 0xFFFFFF , "The SOSTarget.DEFAULT_COLOR static property failed." ) ;
        }
        
        public function testERROR_COLOR():void
        {
            assertEquals( SOSTarget.ERROR_COLOR , 0xEDCC81 , "The SOSTarget.ERROR_COLOR static property failed." ) ;
        }
        
        public function testFATAL_COLOR():void
        {
            assertEquals( SOSTarget.FATAL_COLOR , 0xFDD1B5 , "The SOSTarget.FATAL_COLOR static property failed." ) ;
        }
        
        public function testINFO_COLOR():void
        {
            assertEquals( SOSTarget.INFO_COLOR , 0xD2FAB8 , "The SOSTarget.INFO_COLOR static property failed." ) ;
        }
        
        public function testWARN_COLOR():void
        {
            assertEquals( SOSTarget.WARN_COLOR , 0xFDFDB5 , "The SOSTarget.WARN_COLOR static property failed." ) ;
        }
        
        ///// SOS socket command patterns
        
        public function testAPPLICATION_COLOR():void
        {
            assertEquals( SOSTarget.APPLICATION_COLOR , "!SOS<appColor>{0}</appColor>" , "The SOSTarget.APPLICATION_COLOR static property failed." ) ;
        }
        
        public function testAPPLICATION_NAME():void
        {
            assertEquals( SOSTarget.APPLICATION_NAME , "!SOS<appName>{0}</appName>" , "The SOSTarget.APPLICATION_NAME static property failed." ) ;
        }        
        
        public function testCLEAR():void
        {
            assertEquals( SOSTarget.CLEAR , "!SOS<clear/>" , "The SOSTarget.CLEAR static property failed." ) ;
        }
        
        public function testIDENTIFY():void
        {
            assertEquals( SOSTarget.IDENTIFY , "!SOS<identify/>" , "The SOSTarget.IDENTIFY static property failed." ) ;
        }
        
        public function testLEVEL_COLOR():void
        {
            assertEquals( SOSTarget.LEVEL_COLOR , "!SOS<setKey><name>{0}</name><color>{1}</color></setKey>" , "The SOSTarget.LEVEL_COLOR static property failed." ) ;
        }
        
        public function testSHOW_MESSAGE():void
        {
            assertEquals( SOSTarget.SHOW_MESSAGE , "!SOS<showMessage key=\"{0}\"><![CDATA[{1}]]></showMessage>" , "The SOSTarget.SHOW_MESSAGE static property failed." ) ;
        }
        
        public function testSHOW_FOLD_MESSAGE():void
        {
            assertEquals( SOSTarget.SHOW_FOLD_MESSAGE , "!SOS<showFoldMessage key=\"{0}\"><title><![CDATA[{1}]]></title><message><![CDATA[{2}]]></message></showFoldMessage>" , "The SOSTarget.SHOW_FOLD_MESSAGE static property failed." ) ;
        }
    }
}
