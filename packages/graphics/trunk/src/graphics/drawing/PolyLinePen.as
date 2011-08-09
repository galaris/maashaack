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
    import graphics.geom.Vector2;
    
    import flash.geom.Point;
    
    /**
     * The PolyLine pen is used to draw a complex shape with differents points (Vector2) in a data model.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.geom.Point ;
     * 
     * import graphics.FillStyle ;
     * import graphics.drawing.PolyLinePen ;
     * import graphics.geom.Vector2 ;
     * 
     * stage.align     = "tl" ;
     * stage.scaleMode = "noScale" ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 0 ;
     * shape.y = 0 ;
     * 
     * addChild( shape ) ;
     * var data:Array =
     * [
     *     new Vector2(10,10), new Vector2(110,10), new Point(110,110), {x:10,y:110}
     * ] ;
     * 
     * var pen:PolyLinePen = new PolyLinePen( shape , data ) ;
     * pen.fill            = new FillStyle( 0xFF0000 ) ;
     * pen.draw() ;
     * </pre>
     */
    public dynamic class PolyLinePen extends Pen 
    {
        /**
         * Creates a new PolyLinePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param data The array representation of the model of this polyline
         */
        public function PolyLinePen( graphic:* , data:Array = null )
        {
            super( graphic );
            this.data = data ;
        }
        
        /**
         * Determinates the array representation of all points of this polyline pen.
         * <p>This Array can contains graphics.geom.Vector2, flash.geom.Point or all objects with a numeric x an y properties.</p>
         */
        public function get data():Array 
        {
            return _data ;
        }
        
        /**
         * @private
         */
        public function set data( ar:Array ):void 
        {
            _data = _filterData( ar );
        }
        
        /**
         * Indicates if the polyline is automatically closed.
         */
        public var useClose:Boolean = true ;
        
        /**
         * Indicates if first point in the data model is the first offset position, the x and y value of this pen change and use the value of this point.
         */
        public var useFirst:Boolean = true ; 
        
        /**
         * Defines the x position of the shape rectangle. 
         */
        public var x:Number ;
        
        /**
         * Defines the y position of the shape rectangle. 
         */
        public var y:Number ;
        
        /**
         * Draws the shape.
         * @param data The array representation of all vectors or points to draw the shape.
         */
        public override function draw( ...args:Array ):void
        {
            if ( args.length > 0 ) 
            {
                data = args[0] as Array ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( data != null && data.length ) 
            {
                if ( useFirst )
                {
                    x = data[0].x ;
                    y = data[0].y ;
                }
                
                var f:Vector2 = new Vector2
                ( 
                    isNaN(x) ? 0 : x , 
                    isNaN(y) ? 0 : y 
                ) ;
                
                M( f.x , f.y ) ;
                
                var v:Vector2 ;
                var i:int = 0 ;
                var l:int = data.length ;
                while (i < l) 
                {
                    v = data[i++] as Vector2 ;
                    if ( v != null )
                    {
                        if ( i == 0 && useFirst )
                        {
                            //
                        }
                        else if ( useFirst )
                        {
                            L( v.x , v.y ) ;
                        }
                        else
                        {
                            L( v.x + f.x , v.y + f.y ) ;
                        }
                    }
                }
                if ( useClose )
                {
                    L( f.x , f.y ) ;
                }
            }
        } 
        
        /**
         * Returns the number of elements in the model.
         * @return the number of elements in the model.
         */
        public function size():Number 
        {
            return _data.length ;
        }
        
        /**
         * @private
         */
        protected var _data:Array = [] ;
        
        /**
         * Invoked to filter the objects in the data property value, ignored all none graphics.geom.Vector2, flash.geom.Point, or object with the attribute x and y inside.
         * @private
         */
        protected function _filterData( ar:Array ):Array
        {
            var r:Array ;
            if ( ar != null && ar.length > 0 )
            {
                r = [] ;
                var o:* ;
                var v:Vector2 ;
                var l:int = ar.length ;
                for( var i:int ; i<l ; i++ )
                {
                    v = null  ;
                    o = ar[i] ;
                    if ( o is Vector2 )
                    {
                        v = o as Vector2 ;
                    }
                    else if ( o is Point )
                    {
                        v = new Vector2( o.x , o.y ) ;
                    }
                    else if ( "x" in o && "y" in o )
                    {
                        v = new Vector2( o["x"] as Number , o["y"] as Number ) ;
                    }
                    if ( v != null )
                    {
                        r.push( v ) ;
                    }
                }
            }
            return r ;
        }
    }
}
