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
    import buRRRn.ASTUce.framework.TestCase;

    public class FilterTypeTest extends TestCase
    {

        public function FilterTypeTest(name:String = "")
        {
            super(name);
        }

        public function testNone():void
        {
            var f:FilterType = FilterType.none;
            
            assertTrue(f.usePrototypeInfo);
            assertTrue(f.useTraitInfo);
        }

        public function testPrototypeOnly():void
        {
            var f:FilterType = FilterType.prototypeOnly;
            
            assertTrue(f.usePrototypeInfo);
            assertFalse(f.useTraitInfo);
        }

        public function testTraitOnly():void
        {
            var f:FilterType = FilterType.traitOnly;
            
            assertFalse(f.usePrototypeInfo);
            assertTrue(f.useTraitInfo);
        }

        public function testShowDeclared():void
        {
            var f1:FilterType = FilterType.none;
            var f2:FilterType = FilterType.declaredOnly;
            
            assertTrue(f1.showDeclared);
            assertTrue(f2.showDeclared);
        }

        public function testShowInherited():void
        {
            var f1:FilterType = FilterType.none;
            var f2:FilterType = FilterType.declaredOnly;
            
            assertTrue(f1.showInherited);
            assertFalse(f2.showInherited);
        }

        public function testShowStatic():void
        {
            var f1:FilterType = FilterType.none;
            var f2:FilterType = FilterType.includeStatic;
            
            assertFalse(f1.showStatic);
            assertTrue(f2.showStatic);
        }

        public function testMixed():void
        {
            var f0:FilterType = FilterType.none;
            /* note:
            don't freak out, ok this is not dieal to test
            but whe nyou use Reflection.getClassInfo() you can do that
               
            var ci:ClassInfo = Reflection.getClassInfo( foobar, FilterType.traitOnly, FilterType.declaredOnly, FilterType.includeStatic )
            no need to cast to int or to use valueOf()
             */
            var f1:FilterType = new FilterType(int(FilterType.traitOnly) | int(FilterType.declaredOnly) | int(FilterType.includeStatic));
            
            assertTrue(f0.usePrototypeInfo);
            assertTrue(f0.showInherited);
            assertFalse(f0.showStatic);
            
            assertFalse(f1.usePrototypeInfo);
            assertFalse(f1.showInherited);
            assertTrue(f1.showStatic);
        }
    }
}

