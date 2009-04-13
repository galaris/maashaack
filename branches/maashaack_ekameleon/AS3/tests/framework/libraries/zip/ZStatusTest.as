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
    public class ZStatusTest extends TestCase 
	{

        public function ZStatusTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var enum:ZStatus = new ZStatus() ;
            assertNotNull(enum, "ZStatus constructor failed") ;
        }
        
        public function testInherit():void
        {
            var enum:ZStatus = new ZStatus() ;
            assertNotNull(enum is Enum, "ZStatus extends Enum failed") ;
        }
                
        public function testZ_NEED_DICT():void
        {
            assertEquals(ZStatus.Z_NEED_DICT.valueOf(), 2, "Z_NEED_DICT valueOf() failed") ;
            assertEquals(ZStatus.Z_NEED_DICT.toString(), "need dictionary", "Z_NEED_DICT toString() failed") ;
        }
        
        public function testZ_STREAM_END():void
        {
            assertEquals(ZStatus.Z_STREAM_END.valueOf(), 1, "Z_STREAM_END valueOf() failed") ;
            assertEquals(ZStatus.Z_STREAM_END.toString(), "stream end", "Z_STREAM_END toString() failed") ;
        }
        
        public function testZ_OK():void
        {
            assertEquals(ZStatus.Z_OK.valueOf(), 0, "Z_OK valueOf() failed") ;
            assertEquals(ZStatus.Z_OK.toString(), "", "Z_OK toString() failed") ;
        }
        
        public function testZ_ERRNO():void
        {
            assertEquals(ZStatus.Z_ERRNO.valueOf(), -1, "Z_ERRNO valueOf() failed") ;
            assertEquals(ZStatus.Z_ERRNO.toString(), "file error", "Z_ERRNO toString() failed") ;
        }
        
        public function testZ_STREAM_ERROR():void
        {
            assertEquals(ZStatus.Z_STREAM_ERROR.valueOf(), -2, "Z_STREAM_ERROR valueOf() failed") ;
            assertEquals(ZStatus.Z_STREAM_ERROR.toString(), "stream error", "Z_STREAM_ERROR toString() failed") ;
        }
        
        public function testZ_DATA_ERROR():void
        {
            assertEquals(ZStatus.Z_DATA_ERROR.valueOf(), -3, "Z_DATA_ERROR valueOf() failed") ;
            assertEquals(ZStatus.Z_DATA_ERROR.toString(), "data error", "Z_DATA_ERROR toString() failed") ;
        }
        
        public function testZ_MEM_ERROR():void
        {
            assertEquals(ZStatus.Z_MEM_ERROR.valueOf(), -4, "Z_MEM_ERROR valueOf() failed") ;
            assertEquals(ZStatus.Z_MEM_ERROR.toString(), "insufficient memory", "Z_MEM_ERROR toString() failed") ;
        }
        
        public function testZ_BUF_ERROR():void
        {
            assertEquals(ZStatus.Z_BUF_ERROR.valueOf(), -5, "Z_BUF_ERROR valueOf() failed") ;
            assertEquals(ZStatus.Z_BUF_ERROR.toString(), "buffer error", "Z_BUF_ERROR toString() failed") ;
        }
        
        public function testZ_VERSION_ERROR():void
        {
            assertEquals(ZStatus.Z_VERSION_ERROR.valueOf(), -6, "Z_VERSION_ERROR valueOf() failed") ;
            assertEquals(ZStatus.Z_VERSION_ERROR.toString(), "incompatible version", "Z_VERSION_ERROR toString() failed") ;
        }
    }
}
