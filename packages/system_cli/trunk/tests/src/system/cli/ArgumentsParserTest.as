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

package system.cli
{
    import buRRRn.ASTUce.framework.*;

    public class ArgumentsParserTest extends TestCase
    {
        public function ArgumentsParserTest( name:String = "" )
        {
            super(name);
        }
        
        public function testNonSwitchOnly():void
        {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse(["hello.txt"]);

            assertTrue(result);            
            assertEquals(simple.a, false);
            assertEquals(simple.b, false);
            assertEquals(simple.c, "");
            assertEquals(simple.filename, "hello.txt");
        }

        public function testSwitchOnly():void
        {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse(["-a", "-b", "-c:z"]);
            
            assertFalse(result); //<filename> is required
            assertTrue(simple.debugTrace.indexOf("you have to provide a <filename>.") > -1);
            assertTrue(simple.debugTrace.indexOf("Usage: myApp [-a] [-b] [-c:x|y|z] <filename>") > -1);
            assertEquals(simple.a, true);
            assertEquals(simple.b, true);
            assertEquals(simple.c, "z");
            assertEquals(simple.filename, "");
        }

        public function testEmpty():void
        {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse([]);
            
            assertFalse(result);
            assertTrue(simple.debugTrace.indexOf("you have to provide a <filename>.") > -1);
            assertTrue(simple.debugTrace.indexOf("Usage: myApp [-a] [-b] [-c:x|y|z] <filename>") > -1);
        }

        public function testShowUsage():void
        {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse(["-?"]);
            
            assertFalse(result);
            assertFalse(simple.debugTrace.indexOf("you have to provide a <filename>.") > -1);
            assertTrue(simple.debugTrace.indexOf("Usage: myApp [-a] [-b] [-c:x|y|z] <filename>") > -1);
        }

        public function testInvalidSwitch():void
        {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse(["-x"]);
            
            assertFalse(result);
            assertTrue(simple.debugTrace.indexOf("CLI switch error: -x") > -1);
            assertTrue(simple.debugTrace.indexOf("Usage: myApp [-a] [-b] [-c:x|y|z] <filename>") > -1);
        }
        
        public function testInvalidSwitchValue():void
        {
            var simple:SimpleArgumentsParser = new SimpleArgumentsParser();
            var result:Boolean = simple.parse(["-c:a"]);
            
            assertFalse(result);
            assertTrue(simple.debugTrace.indexOf("CLI switch error: a is not a correct value for -c") > -1);
            assertTrue(simple.debugTrace.indexOf("Usage: myApp [-a] [-b] [-c:x|y|z] <filename>") > -1);
        }
    }
}
