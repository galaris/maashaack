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
{    import buRRRn.ASTUce.framework.TestCase;
    public class ConstantsTest extends TestCase 
    {

        public function ConstantsTest(name:String = "")
        {
            super(name);
        }
        
        ///////////////// flush
        
        public function testZ_NO_COMPRESSION():void
        {
            assertEquals(Z_NO_COMPRESSION, 0, "Z_NO_COMPRESSION value failed") ;
        }
        
        public function testZ_BEST_SPEED():void
        {
            assertEquals(Z_BEST_SPEED, 1, "Z_BEST_SPEED value failed") ;
        }
        
        public function testZ_BEST_COMPRESSION():void
        {
            assertEquals(Z_BEST_COMPRESSION, 9, "Z_BEST_COMPRESSION value failed") ;
        }
        
        public function testZ_DEFAULT_COMPRESSION():void
        {
            assertEquals(Z_DEFAULT_COMPRESSION, -1, "Z_DEFAULT_COMPRESSION value failed") ;
        }
        
        ///////////////// level
        
        ///////////////// strategy
        
        ///////////////// status
        
        public function testZ_BUF_ERROR():void
        {
        	assertEquals(Z_BUF_ERROR, -5, "Z_BUF_ERROR value failed") ;
        }
        
        public function testZ_DATA_ERROR():void
        {
            assertEquals(Z_DATA_ERROR, -3, "Z_DATA_ERROR value failed") ;
        }
        
        public function testZ_ERRNO():void
        {
            assertEquals(Z_ERRNO, -1, "Z_ERRNO value failed") ;
        }
        
        public function testZ_MEM_ERROR():void
        {
            assertEquals(Z_MEM_ERROR, -4, "Z_MEM_ERROR value failed") ;
        }
        
        public function testZ_NEED_DICT():void
        {
            assertEquals(Z_NEED_DICT, 2, "Z_NEED_DICT value failed") ;
        }
        
        public function testZ_OK():void
        {
            assertEquals(Z_OK, 0, "Z_OK value failed") ;
        }
        
        public function testZ_STREAM_END():void
        {
            assertEquals(Z_STREAM_END, 1, "Z_STREAM_END value failed") ;
        }
        
        public function testZ_STREAM_ERROR():void
        {
            assertEquals(Z_STREAM_ERROR, -2, "Z_STREAM_ERROR value failed") ;
        }
        
        public function testZ_VERSION_ERROR():void
        {
            assertEquals(Z_VERSION_ERROR, -6, "Z_VERSION_ERROR value failed") ;
        }    }}