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

package graphics.display 
{
    import graphics.drawing.RoundedComplexRectanglePen;

    import system.hack;
    
    /**
     * This display is used to create a background defines with an internal RoundedComplexRectanglePen.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.FillStyle ;
     * import graphics.LineStyle ;
     *
     * import graphics.display.RoundedBackground ;
     * 
     * var area:RoundedBackground = new RoundedBackground() ;
     * 
     * area.lock() ;
     * 
     * area.cornerRadius = 12 ;
     * 
     * area.fill = new FillStyle( 0xD97BD0  ) ;
     * area.line = new LineStyle( 2, 0xFFFFFF ) ;
     * 
     * area.x = 25 ;
     * area.y = 25 ;
     * area.w = 400 ;
     * area.h = 300 ;
     * 
     * area.unlock() ;
     * 
     * area.update() ;
     * 
     * addChild( area ) ;
     * </pre>
     */
    public class RoundedBackground extends Background
    {
        use namespace hack ;
        
        /**
         * Creates a new RoundedBackground instance.
         * @param init An object that contains properties with which to populate the newly instance. If init is not an object, it is ignored.
         */
        public function RoundedBackground( init:Object = null )
        {
            super( init , new RoundedComplexRectanglePen() ) ;
        }
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public function get bottomLeftRadius():Number
        {
            return ( _pen is RoundedComplexRectanglePen ) ? ( _pen as RoundedComplexRectanglePen ).bottomLeftRadius : NaN ;
        }
        
        /**
         * @private
         */
        public function set bottomLeftRadius( value:Number ):void
        {
            if( _pen is RoundedComplexRectanglePen )
            {
                (_pen as RoundedComplexRectanglePen).bottomLeftRadius = value ;
                update() ;
            }
        }
        
        /**
         * The radius of the bottom-right corner, in pixels.
         */
        public function get bottomRightRadius():Number
        {
            return ( _pen is RoundedComplexRectanglePen ) ? ( _pen as RoundedComplexRectanglePen ).bottomRightRadius : NaN ;
        }
        
        /**
         * @private
         */
        public function set bottomRightRadius( value:Number ):void
        {
            if( _pen is RoundedComplexRectanglePen )
            {
                (_pen as RoundedComplexRectanglePen).bottomRightRadius = value ;
                update() ;
            }
        }
        
        /**
         * The corner radius of all corners of the background, in pixels.
         */
        public function get cornerRadius():Number
        {
            return ( _pen is RoundedComplexRectanglePen ) ? ( _pen as RoundedComplexRectanglePen ).cornerRadius : NaN ;
        }
        
        /**
         * @private 
         */
        public function set cornerRadius( value:Number ):void
        {
            if( _pen is RoundedComplexRectanglePen )
            {
                (_pen as RoundedComplexRectanglePen).cornerRadius = value ;
                update() ;
            }
        }
        
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public function get topLeftRadius():Number
        {
            return ( _pen is RoundedComplexRectanglePen ) ? ( _pen as RoundedComplexRectanglePen ).topLeftRadius : NaN ;
        }
        
        /**
         * @private
         */
        public function set topLeftRadius( value:Number ):void
        {
            if( _pen is RoundedComplexRectanglePen )
            {
                (_pen as RoundedComplexRectanglePen).topLeftRadius = value ;
                update() ;
            }
        }
        
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public function get topRightRadius():Number
        {
            return ( _pen is RoundedComplexRectanglePen ) ? ( _pen as RoundedComplexRectanglePen ).topRightRadius : NaN ;
        }
        
        /**
         * @private
         */
        public function set topRightRadius( value:Number ):void
        {
            if( _pen is RoundedComplexRectanglePen )
            {
                (_pen as RoundedComplexRectanglePen).topRightRadius = value ;
                update() ;
            }
        }
    }
}