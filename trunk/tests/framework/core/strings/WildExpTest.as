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
package core.strings 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    public class WildExpTest extends TestCase 
    {
        public function WildExpTest(name:String = "")
        {
            super(name);
        }
        
        /**
         * find all the words in a string.
         */
        public function testWildExp1():void
        {
            var we:WildExp   = new WildExp( "*", WildExp.IGNORECASE | WildExp.MULTIWORD );
            var result:Array = we.test( "any phrases with words inside" );
            ArrayAssert.assertEquals( ["any","phrases","with","words","inside"] , result ) ;
            ArrayAssert.assertEquals( ["any","phrases","with","words","inside"] , we.wildcards ) ;
            ArrayAssert.assertEquals( [] , we.questionMarks ) ;  
        }
        
        /**
         * find all the words of exactly 4 letters in a string.
         */
        public function testWildExp2():void
        {
            var we:WildExp   = new WildExp( "????" , WildExp.IGNORECASE | WildExp.MULTIWORD );
            var result:Array = we.test(  "hell or eden the choice is not so hard :)))" );
            ArrayAssert.assertEquals( ["hell","eden","hard",":)))"] , result , "#1" ) ;
            ArrayAssert.assertEquals( [] , we.wildcards     , "#2" ) ;
            ArrayAssert.assertEquals( ["hell","oreden","thechoi","isnotsohard",":)))"] , we.questionMarks , "#3" ) ;  
        }
        
        /**
         * find comments in a string.
         */
        public function testWildExp3():void
        {
            var we:WildExp = new WildExp( "*/!**!*/*" , WildExp.IGNORECASE ) ;
            var result:*   = we.test( "abc/*hello world*/def" );
            assertTrue( result , "result: true" ) ;
            ArrayAssert.assertEquals( ["abc","hello world","def"] , we.wildcards ) ;
            ArrayAssert.assertEquals( [] , we.questionMarks ) ;  
        }
        
        /**
         * find single comments in a string.
         */
        public function testWildExp4():void
        {
            var we:WildExp = new WildExp( "*//*" , WildExp.IGNORECASE ) ;
            var result:*   = we.test( "abcdef //hello world" );
            assertTrue( result , "result: true" ) ;
            ArrayAssert.assertEquals( ["abcdef ","hello world"] , we.wildcards ) ;
            ArrayAssert.assertEquals( [] , we.questionMarks ) ;  
        }
        
        /**
         * find the name, arguments and body of a function.
         */
        public function testWildExp5():void
        {
            var we:WildExp = new WildExp( "function *(*)*{*}" , WildExp.IGNORECASE ) ;
            var result:*   = we.test( "function toto( a, b, c )\r\n\t{\t\r\n\treturn \"hello world\";\r\n\t}" );
            assertTrue( result , "result: true" ) ;
            ArrayAssert.assertEquals( [ "toto", " a, b, c " , "\r\n\t" , "\t\r\n\treturn \"hello world\";\r\n\t" ] , we.wildcards ) ;
            ArrayAssert.assertEquals( [] , we.questionMarks ) ;  
        }
        
        /**
         * find the name, arguments and body of a method.
         */
        public function testWildExp6():void
        {
            var we:WildExp = new WildExp( "*.prototype.*=*function*(*)*{*}" , WildExp.IGNORECASE ) ;
            var result:*   = we.test( "blah.prototype.toto = function( a, b, c )\r\n\t{\t\r\n\treturn \"hello world\";\r\n\t}" );
            assertTrue( result , "result: true" ) ;
            ArrayAssert.assertEquals( [ "blah", "toto " , " " , "" , " a, b, c " , "\r\n\t" , "\t\r\n\treturn \"hello world\";\r\n\t" ] , we.wildcards ) ;
            ArrayAssert.assertEquals( [] , we.questionMarks ) ;  
        }
    }
}
