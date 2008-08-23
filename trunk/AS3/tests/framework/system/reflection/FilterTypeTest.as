
package system.reflection
    {
    import buRRRn.ASTUce.framework.TestCase;
    
    public class FilterTypeTest extends TestCase
        {
        
        public function FilterTypeTest(name:String="")
            {
            super(name);
            }
        
        public function testNone():void
            {
            var f:FilterType = FilterType.none;
            
            assertTrue( f.usePrototypeInfo );
            assertTrue( f.useTraitInfo );
            }
        
        public function testPrototypeOnly():void
            {
            var f:FilterType = FilterType.prototypeOnly;
            
            assertTrue( f.usePrototypeInfo );
            assertFalse( f.useTraitInfo );
            }
        
        public function testTraitOnly():void
            {
            var f:FilterType = FilterType.traitOnly;
            
            assertFalse( f.usePrototypeInfo );
            assertTrue( f.useTraitInfo );
            }
        
        public function testShowDeclared():void
            {
            var f1:FilterType = FilterType.none;
            var f2:FilterType = FilterType.declaredOnly;
            
            assertTrue( f1.showDeclared );
            assertTrue( f2.showDeclared );
            }
        
        public function testShowInherited():void
            {
            var f1:FilterType = FilterType.none;
            var f2:FilterType = FilterType.declaredOnly;
            
            assertTrue( f1.showInherited );
            assertFalse( f2.showInherited );
            
            }
        
        public function testShowStatic():void
            {
            var f1:FilterType = FilterType.none;
            var f2:FilterType = FilterType.includeStatic;
            
            assertFalse( f1.showStatic );
            assertTrue( f2.showStatic );
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
            var f1:FilterType = new FilterType( int(FilterType.traitOnly) | int(FilterType.declaredOnly) | int(FilterType.includeStatic) );
            
            assertTrue( f0.usePrototypeInfo );
            assertTrue( f0.showInherited );
            assertFalse( f0.showStatic );
            
            assertFalse( f1.usePrototypeInfo );
            assertFalse( f1.showInherited );
            assertTrue( f1.showStatic );
            
            }
        
        }
    }

