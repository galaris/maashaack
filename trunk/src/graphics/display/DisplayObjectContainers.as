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
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    /**
     * The DisplayObjectContainer tool class.
     */
    public class DisplayObjectContainers 
    {
        /**
         * Removes all childs in the specified container.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.display.DisplayObjectContainers ;
         * 
         * var display1:Sprite = new Sprite() ;
         * var display2:Sprite = new Sprite() ;
         * 
         * var container:Sprite   = new Sprite() ;
         * 
         * container.addChild( display1 );
         * container.addChild( display2 );
         * 
         * trace( container.numChildren ) ;
         * 
         * DisplayObjectContainers.clear( container ) ;
         * 
         * trace( container.numChildren ) ;
         * </pre>
         */
        public static function clear( container:DisplayObjectContainer ):void
        {
            var size:int = container.numChildren ;
            while(--size > -1)
            {
                container.removeChildAt( size ) ; 
            }
        }
        
        /**
         * Moves a specified child object in the specified container at the specified z-depth value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.display.DisplayObjectContainers ;
         * 
         * var display1:Sprite = new Sprite() ;
         * display1.graphics.beginFill( 0xF55B1B , 1 ) ;
         * display1.graphics.drawCircle(0, 0, 30 ) ;
         * 
         * var display2:Sprite = new Sprite() ;
         * display2.graphics.beginFill( 0x3D6AD3 , 1 ) ;
         * display2.graphics.drawRect(0, 0, 60, 60) ;
         * 
         * var container1:Sprite   = new Sprite() ;
         * container1.mouseEnabled = false ;
         * container1.x            = 100 ;
         * container1.y            = 150 ;
         * 
         * var container2:Sprite   = new Sprite() ;
         * container2.mouseEnabled = false ;
         * container2.x            = 200 ;
         * container2.y            = 150 ;
         * 
         * addChild( container1 );
         * addChild( container2 );
         * 
         * container1.addChild( display1 ) ;
         * container2.addChild( display2 ) ;
         * 
         * var down:Function = function( e:MouseEvent ):void
         * {
         *     DisplayObjectContainers.move( display1, container2 , 0 ) ;
         * }
         * 
         * stage.addEventListener( MouseEvent.MOUSE_DOWN , down ) ;
         * </pre>
         */
        public static function move( child:DisplayObject , container:DisplayObjectContainer, index:int = -1  ):Boolean
        {
            if ( child == null || container == null )
            {
                return false ;
            }
            var parent:DisplayObjectContainer = child.parent ;
            if ( parent != null )
            {
                parent.removeChild( child ) ;
            }
            if ( ( index <= -1 )  || ( index >= container.numChildren ) )
            {
                container.addChild( child ) ;
            }
            else
            {
                container.addChildAt( child , index ) ;
            } 
            return true ;
        }
        
        /**
         * Swaps the z-order and the container of the two specified childs objects.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.display.DisplayObjectContainers ;
         * 
         * var display1:Sprite = new Sprite() ;
         * display1.graphics.beginFill( 0xF55B1B , 1 ) ;
         * display1.graphics.drawCircle(30, 30, 30 ) ;
         * 
         * var display2:Sprite = new Sprite() ;
         * display2.graphics.beginFill( 0x3D6AD3 , 1 ) ;
         * display2.graphics.drawRect(0, 0, 60, 60) ;
         * 
         * var container1:Sprite   = new Sprite() ;
         * container1.mouseEnabled = false ;
         * container1.x            = 20 ;
         * container1.y            = 20 ;
         * 
         * var container2:Sprite   = new Sprite() ;
         * container2.mouseEnabled = false ;
         * container2.x            = 150 ;
         * container2.y            = 20 ;
         * 
         * addChild( container1 );
         * addChild( container2 );
         * 
         * container1.addChild( display1 ) ;
         * container2.addChild( display2 ) ;
         * 
         * var click:Function = function( e:MouseEvent ):void
         * {
         *     DisplayObjectContainers.swapChildren( display1, display2 ) ;
         * }
         * 
         * stage.addEventListener( MouseEvent.CLICK , click ) ;
         * </pre>
         * @return true if the two DisplayObject objects are swapped.
         */
        public static function swapChildren( child1:DisplayObject , child2:DisplayObject ):Boolean
        {
            if ( child1 == null || child2 == null )
            {
                return false ;
            }
            else
            {
                var p1:DisplayObjectContainer = child1.parent ;
                var p2:DisplayObjectContainer = child2.parent ;
                if ( p1 == null || p2 == null )
                {
                    return false ;
                }
                else
                {
                    var b1:Boolean = move( child1 , p2 , p1.getChildIndex( child1 ) ) ;
                    var b2:Boolean = move( child2 , p1 , p2.getChildIndex( child1 ) ) ;
                    return b1 && b2 ;
                }
            }
        }
    }
}
