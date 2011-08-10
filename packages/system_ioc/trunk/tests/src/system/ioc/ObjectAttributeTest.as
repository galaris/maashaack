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

package system.ioc
{
    import buRRRn.ASTUce.framework.TestCase;

    public class ObjectAttributeTest extends TestCase
    {
        public function ObjectAttributeTest(name:String = "")
        {
            super(name);
        }
        
        public function testARGUMENTS():void
        {
            assertEquals( "arguments" , ObjectAttribute.ARGUMENTS ) ;
        }
        
        public function testCONFIG():void
        {
            assertEquals( "config" , ObjectAttribute.CONFIG ) ;
        }
        
        public function testCONFIGURATION():void
        {
            assertEquals( "configuration" , ObjectAttribute.CONFIGURATION ) ;
        }
        
        public function testEVALUATORS():void
        {
            assertEquals( "evaluators" , ObjectAttribute.EVALUATORS ) ;
        }
        
        public function testFACTORY():void
        {
            assertEquals( "factory" , ObjectAttribute.FACTORY ) ;
        }
        
        public function testIDENTIFY():void
        {
            assertEquals( "identify" , ObjectAttribute.IDENTIFY ) ;
        }
        
        public function testI18N():void
        {
            assertEquals( "i18n" , ObjectAttribute.I18N ) ;
        }
        
        public function testIMPORTS():void
        {
            assertEquals( "imports" , ObjectAttribute.IMPORTS ) ;
        }
        
        public function testLAZY_INIT():void
        {
            assertEquals( "lazyInit" , ObjectAttribute.LAZY_INIT ) ;
        }
        
        public function testLOCALE():void
        {
            assertEquals( "locale" , ObjectAttribute.LOCALE ) ;
        }
        
        public function testLOCK():void
        {
            assertEquals( "lock" , ObjectAttribute.LOCK ) ;
        }
        
        public function testNAME():void
        {
            assertEquals( "name" , ObjectAttribute.NAME ) ;
        }
        
        public function testOBJECT_DEPENDS_ON():void
        {
            assertEquals( "dependsOn" , ObjectAttribute.OBJECT_DEPENDS_ON ) ;
        }
        
        public function testOBJECT_DESTROY_METHOD_NAME():void
        {
            assertEquals( "destroy" , ObjectAttribute.OBJECT_DESTROY_METHOD_NAME ) ;
        }
        
        public function testOBJECT_FACTORY_METHOD():void
        {
            assertEquals( "factoryMethod" , ObjectAttribute.OBJECT_FACTORY_METHOD ) ;
        }
        
        public function testOBJECT_FACTORY_PROPERTY():void
        {
            assertEquals( "factoryProperty" , ObjectAttribute.OBJECT_FACTORY_PROPERTY ) ;
        }
        
        public function testOBJECT_FACTORY_REFERENCE():void
        {
            assertEquals( "factoryReference" , ObjectAttribute.OBJECT_FACTORY_REFERENCE ) ;
        }
        
        public function testOBJECT_FACTORY_VALUE():void
        {
            assertEquals( "factoryValue" , ObjectAttribute.OBJECT_FACTORY_VALUE ) ;
        }
        
        public function testOBJECT_GENERATES():void
        {
            assertEquals( "generates" , ObjectAttribute.OBJECT_GENERATES ) ;
        }
        
        public function testOBJECT_ID():void
        {
            assertEquals( "id" , ObjectAttribute.OBJECT_ID ) ;
        }
        
        public function testOBJECT_INIT_METHOD_NAME():void
        {
            assertEquals( "init" , ObjectAttribute.OBJECT_INIT_METHOD_NAME ) ;
        }
        
        public function testOBJECT_LISTENERS():void
        {
            assertEquals( "listeners" , ObjectAttribute.OBJECT_LISTENERS ) ;
        }
        
        public function testOBJECT_PROPERTIES():void
        {
            assertEquals( "properties" , ObjectAttribute.OBJECT_PROPERTIES ) ;
        }
        
        public function testOBJECT_RECEIVERS():void
        {
            assertEquals( "receivers" , ObjectAttribute.OBJECT_RECEIVERS ) ;
        }
        
        public function testOBJECT_SCOPE():void
        {
            assertEquals( "scope" , ObjectAttribute.OBJECT_SCOPE ) ;
        }
        
        public function testOBJECT_SINGLETON():void
        {
            assertEquals( "singleton" , ObjectAttribute.OBJECT_SINGLETON ) ;
        }
        
        public function testOBJECT_STATIC_FACTORY_METHOD():void
        {
            assertEquals( "staticFactoryMethod" , ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD ) ;
        }
        
        public function testOBJECT_STATIC_FACTORY_PROPERTY():void
        {
            assertEquals( "staticFactoryProperty" , ObjectAttribute.OBJECT_STATIC_FACTORY_PROPERTY ) ;
        }
        
        public function testOBJECTS():void
        {
            assertEquals( "objects" , ObjectAttribute.OBJECTS ) ;
        }
        
        public function testRESOURCE():void
        {
            assertEquals( "resource" , ObjectAttribute.RESOURCE ) ;
        }
        
        public function testTYPE():void
        {
            assertEquals( "type" , ObjectAttribute.TYPE ) ;
        }
        
        public function testTYPE_ALIAS():void
        {
            assertEquals( "alias" , ObjectAttribute.TYPE_ALIAS ) ;
        }
        
        public function testTYPE_ALIASES():void
        {
            assertEquals( "typeAliases" , ObjectAttribute.TYPE_ALIASES ) ;
        }
        
        public function testTYPE_EXPRESSION():void
        {
            assertEquals( "typeExpression" , ObjectAttribute.TYPE_EXPRESSION ) ;
        }
        
        public function testREFERENCE():void
        {
            assertEquals( "ref" , ObjectAttribute.REFERENCE ) ;
        }
        
        public function testVALUE():void
        {
            assertEquals( "value" , ObjectAttribute.VALUE ) ;
        }
    }
}
