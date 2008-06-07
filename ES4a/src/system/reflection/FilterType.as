
package system.reflection
    {
    import system.Enum;
    
    public class FilterType extends Enum
        {
        
        public function FilterType( value:int=0, name:String="")
            {
            super( value, name);
            }
        
        /* info:
           0x000000
                |||_  0: both, 1: only prototype, 2: only trait
                ||__  0: both declared and inherited, 1: declared only
                |___  0: ignore static, 1: include static
        */
        
        public function get usePrototypeInfo():Boolean
            {
            var value:uint = valueOf() & 0x00000f;
            
            if( value < 2 )
                {
                return true;
                }
            
            return false;
            }
        
        public function get useTraitInfo():Boolean
            {
            var value:uint = valueOf() & 0x00000f;
            
            if( value == 1 )
                {
                return false;
                }
            
            return true;
            }
        
        public function get showDeclared():Boolean
            {
            var value:uint = (valueOf() & 0x0000f0) >>> 4;
            
            if( value > 1 )
                {
                return false; //should never happen
                }
            
            return true;
            }
        
        public function get showInherited():Boolean
            {
            var value:uint = (valueOf() & 0x0000f0) >>> 4;
            
            if( value == 0 )
                {
                return true;
                }
            
            return false;
            }
        
        public function get showStatic():Boolean
            {
            var value:uint = (valueOf() & 0x000f00) >>> 8;
            
            if( value == 0 )
                {
                return false;
                }
            
            return true;
            }
        
        /* default
           - use both prototype and trait
           - both declared and inherited
           - ignore static
        */
        public static const none:FilterType           = new FilterType( 0x000, "none" );
        
        /* trait members will not be searched. */
        public static const prototypeOnly:FilterType  = new FilterType( 0x001, "prototypeOnly" );
        
        /* prototype members will not be searched. */
        public static const traitOnly:FilterType      = new FilterType( 0x002, "traitOnly" );
        
        /* inherited members will not be searched.
           
           note:
           for Trait
           this will apply only to methods and accessors
           not to variables and constants
           reason:
           variables and constants does not have a declaredBy attribute (from describeType),
           but that's normal because "inherited properties are copied down from superclasses
           into the traits object of subclasses" (cf: OOP in ActionScript/Advanced Topics/The Trait Object). 
           
           for prototype
           this will apply both to properties and methods
        */
        public static const declaredOnly:FilterType   = new FilterType( 0x010, "declaredOnly" );
        
        /* static members will be searched too. */
        public static const includeStatic:FilterType  = new FilterType( 0x100, "includeStatic" );
        }
    }

