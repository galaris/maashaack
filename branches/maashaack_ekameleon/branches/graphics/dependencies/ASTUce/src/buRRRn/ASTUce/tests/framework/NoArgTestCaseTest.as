
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.ASTUce.tests.framework
    {
    import buRRRn.ASTUce.framework.TestCase;
    
    public class NoArgTestCaseTest extends TestCase
        {
        
        /*
        public function NoArgTestCaseTest( name:String = "" )
            {
            super( name );
            }
        */
        public function testNothing():void
            {
            /* this will compiles, but will not be tested.
               
               Here the dilemma,
               sure you can avoid defining the test class ctor,
               but this means that by default in ECMAScript
               the class will have this ctor
               (code)
               public function NoArgTestCaseTest()
                   {
                   
                   }
               (end)
               
               And so will not be able to take any argument to construct
               test cases, at worst you will have a warning because no
               tests have been found, at best you will obtain an
               empty test suite, and testNothing will surely not be tested.
               
               So in <TestSuite> if such case is found
               we add a warning and not the test itself.
               
               Here the XML describeType from a a valid test class:
               (code)
                <type name="buRRRn.ASTUce.tests.framework::AssertTest"
                      base="Class" isDynamic="true" isFinal="true" isStatic="true">
                  <extendsClass type="Class"/>
                  <extendsClass type="Object"/>
                  <accessor name="prototype" access="readonly" type="*" declaredBy="Class"/>
                  <factory type="buRRRn.ASTUce.tests.framework::AssertTest">
                    <extendsClass type="buRRRn.ASTUce.framework::TestCase"/>
                    <extendsClass type="buRRRn.ASTUce.framework::Assert"/>
                    <extendsClass type="Object"/>
                    <implementsInterface type="buRRRn.ASTUce.framework::ITest"/>
                    <constructor>
                      <parameter index="1" type="*" optional="true"/>
                    </constructor>
                    ...
               (end)
               you got a factory tag AND a constructor tag inside it.
               
               Here the XML describeType from a class without a constructor:
               (code)
                <type name="buRRRn.ASTUce.tests.framework::NoArgTestCaseTest" base="Class" isDynamic="true" isFinal="true" isStatic="true">
                  <extendsClass type="Class"/>
                  <extendsClass type="Object"/>
                  <accessor name="prototype" access="readonly" type="*" declaredBy="Class"/>
                  <factory type="buRRRn.ASTUce.tests.framework::NoArgTestCaseTest">
                    <extendsClass type="buRRRn.ASTUce.framework::TestCase"/>
                    <extendsClass type="buRRRn.ASTUce.framework::Assert"/>
                    <extendsClass type="Object"/>
                    <implementsInterface type="buRRRn.ASTUce.framework::ITest"/>
                    <method name="testNothing" declaredBy="buRRRn.ASTUce.tests.framework::NoArgTestCaseTest" returnType="void"/>
                    <method name="runBare" declaredBy="buRRRn.ASTUce.framework::TestCase" returnType="void"/>
                    <accessor name="name" access="readwrite" type="String" declaredBy="buRRRn.ASTUce.framework::TestCase"/>
                    <method name="toString" declaredBy="buRRRn.ASTUce.framework::TestCase" returnType="String"/>
                    <accessor name="countTestCases" access="readonly" type="int" declaredBy="buRRRn.ASTUce.framework::TestCase"/>
                    <method name="run" declaredBy="buRRRn.ASTUce.framework::TestCase" returnType="void">
                      <parameter index="1" type="buRRRn.ASTUce.framework::TestResult" optional="false"/>
                    </method>
                  </factory>
                </type>
               (end)
               you got a factory tag but no constructor tag inside it.
            */
            }
        
        }
    
    }

