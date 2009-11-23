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
    import system.Enum;
    public class ZFlushTest extends TestCase 
	{

        public function ZFlushTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var enum:ZFlush = new ZFlush() ;
            assertNotNull(enum, "ZFlush constructor failed") ;
        }
        
        public function testInherit():void
        {
            var enum:ZFlush = new ZFlush() ;
            assertNotNull(enum is Enum, "ZFlush extends Enum failed") ;
        }
                
        public function testZ_NO_FLUSH():void
        {
            assertEquals(ZFlush.Z_NO_FLUSH.valueOf(), 0, "Z_NO_FLUSH valueOf() failed") ;
            assertEquals(ZFlush.Z_NO_FLUSH.toString(), "no", "Z_NO_FLUSH toString() failed") ;
        }
        
        public function testZ_PARTIAL_FLUSH():void
        {
            assertEquals(ZFlush.Z_PARTIAL_FLUSH.valueOf(), 1, "Z_PARTIAL_FLUSH valueOf() failed") ;
            assertEquals(ZFlush.Z_PARTIAL_FLUSH.toString(), "partial", "Z_PARTIAL_FLUSH toString() failed") ;
        }
        
        public function testZ_SYNC_FLUSH():void
        {
            assertEquals(ZFlush.Z_SYNC_FLUSH.valueOf(), 2, "Z_SYNC_FLUSH valueOf() failed") ;
            assertEquals(ZFlush.Z_SYNC_FLUSH.toString(), "sync", "Z_SYNC_FLUSH toString() failed") ;
        }
        
        public function testZ_FULL_FLUSH():void
        {
            assertEquals(ZFlush.Z_FULL_FLUSH.valueOf(), 3, "Z_FULL_FLUSH valueOf() failed") ;
            assertEquals(ZFlush.Z_FULL_FLUSH.toString(), "full", "Z_FULL_FLUSH toString() failed") ;
        }
        
        public function testZ_FINISH():void
        {
            assertEquals(ZFlush.Z_FINISH.valueOf(), 4, "Z_FINISH valueOf() failed") ;
            assertEquals(ZFlush.Z_FINISH.toString(), "finish", "Z_FINISH toString() failed") ;
        }
        
    }
}
