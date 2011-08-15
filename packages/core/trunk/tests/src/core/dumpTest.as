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

package core
{
    import library.ASTUce.framework.TestCase;
    
    public class dumpTest extends TestCase
    {
        public function dumpTest(name:String="")
        {
            super(name);
        }
        
        public function testArray():void
        {
            assertEquals( "[]" , dump( [] ) ) ;
            assertEquals( "[1]" , dump( [1] ) ) ;
            assertEquals( "[1,2,3]" , dump( [1,2,3] ) ) ;
            assertEquals( "[\"hello\",\"world\"]" , dump( ["hello","world"] ) ) ;
            assertEquals( "[\"hello\",1,true]" , dump( ["hello",1,true] ) ) ;
            assertEquals( "\n[\n    \n]" , dump( [] , true ) ) ;
            assertEquals( "\n[\n    1\n]" , dump( [1] , true ) ) ;
        }
        
        public function testDate():void
        {
            assertEquals( "new Date(2010,4,5,8,23,50,10)" , dump( new Date( 2010, 4, 5, 8, 23, 50, 10 ) ) ) ;
        }
        
        public function testObject():void
        {
            assertEquals( "{}" , dump( {} ) ) ;
            assertEquals( "{prop:1}" , dump( { prop:1 } ) ) ;
            assertEquals( "{prop1:1,prop2:2}" , dump( { prop1:1 , prop2:2 } ) ) ;
            assertEquals( "{prop1:\"hello\",prop2:\"world\"}" , dump( { prop1:"hello", prop2:"world"} ) ) ;
            assertEquals( "\n{\n    \n}" , dump( {} , true ) ) ;
            assertEquals( "\n{\n    prop1:1\n}" , dump( {prop1:1} , true ) ) ;
            assertEquals( "\n{\n    prop1:1,\n    prop2:2\n}" , dump( {prop1:1,prop2:2} , true ) ) ;
            assertEquals( "\n    {\n        \n    }" , dump( {} , true , 1 ) ) ;
        }
        
        public function testString():void
        {
            assertEquals( "\"hello world\""    , dump( "hello world" ) ) ;
            assertEquals( "\"hello\\bworld\""  , dump( "hello\bworld" ) ) ;
            assertEquals( "\"hello\\tworld\""  , dump( "hello\tworld" ) ) ;
            assertEquals( "\"hello\\nworld\""  , dump( "hello\nworld" ) ) ;
            assertEquals( "\"hello\\vworld\""  , dump( "hello\vworld" ) ) ;
            assertEquals( "\"hello\\fworld\""  , dump( "hello\fworld" ) ) ;
            assertEquals( "\"hello\\rworld\""  , dump( "hello\rworld" ) ) ;
            assertEquals( "\"hello\\\"world\"" , dump( "hello\"world" ) ) ;
            assertEquals( "\"hello\\\'world\"" , dump( "hello'world" ) ) ;
            assertEquals( "\"hello\\\\world\"" , dump( "hello\\world" ) ) ;
        }
    }
}