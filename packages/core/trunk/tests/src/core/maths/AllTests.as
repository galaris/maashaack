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

package core.maths
{
    import library.ASTUce.framework.Test;
    import library.ASTUce.framework.TestSuite;
    
    public class AllTests
    {
        public static function suite():Test
        {
            var suite:TestSuite = new TestSuite("core.maths package tests");
            
            // const
            
            suite.addTestSuite( DEG2RADTest ) ;
            suite.addTestSuite( EPSILONTest ) ;
            suite.addTestSuite( LAMBDATest  ) ;
            suite.addTestSuite( PHITest     ) ;
            suite.addTestSuite( RAD2DEGTest ) ;
            
            // functions
            
            suite.addTestSuite( acosDTest            ) ;
            suite.addTestSuite( acosHmTest           ) ;
            suite.addTestSuite( acosHpTest           ) ;
            suite.addTestSuite( angleOfLineTest      ) ;
            suite.addTestSuite( asinDTest            ) ;
            suite.addTestSuite( asinHTest            ) ;
            suite.addTestSuite( atanDTest            ) ;
            suite.addTestSuite( atan2DTest           ) ;
            suite.addTestSuite( atanHTest            ) ;
            suite.addTestSuite( berpTest             ) ;
            suite.addTestSuite( bounceTest           ) ;
            suite.addTestSuite( ceilTest             ) ;            suite.addTestSuite( clampTest            ) ;
            suite.addTestSuite( clerpTest            ) ;
            suite.addTestSuite( cosDTest             ) ;
            suite.addTestSuite( coserpTest           ) ;
            suite.addTestSuite( cosHTest             ) ;
            suite.addTestSuite( degreesToRadiansTest ) ;
            suite.addTestSuite( distanceTest         ) ;
            suite.addTestSuite( distanceByObjectTest ) ;
            suite.addTestSuite( fixAngleTest         ) ;
            suite.addTestSuite( floorTest            ) ;
            suite.addTestSuite( gcdTest              ) ;
            suite.addTestSuite( hermiteTest          ) ;
            suite.addTestSuite( hypothenuseTest      ) ;
            suite.addTestSuite( interpolateTest      ) ;
            suite.addTestSuite( isEvenTest           ) ;
            suite.addTestSuite( isOddTest            ) ;
            suite.addTestSuite( lerpTest             ) ;
            suite.addTestSuite( log10Test            ) ;
            suite.addTestSuite( logNTest             ) ;
            suite.addTestSuite( mapTest              ) ;
            suite.addTestSuite( normalizeTest        ) ;
            suite.addTestSuite( percentageTest       ) ;
            suite.addTestSuite( radiansToDegreesTest ) ;
            suite.addTestSuite( replaceNaNTest       ) ;
            suite.addTestSuite( roundTest            ) ;
            suite.addTestSuite( sinDTest             ) ;
            suite.addTestSuite( sinerpTest           ) ;
            suite.addTestSuite( sinHTest             ) ;
            suite.addTestSuite( signTest             ) ;
            suite.addTestSuite( tanDTest             ) ;
            suite.addTestSuite( tanHTest             ) ;
            
            return suite;
        }
    }
}
