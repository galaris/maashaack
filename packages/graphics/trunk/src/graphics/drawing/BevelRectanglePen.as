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

package graphics.drawing 
{
    import system.hack;
    
    /**
     * Draws a bevel rectangle.
     */
    public dynamic class BevelRectanglePen extends CornerRectanglePen 
    {
        use namespace hack ;
        
        /**
         * Creates a new BevelRectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param hBevel (optional) The hBevel value who defined the horizontal bevel level of all corners in this BevelRectangle pen.
         * @param vBevel (optional) The vBevel value who defined the vertical bevel level of all corners in this BevelRectangle pen.
         * @param align (optional) The align value of the pen.
         */
        public function BevelRectanglePen( graphic:* = null , x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, hBevel:Number=0, vBevel:Number = 0 , align:uint = 10)
        {
            super( graphic );
            setPen( x, y, width, height, hBevel, vBevel , align ) ;
        }
        
        /**
          * Determinates the hBevel value who defined the horizontal bevel level of all corners in this BevelRectangle pen.
         */
        public function get hBevel():Number 
        {
            return (_hBevel <= width ) ? _hBevel : 0 ;
        }
        
        /**
         * @private
         */
        public function set hBevel( n:Number ):void 
        {
            _hBevel = ( n>0 ) ? n : 0 ; 
        }
        
        /**
         * Determinates the vBevel value who defined the vertical bevel level of all corners in this BevelRectangle pen.
         */
        public function get vBevel():Number 
        {
            return isNaN(_vBevel) ? NaN : ( (_vBevel <= height ) ? _vBevel : 0 ) ;
        }
        
        /**
         * @private
         */
        public function set vBevel( n:Number ):void 
        {
            _vBevel = (isNaN(n) || n > 0 ) ? n : 0 ; 
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            var hb:Number = hBevel ;
            var vb:Number = isNaN(vBevel) ? hBevel : vBevel ;
            if (hb > 0 && vb > 0) 
            {
                var nX:Number   = _x ;
                var nY:Number   = _y ;
                var nW:Number   = nX + width ;
                var nH:Number   = nY + height ;
                _graphics.moveTo ( nX + hb , nY) ;
                if (_corner.tr) 
                {
                    _graphics.lineTo( nW - hb , nY) ;
                    _graphics.lineTo( nW , nY + vb ) ;
                }
                else 
                {
                    _graphics.lineTo( nW , nY ) ;
                }
                if (_corner.br) 
                {
                    _graphics.lineTo( nW , nH - vb ) ;
                    _graphics.lineTo( nW - hb , nH) ;
                }
                else 
                {
                    _graphics.lineTo( nW , nH ) ;
                }
                if (_corner.bl) 
                {
                    _graphics.lineTo( nX  + hb, nH ) ;
                    _graphics.lineTo( nX  ,  nH - vb ) ;
                }
                else 
                {
                    _graphics.lineTo( nX , nH ) ;
                }
                if (_corner.tl) 
                {
                    _graphics.lineTo( nX , nY + vb) ;
                    _graphics.lineTo( nX + hb, nY);
                }
                else 
                {
                    _graphics.lineTo( nX , nY ) ;
                }
            } 
            else 
            {
                super.drawShape() ;
            }
        }
        
        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param hBevel (optional) The hBevel value who defined the horizontal bevel level of all corners in this BevelRectangle pen.
         * @param vBevel (optional) The vBevel value who defined the vertical bevel level of all corners in this BevelRectangle pen.
          * @param align (optional) The align value of the pen.
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen( args[0], args[1], args[2], args[3], args[6] ) ;
            if ( args[4] != null && args[4] is Number )
            {
                hBevel = args[4] ;
            }
            if ( args[5] != null && args[5] is Number )
            {
                vBevel = args[5] ;
            }
        }
        
        /**
         * @private
         */
        private var _hBevel:Number ;
        
        /**
         * @private
         */
        private var _vBevel:Number ;
    }
}
