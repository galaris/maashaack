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

package libraries.zip  
{
    import buRRRn.ASTUce.framework.TestCase;	

    public class Adler32Test extends TestCase 
	{

        public function Adler32Test(name:String = "")
        {
            super(name);
        }
        
        public function testBASE():void
        {
            assertEquals(Adler32.BASE, 65521, "Adler32.BASE value failed.") ;
        }
        
        public function testNMAX():void
        {
            assertEquals(Adler32.NMAX, 5552, "Adler32.NMAX value failed.") ;
        }
        
        public function testConstructorBasic():void
        {
            var a:Adler32 = new Adler32() ;
            assertNotNull(a, "Adler32 constructor failed") ;
        }
        
        public function testReset():void
        {
            var a:Adler32 = new Adler32() ;
            a.reset();
            assertEquals( a.valueOf() , 1 , "Adler32 reset failed.") ;
        }
        
        public function testToString():void
        {
            var a:Adler32 = new Adler32() ;
            assertEquals(a.toString() , "1" , "Adler32 toString() failed.") ;
        }
        
        public function testValueOf():void
        {
            var a:Adler32 = new Adler32() ;
            assertEquals(a.valueOf() , 1 , "Adler32 default value failed.") ;
        }
        
//        public function testUpdate():void
//        {
//            
//        }
    }
}
