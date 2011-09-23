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

package system.reflection 
{
    import library.ASTUce.framework.TestCase;
    
    public class AccessorTypeTest extends TestCase 
    {
        public function AccessorTypeTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var at:AccessorType = new AccessorType(10,"hello") ;
            assertNotNull( at                  , "01 - AccessorType constructor failed.") ;
            assertEquals( String(at) , "hello" , "02 - AccessorType constructor failed.") ;
            assertEquals( int(at)    , 10      , "03 - AccessorType constructor failed.") ;
        }
        
        public function testReadOnly():void
        {
            assertEquals( String(AccessorType.readOnly) , "readOnly" , "01 - AccessorType.readOnly failed.") ;
            assertEquals( int(AccessorType.readOnly)    , 1          , "02 - AccessorType.readOnly failed.") ;
        }
        
        public function testWriteOnly():void
        {
            assertEquals( String(AccessorType.writeOnly) , "writeOnly" , "01 - AccessorType.writeOnly failed.") ;
            assertEquals( int(AccessorType.writeOnly)    , 2           , "02 - AccessorType.writeOnly failed.") ;
        }
        
        public function testReadWrite():void
        {
            assertEquals( String(AccessorType.readWrite) , "readWrite" , "01 - AccessorType.readWrite failed.") ;
            assertEquals( int(AccessorType.readWrite)    , 3           , "02 - AccessorType.readWrite failed.") ;
        }
    }
}
