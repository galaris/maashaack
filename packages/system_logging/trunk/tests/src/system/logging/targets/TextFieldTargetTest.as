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
    import library.ASTUce.framework.TestCase;
    
    import system.logging.LoggerLevel;
    
    import flash.text.TextField;
    
    public class TextFieldTargetTest extends TestCase 
    {
        public function TextFieldTargetTest(name:String = "")
        {
            super(name);
        }
        
        public var field:TextField ;
        
        public var target:TextFieldTarget ;
        
        public function setUp():void
        {
            field  = new TextField() ;
            target = new TextFieldTarget( field ) ;
        }
        
        public function tearDown():void
        {
            target = undefined  ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( target , "Constructor failed.") ;
            assertEquals(target.textfield , field , "The passed-in TextField in the constructor of the class failed.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( target is LineFormattedTarget , "The class must inherit the LineFormattedTarget class.") ;
        }
        
        public function testField():void
        {
            var textField:TextField  = new TextField() ;
            target.textfield = textField ;
            assertEquals(target.textfield , textField , "The textField property failed.") ;
        }
        
        public function testInternalLog():void
        {
            target.internalLog("test", LoggerLevel.DEBUG ) ;
            assertEquals( field.text , "test\r" , "The internalLog method failed.") ;
            field.text = "" ;
        }
        
        public function testInternalLogWithEmptyField():void
        {
            target.textfield = null ;
            try
            {
                target.internalLog("test", LoggerLevel.DEBUG ) ;
                fail("01 - if the textfield property is null the target must throws an error.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is ReferenceError , "02 - if the textfield property is null the target must throws an error.") ;
                assertEquals( e.message , "The internal textfield reference of the target not must be null." , "03 - if the textfield property is null the target must throws an error.") ;
            }
        }
    }
}
