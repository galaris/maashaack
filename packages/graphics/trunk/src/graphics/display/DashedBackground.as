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

package graphics.display 
{
    import graphics.Border;
    import graphics.drawing.DashRectanglePen;
    import graphics.geom.EdgeMetrics;
    
    import system.hack;
    
    /**
     * This display is used to create a background defines with an internal DashRectanglePen.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.Border ;
     * import graphics.FillStyle ;
     * import graphics.LineStyle ;
     * 
     * import graphics.display.DashedBackground ;
     * import graphics.geom.EdgeMetrics ;
     * 
     * import flash.display.StageAlign ;
     * import flash.display.StageScaleMode ;
     * 
     * stage.align     = StageAlign.TOP_LEFT ;
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var area:DashedBackground = new DashedBackground() ;
     * 
     * area.lock() ; // lock the update method
     * 
     * area.length  = 8 ;
     * area.spacing = 6 ;
     * area.overage = new EdgeMetrics( 8 , 8 , 8 , 8 ) ;
     * area.border  = new Border( Border.LEFT | Border.TOP | Border.RIGHT ) ;
     * 
     * area.fill = new FillStyle( 0xD97BD0  ) ;
     * area.line = new LineStyle( 2, 0xFFFFFF ) ;
     * 
     * area.x = 25 ;
     * area.y = 25 ;
     * area.w = 400 ;
     * area.h = 300 ;
     * 
     * area.unlock() ; // unlock the update method
     * 
     * area.update() ; // force update
     * 
     * addChild( area ) ;
     * </pre>
     */
    public class DashedBackground extends Background
    {
        use namespace hack ;
        
        /**
         * Creates a new DashedBackground instance.
         * @param init An object that contains properties with which to populate the newly instance. If init is not an object, it is ignored.
         */
        public function DashedBackground( init:Object = null )
        {
            super( init , new DashRectanglePen() ) ;
        }
        
        
        /**
         * Enables/Disables the border on the specified sides. The border is specified as an integer bitwise combination of the constants: LEFT, RIGHT, TOP, BOTTOM.
         */
        public function get border():Border
        {
            return ( _pen is DashRectanglePen ) ? ( _pen as DashRectanglePen ).border : null ;
        }
        
        /**
         * @private
         */
        public function set border( border:Border ):void
        {
            if( _pen is DashRectanglePen )
            {
                (_pen as DashRectanglePen).border = border ;
                update() ;
            }
        }
        
        /**
         * Determinates the length of a dash in the line. 
         */
        public function get length():Number 
        {
            return ( _pen is DashRectanglePen ) ? ( _pen as DashRectanglePen ).length : NaN ;
        }
        
        /**
         * @private
         */
        public function set length( value:Number):void 
        {
            if( _pen is DashRectanglePen )
            {
                (_pen as DashRectanglePen).length = value ;
                update() ;
            }
        }
        
        /**
         * The overage of the border.
         */
        public function get overage():EdgeMetrics
        {
            return ( _pen is DashRectanglePen ) ? ( _pen as DashRectanglePen ).overage : null ;
        }
        
        /**
         * @private
         */
        public function set overage( em:EdgeMetrics ):void
        {
           if( _pen is DashRectanglePen )
           {
                (_pen as DashRectanglePen).overage = em ;
                update() ;
           }
        }
        
        /**
         * Determinates the spacing value between two dashs in this line. 
         */
        public function get spacing():Number 
        {
            return ( _pen is DashRectanglePen ) ? ( _pen as DashRectanglePen ).space : NaN ;
        }
        
        /**
         * @private
         */
        public function set spacing( value:Number ):void 
        {
            if( _pen is DashRectanglePen )
            {
                (_pen as DashRectanglePen).spacing = value ;
                update() ;
            }
        }
    }
}