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
    import core.maths.DEG2RAD;

    import graphics.Align;
    import graphics.geom.AspectRatio;

    import flash.display.DisplayObject;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * The DisplayObject tool class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.Align ;
     * import graphics.display.DisplayObjects ;
     * 
     * import flash.display.Shape ;
     * import flash.geom.Rectangle ;
     * 
     * stage.scaleMode = "noScale" ;
     * stage.align     = "tl" ;
     * 
     * var background:Shape = new Shape() ;
     * 
     * background.graphics.beginFill( 0x333333 ) ;
     * background.graphics.drawRect(0,0,100,100) ;
     * 
     * background.x = 100 ;
     * background.y = 100 ;
     * 
     * addChild( background ) ;
     * 
     * var shape:Shape = new Shape() ;
     * 
     * shape.graphics.beginFill( 0x666666 ) ;
     * shape.graphics.drawRect(0,0,100,100) ;
     * 
     * shape.x = 100 ;
     * shape.y = 100 ;
     * 
     * addChild( shape ) ;
     *
     * var area:Rectangle = new Rectangle(100,100,100,100) ;
     *  
     * DisplayObjects.resize(shape, 50, 50) ;
     * DisplayObjects.align(shape, area, Align.CENTER) ;
     * 
     * trace( DisplayObjects.originalHeight(shape) ) ; // 100
     * trace( DisplayObjects.originalWidth(shape) ) ; // 100
     * </pre>
     */
    public class DisplayObjects
    {
        /**
         * Aligns a DisplayObject within specific bounds.
         * @param target The DisplayObject to align.
         * @param bounds The rectangle in which to align the target DisplayObject.
         * @param align The Align value to defines the position of the display in the specified bounds (default Align.TOP_LEFT).
         * <p>You can use the Align values :</p>
         * <p>bottom : Align.BOTTOM, Align.BOTTOM_LEFT, Align.BOTTOM_RIGHT</p>
         * <p>center : Align.CENTER, Align.CENTER_LEFT, Align.CENTER_RIGHT</p>
         * <p>top    : Align.TOP   , Align.TOP_LEFT   , Align.TOP_RIGHT</p>
         * @param offset The offset point to translate the target after the alignment process.
         * @param propWidth The name of the width property of the target reference (default "width").
         * @param propHeight The name of the height property of the target reference (default "height").
         */
        public static function align( target:DisplayObject, bounds:Rectangle, align:Number = 10 , offset:Point = null , propWidth:String = "width" , propHeight:String = "height" ):void
        {
            if ( !target )
            {
                throw new ArgumentError( "DisplayObjects.align failed, the target DisplayObject argument not must be null.") ;
            }
            if ( !target )
            {
                throw new ArgumentError( "DisplayObjects.align failed, the bounds Rectangle argument not must be null.") ;
            }
            var dh:Number = bounds.height - target[propHeight] ;
            var dw:Number = bounds.width  - target[propWidth]  ;
            var dx:Number = bounds.x + ( offset ? offset.x : 0 ) ;
            var dy:Number = bounds.y + ( offset ? offset.y : 0 ) ; 
            switch( align )
            {
                case Align.NONE :
                {
                    break ;
                }
                case Align.BOTTOM :
                case Align.BOTTOM | Align.LEFT | Align.RIGHT :
                {
                    target.x = dx + dw / 2 ;
                    target.y = dy + dh ;
                    break ;
                }
                case Align.BOTTOM_LEFT :
                case Align.LEFT_BOTTOM :
                {
                    target.x = dx ;
                    target.y = dy + dh ;
                    break ;
                }
                case Align.BOTTOM_RIGHT :
                case Align.RIGHT_BOTTOM :
                {
                    target.x = dx + dw ;
                    target.y = dy + dh ;
                    break ;
                }
                case Align.CENTER :
                case Align.TOP | Align.BOTTOM :
                case Align.TOP | Align.BOTTOM | Align.CENTER :
                {
                    target.x = dx + dw / 2 ;
                    target.y = dy + dh / 2 ;
                    break ;
                }
                case Align.CENTER_LEFT :
                case Align.LEFT        :
                case Align.TOP | Align.BOTTOM | Align.LEFT :
                case Align.TOP | Align.BOTTOM | Align.CENTER | Align.LEFT :
                {
                    target.x = dx ;
                    target.y = dy + dh / 2 ;
                    break ;
                }
                case Align.CENTER_RIGHT :
                case Align.RIGHT        :
                case Align.TOP | Align.BOTTOM | Align.RIGHT :
                case Align.TOP | Align.BOTTOM | Align.CENTER | Align.RIGHT :
                {
                    target.x = dx + dw ;
                    target.y = dy + dh / 2 ;
                    break ;
                }
                case Align.TOP :
                case Align.TOP | Align.LEFT | Align.RIGHT :
                {
                    target.x = dx + dw / 2 ;
                    target.y = dy ;
                    break ;
                }
                case Align.TOP_RIGHT :
                case Align.RIGHT_TOP :
                {
                    target.x = dx + dw ;
                    target.y = dy ;
                    break ;
                }
                case Align.TOP_LEFT  :
                case Align.LEFT_TOP  :
                default              :
                {
                    target.x = dx ;
                    target.y = dy ;
                }
            }
        }
        
        /**
         * Converts a point from the local coordinate system of one DisplayObject to the local coordinate system of another DisplayObject.
         * @param point the point to convert
         * @param from The original coordinate display system.
         * @param to The new coordinate display system.
         */
        public static function localToLocal( point:Point , from:DisplayObject, to:DisplayObject ):Point
        {
            return to.globalToLocal( from.localToGlobal(point) ) ;
        }
        
        /**
         * Returns the original height in pixels of the specified DisplayObject.
         * @param target The passed-in display to check.
         * @return the original height in pixels of the specified DisplayObject.
         */
        public static function originalHeight( target:DisplayObject ):Number 
        {
            return target.height / target.scaleY ;
        }
        
        /**
         * Returns the original width in pixels of the specified DisplayObject.
         * @param target The passed-in display to check.
         * @return the original width in pixels of the specified DisplayObject.
         */
        public static function originalWidth( target:DisplayObject ):Number 
        {
            return target.width / target.scaleX ;
        }
        
        /**
         * Resizes a DisplayObject to fit into specified bounds such that the aspect ratio of the target's width and height does not change.
         * @param target The DisplayObject to resize.
         * @param width The desired width for the target.
         * @param height The desired height for the target.
         * @param aspectRatio The optional desired aspect ratio (a Number or a AspectRatio object) or <code class="prettyprint">true</code> to use the current aspect ratio of the display.
         */
        public static function resize( target:DisplayObject, width:Number, height:Number, aspectRatio:* = null ):void
        {
            if ( !target )
            {
                throw new ArgumentError( "DisplayObjects.resize failed, the target DisplayObject argument not must be null.") ;
            }
            if ( aspectRatio == null )
            {
                target.width  = width ;
                target.height = height ;
            }
            else
            {
                var current:Number ;
                if ( aspectRatio is AspectRatio )
                {
                    current = (aspectRatio as AspectRatio).width / (aspectRatio as AspectRatio).height ;
                }
                else if ( aspectRatio is Number && !isNaN(aspectRatio) )
                {
                    current = aspectRatio as Number ; 
                }
                else
                {
                    current = target.width / target.height;
                }
                var bounds:Number = width / height ;
                if( current < bounds )
                {
                    target.width  = Math.floor( height * current ) ;
                    target.height = height;
                }
                else
                {
                    target.width  = width;
                    target.height = Math.floor( width / current );
                }
            }
        }
        
        /**
         * Rotates the specified DisplayObject with a specific custom center of rotation.
         * @param target The DisplayObject to rotate.
         * @param angle The angle in degrees of the rotation.
         * @param anchor The optional Point to defines the anchor of the rotation (default [0,0)).
         */
        public static function rotate( target:DisplayObject , angle:Number , anchor:* = null ):void
        {
            var m:Matrix = target.transform.matrix ;
            if ( anchor == null )
            {
                anchor = new Point() ;
            }
            var p:Point  = m.transformPoint( anchor ) ;
            m.translate( -p.x , -p.y ) ;
            m.rotate( angle * DEG2RAD ) ;
            m.translate( p.x , p.y ) ;
            target.x         = m.tx ;
            target.y         = m.ty ;
            target.rotation += angle ; 
        }
    }
}
