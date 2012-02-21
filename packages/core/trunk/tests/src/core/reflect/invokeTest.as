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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package core.reflect 
{
    import library.ASTUce.framework.TestCase;

    import core.reflect.samples.InvokeClass;

    public class invokeTest extends TestCase 
    {
        public function invokeTest(name:String = "")
        {
            super(name);
        }
        
        public function testInvoke0():void
        {
            var instance:InvokeClass = invoke(InvokeClass) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(0 , instance.length ) ;
        }
        
        public function testInvoke1():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(1 , instance.length ) ;
        }
        
        public function testInvoke2():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(2 , instance.length ) ;
        }
        
        public function testInvoke3():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(3 , instance.length ) ;
        }
        
        public function testInvoke4():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(4 , instance.length ) ;
        }
        
        public function testInvoke5():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(5 , instance.length ) ;
        }
        
        public function testInvoke6():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(6 , instance.length ) ;
        }
        
        public function testInvoke7():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(7 , instance.length ) ;
        }
        
        public function testInvoke8():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(8 , instance.length ) ;
        }
        
        public function testInvoke9():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(9 , instance.length ) ;
        }
        
        public function testInvoke10():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(10 , instance.length ) ;
        }
        
        public function testInvoke11():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(11 , instance.length ) ;
        }
        
        public function testInvoke12():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(12 , instance.length ) ;
        }
        
        public function testInvoke13():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(13 , instance.length ) ;
        }
        
        public function testInvoke14():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(14 , instance.length ) ;
        }
        
        public function testInvoke15():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(15 , instance.length ) ;
        }
        
        public function testInvoke16():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(16 , instance.length ) ;
        }
        
        public function testInvoke17():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(17 , instance.length ) ;
        }
        
        public function testInvoke18():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(18 , instance.length ) ;
        }
        
        public function testInvoke19():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(19 , instance.length ) ;
        }
        
        public function testInvoke20():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(20 , instance.length ) ;
        }
        
        public function testInvoke21():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(21 , instance.length ) ;
        }
        
        public function testInvoke22():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(22 , instance.length ) ;
        }
        
        public function testInvoke23():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(23 , instance.length ) ;
        }
        
        public function testInvoke24():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(24 , instance.length ) ;
        }
        
        public function testInvoke25():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(25 , instance.length ) ;
        }
        
        public function testInvoke26():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(26 , instance.length ) ;
        }
        
        public function testInvoke27():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(27 , instance.length ) ;
        }
        
        public function testInvoke28():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(28 , instance.length ) ;
        }
        
        public function testInvoke29():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(29 , instance.length ) ;
        }
        
        public function testInvoke30():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(30 , instance.length ) ;
        }
        
        public function testInvoke31():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(31 , instance.length ) ;
        }
        
        public function testInvoke32():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]) as InvokeClass ;
            assertNotNull(instance, "instance not must be null.") ;
            assertEquals(32 , instance.length ) ;
        }
        
        public function testInvoke33():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]) as InvokeClass ;
            assertNull(instance, "instance must be null with 33 arguments.") ;
        }
        
        public function testInvoke34():void
        {
            var instance:InvokeClass = invoke(InvokeClass,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34]) as InvokeClass ;
            assertNull(instance, "instance must be null with 34 arguments.") ;
        }
    }
}
