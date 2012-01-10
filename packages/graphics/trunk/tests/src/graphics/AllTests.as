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

package graphics
{
    import graphics.colors.AllTests;
    import graphics.display.AllTests;
    import graphics.drawing.AllTests;
    import graphics.events.AllTests;
    import graphics.filters.AllTests;
    import graphics.geom.AllTests;
    import graphics.layouts.AllTests;
    import graphics.process.AllTests;
    import graphics.transitions.AllTests;
    import graphics.uikit.AllTests;
    
    import library.ASTUce.framework.*;
    
    /**
     * TestSuite that runs all the Maashaack graphics tests
     */
    public class AllTests
    {
        public static function suite():Test
        {
            var suite:TestSuite = new TestSuite("graphics package tests");
            
            //// test interfaces in this package
            
            suite.addTestSuite( DirectionableTest ) ;
            suite.addTestSuite( DrawableTest      ) ;
            suite.addTestSuite( IFillStyleTest    ) ;
            suite.addTestSuite( ILineStyleTest    ) ;
            
            //// test class in this package
            
            suite.addTestSuite( AlignTest             ) ;
            suite.addTestSuite( ArcTypeTest           ) ;
            suite.addTestSuite( CardinalDirectionTest ) ;
            suite.addTestSuite( CornerTest            ) ;
            suite.addTestSuite( DirectionTest         ) ;
            suite.addTestSuite( DirectionOrderTest    ) ;
            suite.addTestSuite( FillBitmapStyleTest   ) ;
            suite.addTestSuite( FillGradientStyleTest ) ;
            suite.addTestSuite( FillShaderStyleTest   ) ;
            suite.addTestSuite( FillStyleTest         ) ;
            suite.addTestSuite( GradientStyleTest     ) ;
            suite.addTestSuite( LineGradientStyleTest ) ;
            suite.addTestSuite( LineShaderStyleTest   ) ;
            suite.addTestSuite( LineStyleTest         ) ;
            suite.addTestSuite( OrientationTest       ) ;
            suite.addTestSuite( PositionTest          ) ;
            
            //// test sub packages
            
            suite.addTest( graphics.colors.AllTests.suite()  );
            suite.addTest( graphics.display.AllTests.suite() );
            suite.addTest( graphics.drawing.AllTests.suite() );
            suite.addTest( graphics.events.AllTests.suite()  );
            suite.addTest( graphics.filters.AllTests.suite() );
            suite.addTest( graphics.geom.AllTests.suite()    );
            suite.addTest( graphics.layouts.AllTests.suite() );
            suite.addTest( graphics.process.AllTests.suite() );
            suite.addTest( graphics.transitions.AllTests.suite() );
            suite.addTest( graphics.uikit.AllTests.suite() );
            
            return suite;
        }
    }
}
