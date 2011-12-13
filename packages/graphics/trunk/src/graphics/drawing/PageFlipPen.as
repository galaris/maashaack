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

package graphics.drawing 
{
    import graphics.Direction;
    import graphics.Directionable;
    
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    /**
     * This pen computes, generates, and draws a pageflip in a specifig Graphics object with two BitmapData reference (pages).
     * <p>Map of the page flip algorithm.</p>
     * <pre>
     *  TOP_LEFT(0,0)                        TOP_RIGHT(1,0)
     *  ---------------------------------------------------
     *  |  &lt;-------------------PW----------------------&gt;  |
     *  | ^ Offset(0,0)  x--&gt;                             |
     *  | |                                               |
     *  | | y                                             |
     *  | | |                                             |
     *  | | |                                             |
     *  | | V                                             |
     *  | |              pPoints[]                        |
     *  | |                                               |
     *  | |                                               |
     *  | |                                               |
     *  | |                                          (T3) |
     *  | PH                                           ---|
     *  | |                                         --- /  
     *  | |                                      ---   /   
     *  | |                                   ---     /    
     *  | |                                ---       /     
     *  | |                             ---         /      
     *  | |                          ---           /       
     *  | |                 drag  ---   cPoints[] /        
     *  | |                         \            /         
     *  | |                          \          /          
     *  | |                           \        /           
     *  | |                            \      /            
     *  | |                             \    /             
     *  | V                              \  /              
     *  |-------------------------------- \/               
     *  BOTTOM_LEFT(0,1)                  BOTTOM_RIGHT(1,1)
     * </pre>
     */
    public class PageFlipPen extends Pen implements Directionable
    {
        /**
         * Creates a new PageFlipPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param page1 The first page bitmap (left-top aligned).
         * @param page2 The second page bitmap (left-top aligned).
         * @param ...rest All the optionals arguments to fill the setPen() method (see this method to defines all optional arguments)
         */
        public function PageFlipPen( graphic:* = null, page1:BitmapData = null , page2:BitmapData = null , ...rest:Array ):void 
        {
            super( graphic ) ;
            _page1 = page1 ;
            _page2 = page2 ;
            if ( rest.length > 0 )
            {
                setPen.apply(this, rest) ;
            }
        }
        
        /**
         * The bottom left position of the page.
         */
        public static const BOTTOM_LEFT:Point = new Point( 0, 1 ) ;
        
        /**
         * The bottom right position of the page.
         */
        public static const BOTTOM_RIGHT:Point = new Point( 1, 1 ) ;
        
        /**
         * The top left position of the page.
         */
        public static const TOP_LEFT:Point = new Point( 0, 0 ) ;
        
        /**
         * The top right position of the page.
         */
        public static const TOP_RIGHT:Point = new Point( 1, 0 ) ;
        
        /**
         * The original position of the dragged point. 
         * <p>You can use the PageFlipPen.BOTTOM_LEFT, PageFlipPen.BOTTOM_RIGHT, PageFlipPen.TOP_LEFT, PageFlipPen.TOP_RIGHT points.</p>
         * <p>The two possible values for its x and y properties are 0 or 1. pt(0,0) is the upper-left corner, for example, pt (1,1) is the bottom-right one.</p>
         */
        public function get corner():Point
        {
            return _corner ; 
        }
        
        /**
         * @private
         */
        public function set corner( p:Point ):void 
        {
            _corner = p ;
            initialize() ;
        }
        
        /**
         * Indicates the direction value of this object. The values of this property are Direction.HORIZONTAL("horizontal") or Direction.VERTICAL("vertical").
         * @see graphics.drawing#Direction
         */
        public function get direction():String
        {
            return _direction ;	
        }
        
        /**
         * @private
         */
        public function set direction( value:String ):void 
        {
            _direction = ( value == Direction.VERTICAL ) ? Direction.VERTICAL : Direction.HORIZONTAL ;
            initialize() ;
        }
        
        /**
         * Indicates the position of the drag point relative to the upper-left corner.
         */
        public function get drag():Point
        {
            return _drag ; 
        }
        
        /**
         * @private
         */
        public function set drag( p:Point ):void 
        {
            _drag = p ;
            initialize( ) ;
        }
        
        /**
         * Indicates the height value of the pen.
         */
        public function get height():Number 
        {
            return _h ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void 
        {
            _h = isNaN( value ) ? 0 : value ;
            initialize() ;
        }
        
        /**
         * Determinates the first page bitmap to flip (left-top aligned).
         */
        public function get page1():BitmapData
        {
            return _page1 ;
        }
        
        /**
         * @private
         */
        public function set page1( bmp:BitmapData ):void
        {
            _page1 = bmp ;
        }
        
        /**
         * Determinates the second page bitmap to flip (left-top aligned).
         */
        public function get page2():BitmapData
        {
            return _page2 ;
        }
        
        /**
         * @private
         */
        public function set page2( bmp:BitmapData ):void
        {
            _page2 = bmp ;
        }
        
        /**
         * Determinates the constraints sensibility. 
         * <p>This parameter is a multiplicator for the constraints values.</p>
         * <p>It's intended to prevent some awefull flickering effects. 
         * Its possible value is ranged between 0.9 and 1. 0.9 -> when ptd move is free (drag'n'drop), 1 -> when the "drag" point move is progresive (tween when release). 
         * At best, you should never swap it from .9 to 1. A progressive incrementation is better. 
         * If flickering effects don't disturb you or if your ptd moves is coded, keep this parametter to 1.</p>
         */
        public function get sensibility():int
        {
            return _sensibility ;
        }
        
        /**
         * @private
         */
        public function set sensibility( i:int ):void
        {
            _sensibility = i ;
            initialize() ;
        }
        
        /**
         * Indicates whether or not use pixel smoothing render.
         */
        public var smoothing:Boolean = true ;
        
        /**
         * Determinates the width of this distort pen.
         */
        public function get width():Number 
        {
            return _w;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void 
        {
            _w = isNaN( value ) ? 0 : value ;
            initialize() ;
        }
        
        /**
         * Computes and generates a new flip.
         * @param drag The position of the drag point (the drag one) relative to the upper-left corner.
         * @param corner The original position of the dragged point.
         * @param w indicating the sheet width in pixels.
         * @param h indicating the sheet height in pixels.
         * @param ish If true, horizontal mode is provided, if false, vertical.
         * @param sens The constraints sensibility.
         * @return A generic object who containing the attributes :
         * <p>
         * <ul>
         * <li><b>cPoints:Array</b> Array of points which describes the flipped part of the sheet. Note that in case of the ptd point is aligned with its original position or if the height of the shape is very small (&gt;1) this array is set to null.</li>
         * <li><b>pPoints:Array</b> Array of points wich describes the fixed part of the sheet.</li>
         * <li><b>matrix:Matrix</b> Transformation matrix for the flipped part of the sheet.</li>
         * <li><b>width:Number</b> Sheet width.</li>
         * <li><b>height:Number</b> Sheet height.</li>
         * </ul>
         * </p>
         */
        public static function compute( drag:Point, corner:Point, w:int, h:int, isHorizontal:Boolean, sens:int):Object
        {
            var temp:Number;
            
            var dfx:Number = drag.x - w * corner.x ;
            var dfy:Number = drag.y - h * corner.y ;
            var spt:Point  = corner.clone( );
            var mat:Matrix = new Matrix( );
            var opw:int    = w ;
            var oph:int    = h ;
            
            if ( !isHorizontal )
            {
                temp = w ;
                w    = h ;
                h    = temp ;
                
                temp   = drag.x ;
                drag.x = drag.y ;
                drag.y = temp ;
                
                temp  = corner.x ;
                spt.x = corner.y ;
                spt.y = temp ;
            }
            
            //  pt1 & pt2 are the two fixed points of the sheet. opposed to ptd drag one.
            var pt1:Point = new Point( 0, 0 );
            var pt2:Point = new Point( 0, h );
            
            // default points array
            // cPoints -> the fliped part
            var cPoints:Array = [ null,null,null,null ];
            // pPoints -> the fixed part
            var pPoints:Array = [ new Point( 0, 0 ),new Point( w, 0 ),null,null,new Point( 0, h ) ];
            
            // compute some flip
            _flipDrag( drag, spt, w, h );
            
            // ditstance 
            // it allows you to have a valid position for ptd.
            // the limit is the diagonal of the sheet here
            _limitPoint( drag, pt1, (w * w + h * h) * sens );
            // the limit is about the opposite fixed point
            _limitPoint( drag, pt2, (w * w) * sens );
            
            // first fliped point
            cPoints[0] = new Point( drag.x, drag.y );
            
            var dy:Number = pt2.y - drag.y;
            var tot:Number = w - drag.x - pt1.x;
            var drx:Number = _getDx( dy, tot );
            
            // fliped angle
            var theta:Number = Math.atan2( dy, drx );
            if (dy == 0)theta = 0;
            
            // another fliped angle
            var beta:Number = Math.PI / 2 - theta;
            var hyp:Number = (w - cPoints[0].x) / Math.cos( beta );
            
            // vhyp is the hypotenuse of the fliped part
            var vhyp:Number = hyp;
            
            // if hyp is greater than the height of the sheet or hyp is 
            // negative, the fliped part has 4 points
            // else, it's just a 3 points part (simple corner).
            if (hyp > h || hyp < 0)
            {
                vhyp = h ;
            }
                
            // second fliped point
            cPoints[1] = new Point( cPoints[0].x + Math.cos( - beta ) * vhyp, cPoints[0].y + Math.sin( - beta ) * vhyp );
            
            // last fliped point
            cPoints[3] = new Point( cPoints[0].x + drx, pt2.y );
            
            // if we have a 4 points shape
            if (hyp != vhyp)
            {
                dy = pt1.y - cPoints[1].y;
                tot = w - cPoints[1].x;
                drx = _getDx( dy, tot );
                
                // push the before the last point
                cPoints[2] = new Point( cPoints[1].x + drx, pt1.y );
                
                // we can now find the fixed points of the sheet
                pPoints[1] = cPoints[2].clone( );
                pPoints[2] = cPoints[3].clone( );
                pPoints.splice( 3, 1 );
            }
            else
            {
                // else we delete the point
                cPoints.splice( 2, 1 );
                
                // we can now find the fixed points of the sheet
                pPoints[2] = cPoints[1].clone( );
                pPoints[3] = cPoints[2].clone( );
            }
            
            // these two polygons are always convex !
            
            // now we can flip the two arrays
            _flipPoints( cPoints, spt, w, h );
            _flipPoints( pPoints, spt, w, h );
            
            // if !isHorizontal (vertical mode)
            // we have to change the points orientation 
            if (! isHorizontal)
            {
                _oriPoints( cPoints, spt ) ;
                _oriPoints( pPoints, spt ) ;
            }
            
            // flipped part transfrom matrix
            var gama:Number = theta;
            
            if (corner.y == 0)
            {
                gama = - gama ;
            }
            if (corner.x == 0)
            {
                gama = Math.PI + Math.PI - gama ;
            }
            if (! isHorizontal)
            {
                gama = Math.PI - gama ;
            }
            
            mat.a = Math.cos( gama );
            mat.b = Math.sin( gama );
            mat.c = - Math.sin( gama );
            mat.d = Math.cos( gama );
            
            _ordMatrix( mat, spt, opw, oph, isHorizontal, cPoints, pPoints, gama, beta );
            
            // here we fix some mathematical bugs or instabilities
            if (vhyp == 0)
            {
                cPoints = null;
            }
            if (Math.abs( dfx ) < 1 && Math.abs( dfy ) < 1)
            {
                cPoints = null;
            }
            
            return { cPoints : cPoints , pPoints : pPoints , matrix : mat , width : opw , height : oph } ;
        }
        
        /**
         * Draws the shape and flip the two pages (BitmapData) into the provided Graphics.
         * @param drag The position of the drag point relative to the upper-left corner.
         * @param corner The original position of the dragged point.
         * @param width The width in pixels of the sheet.
         * @param height The height in pixels of the sheet.
         * @param direction The optional Direction.HORIZONTAL or Direction.VERTICAL value.
         * @param sensibility The constraints sensibility.
         */
        public override function draw( ...args:Array ):void 
        {
            if ( args.length > 0 ) 
            {
                setPen.apply( this, args ) ;
            }
            initialize() ;
            super.draw() ;
        }

        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            
            var l:int;
            var ppts:Array = _compute.pPoints;
            var cpts:Array = _compute.cPoints;
            
            ////////// fixed part
            
            _graphics.beginBitmapFill( page1, new Matrix( ), false, smoothing );
            
            l = ppts.length;
            
            _graphics.moveTo( ppts[l - 1].x, ppts[l - 1].y );
            
            while (-- l >= 0 )
            {
                _graphics.lineTo( ppts[l].x, ppts[l].y );
            }
            
            _graphics.endFill( ) ;
            
            ////////// flipped part
            
            if (cpts == null)
            {
                return ;
            }
            
            _graphics.beginBitmapFill( page2, _compute.matrix, false, smoothing );
            
            l = cpts.length ;
            
            _graphics.moveTo( cpts[l - 1].x, cpts[l - 1].y );
            
            while ( -- l >= 0 )
            {
                _graphics.lineTo( cpts[l].x, cpts[l].y );
            }
            
            _graphics.endFill( );
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param drag The position of the PTD point (the drag one) relative to the upper-left corner.
         * @param corner The original position of the dragged point. You can use the PageFlipPen.BOTTOM_LEFT, PageFlipPen.BOTTOM_RIGHT, PageFlipPen.TOP_LEFT, PageFlipPen.TOP_RIGHT points.
         * The two possible values for its x and y properties are 0 or 1. pt(0,0) is the upper-left corner, for example, pt (1,1) is the bottom-right one.
         * @param width The width in pixels of the sheet.
         * @param height The height in pixels of the sheet.
         * @param direction The optional Direction.HORIZONTAL or Direction.VERTICAL value.
         * @param sensibility This value indicating the constraints sensibility. This parametter is a multiplicator for the constraints values. It's intended to prevent some awefull flickering effects. Its possible value is ranged between 0.9 and 1. 0.9 -> when ptd move is free (drag'n'drop), 1 -> when ptd move is progresive (tween when release). At best, you should never swap it from .9 to 1. A progressive incrementation is better. If flickering effects don't disturb you or if your ptd moves is coded, keep this parametter to 1.
         */
        public function setPen( ...args:Array  ):void 
        {
            if ( args[0] != null && args[0] is Point )
            {
                _drag = args[0] as Point ;
            }
            if ( args[1] != null )
            {
                _corner = args[1] ;
            }
            if ( args[2] != null && ! isNaN( args[2] ) )
            {
                _w = args[2] as Number ;
            }
            if ( args[3] != null && ! isNaN( args[3] ) )
            {
                _h = args[3] as Number ;
            }
            if ( args[4] != null && args[4] is String )
            {
                _direction = ( args[4] as String ) == Direction.VERTICAL ? Direction.VERTICAL : Direction.HORIZONTAL ;
            }
            if ( args[5] != null && args[5] is int )
            {
                _sensibility = args[5] as int ;
            } 
        }
        
        /**
         * Sets the size of this pen and re-initializes the triangular grid.
         * @param width New width.
         * @param height    New height.
         */
        public function setSize( width:Number , height:Number ):void 
        {
            _w = isNaN( width ) ? 0 : width  ;
            _h = isNaN( height ) ? 0 : height ;
            initialize( ) ;
        } 
        
        /**
         * Initialize the pen.
         */
        protected function initialize():void 
        {
            _compute = PageFlipPen.compute( _drag, _corner, _w, _h, (_direction == Direction.HORIZONTAL), _sensibility ) ;
        }
        
        /**
         * @private
         */
        private var _compute:Object ;
        
        /**
         * @private
         */
        private var _corner:Point ;
        
        /**
         * @private
         */
        private var _direction:String ;
        
        /**
         * @private
         */
        private var _drag:Point ;
        
        /**
         * @private
         */
        protected var _h:Number ;
        
        /**
         * @private
         */
        private var _page1:BitmapData ;
        
        /**
         * @private
         */
        private var _page2:BitmapData ;
        
        /**
         * @private
         */
        private var _sensibility:int ;
        
        /**
         * @private
         */
        protected var _w:Number ;
        
        /**
         * @private
         */
        private static function _flipDrag( drag:Point , po:Point , w:Number , h:Number ):void
        {
            if (po.y == 0)
            {
                drag.y = h - drag.y ;
            }
            if (po.x == 0)
            {
                drag.x = w - drag.x ;
            }
        }
        
        /**
         * @private
         */
        private static function _flipPoints( pts:Array , po:Point , w:Number , h:Number ):void
        {
            var nb:int = pts.length;
            if (po.y == 0 || po.x == 0)
            {
                while (-- nb >= 0)
                {
                    if (po.y == 0)pts[nb].y = h - pts[nb].y;
                    if (po.x == 0)pts[nb].x = w - pts[nb].x;
                }
            }
        }
        
        /**
         * @private
         */
        private static function _getDx( dy:Number, tot:Number ):Number
        {
            return (tot * tot - dy * dy) / (tot * 2);
        }
        
        /**
         * @private
         */
        private static function _limitPoint( drag:Point, p:Point, dsquare:Number ):void
        {
            var theta:Number ;
            var lim:Number ;
            
            var dy:Number = drag.y - p.y;
            var dx:Number = drag.x - p.x;
            
            var dis:Number = dx * dx + dy * dy;
            
            if (dis > dsquare)
            {
                theta  = Math.atan2( dy, dx ) ;
                lim    = Math.sqrt( dsquare ) ;
                drag.x = p.x + Math.cos( theta ) * lim ;
                drag.y = p.y + Math.sin( theta ) * lim ;
            }
        }
        
        /**
         * @private
         */
        private static function _oriPoints( pts:Array ,po:Point ):void
        {
            var nb:int = pts.length;
            var temp:Number;
            while (-- nb >= 0)
            {
                temp      = pts[nb].x ;
                pts[nb].x = pts[nb].y ;
                pts[nb].y = temp ;
            }
        }
        
        /**
         * @private
         */
        private static function _ordMatrix( mat:Matrix, spt:Point, w:Number, h:Number, isHorizontal:Boolean, cPoints:Array, pPoint:Array, gama:Number, beta:Number):void
        {
            if (spt.x == 1 && spt.y == 0)
            {
                mat.tx = cPoints[0].x;
                mat.ty = cPoints[0].y;
                if (! isHorizontal )
                {
                    mat.tx = cPoints[0].x - Math.cos( gama ) * w - Math.cos( - beta ) * h;
                    mat.ty = cPoints[0].y - Math.sin( gama ) * w - Math.sin( - beta ) * h;
                }
            }
            if (spt.x == 1 && spt.y == 1)
            {
                mat.tx = cPoints[0].x + Math.cos( - beta ) * h;
                mat.ty = cPoints[0].y + Math.sin( - beta ) * h;
                if (! isHorizontal )
                {
                    mat.tx = cPoints[0].x + Math.cos( - beta ) * h;
                    mat.ty = cPoints[0].y - Math.sin( - beta ) * h;
                }
            }
            if (spt.x == 0 && spt.y == 0)
            {
                mat.tx = cPoints[0].x - Math.cos( gama ) * w;
                mat.ty = cPoints[0].y - Math.sin( gama ) * w;
            }
            if (spt.x == 0 && spt.y == 1)
            {
                mat.tx = cPoints[0].x - Math.cos( gama ) * w - Math.cos( - beta ) * h;
                mat.ty = cPoints[0].y - Math.sin( gama ) * w + Math.sin( - beta ) * h;
                if (! isHorizontal )
                {
                    mat.tx = cPoints[0].x;
                    mat.ty = cPoints[0].y;
                }
            }
        }
    }
}