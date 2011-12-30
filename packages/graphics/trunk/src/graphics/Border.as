package graphics
{
    /**
     * Enables/Disables the border on the specified sides. The border is specified as an integer bitwise combination of the constants: LEFT, RIGHT, TOP, BOTTOM.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.Border ;
     * 
     * var border:Border = new Border( Border.NO_BORDER ) ;
     * 
     * trace( border ) ;
     * trace( border.hasBorders() ) ;
     * 
     * border.enableBorderSide( Border.TOP ) ;
     * trace( border ) ;
     * 
     * border.enableBorderSide( Border.BOTTOM ) ;
     * trace( border ) ;
     * 
     * border.enableBorderSide( Border.LEFT ) ;
     * trace( border ) ;
     * 
     * border.enableBorderSide( Border.RIGHT ) ;
     * trace( border ) ;
     * </pre>
     */
    public class Border
    {
        /**
         * Creates a new Border instance.
         * @param value The value of the border (default LEFT | TOP | RIGHT | BOTTOM = 30)
         */
        public function Border( value:int = 30 )
        {
            this.value = value ;
        }
        
        /**
         * This represents the bottom side of the border of the Rectangle (16).
         */
        public static const BOTTOM:int = 16 ;
        
        /**
         * This represents the left side of the border of the Rectangle (2).
         */
        public static const LEFT:int = 2 ;
        
        /**
         * This represents a rectangle without borders (0).
         */
        public static const NO_BORDER:int = 0 ;
        
        /**
         * This represents the right side of the border of the Rectangle (4).
         */
        public static const RIGHT:int = 4 ;
        
        /**
         * This represents the top side of the border of the Rectangle (8).
         */
        public static const TOP:int = 8 ;
        
        /**
         * The border value, an integer bitwise combination.
         */
        public var value:int ;
        
        /**
         * Enables the border on the specified side.
         * @param side  the side to enable. One of LEFT, RIGHT, TOP, BOTTOM.
         */
        public function enableBorderSide( side:int ):void
        {
            toggleBorder( side , true );
        }
        
        /**
         * Disables the border on the specified side.
         * @param side the side to disable. One of LEFT, RIGHT, TOP, BOTTOM.
         */
        public function disableBorderSide( side:int ):void
        {
            toggleBorder( side , true );
        }
        
        /**
         * Indicates whether the specified type of border is set. One of LEFT, RIGHT, TOP, BOTTOM.
         */
        public function hasBorder( type:int ):Boolean
        {
            return Boolean( type & value ) ;
        }
        
        /**
         * Indicates whether some type of border is set. One of LEFT, RIGHT, TOP, BOTTOM.
         */
        public function hasBorders():Boolean
        {
            return hasBorder(TOP) || hasBorder(BOTTOM) || hasBorder(LEFT) || hasBorder(RIGHT) ;
        }
        
        /**
         * Toggle a side in this border object.
         */
        public function toggleBorder( side:int, b:Boolean ):Boolean
        {
            var old:Number = value ;
            value = b ? ( value | side ) : ( value & ~side ) ;
            return old != value ;
        }
        
        /**
         * Returns the value of the object.
         * @return the value of the object.
         */
        public function valueOf():int
        {
            return value ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return "[Border " + value + "]" ;
        }
    }
}
