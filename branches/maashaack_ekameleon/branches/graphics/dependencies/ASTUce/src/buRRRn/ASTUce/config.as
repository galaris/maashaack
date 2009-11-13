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
  - Marc Alcaraz <vegas@ekameleon.net>.
*/
package buRRRn.ASTUce
    {
    
    /**
     * Configure the ASTUce framework.
     */
    public var config:ASTUceConfigurator = new ASTUceConfigurator( {
                                                                   verbose: false,
                                                                   showConstructorList: false,
                                                                   showAllAsSimpleTrace: false,
                                                                   showSimpleTraceDepth: 1,
                                                                   showPrinterShortTests: true,
                                                                   showPrinterDetails: true,
                                                                   showPrintHeader: true,
                                                                   showPrintErrors: true,
                                                                   showPrintFailures: true,
                                                                   showPrintFooter: true,
                                                                   showEmptyTests: true,
                                                                   showObjectSource: true,
                                                                   invertExpectedActual: false,
                                                                   testInheritedTests: true,
                                                                   maxColumn: 38,
                                                                   defectHeaderAsError: false,
                                                                   allowErrorTrace: true,
                                                                   allowStackTrace: true,
                                                                   filterErrorStack: true,
                                                                   cleanupErrorStack: true,
                                                                   cleanupPattern: /\[.*\]/,
                                                                   cleanupReplacement: "",
                                                                   filteredPatterns: [
                                                                   "buRRRn.ASTUce.framework::TestResult",
                                                                   "buRRRn.ASTUce.framework::TestCase",
                                                                   "buRRRn.ASTUce.framework::TestSuite",
                                                                   "buRRRn.ASTUce.UI",
                                                                   "at MethodInfo",
                                                                   "at ()",
                                                                   "at Function/http://adobe.com/AS3/2006/builtin::call()",
                                                                   "at Function/http://adobe.com/AS3/2006/builtin::apply()"
                                                                                     ]
                                                                   } );
        
    
    }

