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

package examples.display 
{
    import system.process.Lockable;
    
    import flash.display.Sprite;
    
    /**
     * This sprite draw a rectangle with a virtual width and height value.
     */
    public class Canvas extends Sprite implements Lockable
    {
        /**
         * Creates a new Canvas instance.
         */
        public function Canvas()
        {
            //
        }
        
        /**
         * The color of the rectangle shape.
         */
        public function get color():uint 
        {
            return _color ;
        }
        
        /**
         * @private
         */
        public function set color( value:uint ):void 
        {
            _color = value ;
            update() ;
        }
        
        /**
         * Determinates the virtual height value of this sprite.
         */
        public function get h():Number 
        {
            return _h ;  
        }
        
        /**
         * @private
         */
        public function set h( n:Number ):void 
        {
            _h = isNaN(n) ? 0 : n ;
            update() ;
        }
        
        /**
         * Determinates the virtual height value of this sprite.
         */
        public function get w():Number 
        {
            return _w ;
        }
        
        /**
         * @private
         */
        public function set w( n:Number ):void 
        {
            _w = isNaN(n) ? 0 : n ;
            update() ;
        }
        
        /**
         * Draw the display.    
         */
        public function draw():void
        {
            graphics.clear() ;
            graphics.beginFill( color , 1 ) ;
            graphics.drawRect( 0, 0, w, h ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ == true ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ = true ;
        } 
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = false ;
        }
        
        /**
         * Update the display.
         */ 
        public function update():void
        {
            if ( isLocked() ) 
            {
                return ;
            }
            trace(this + " update") ;
            draw() ;
        }
        
        /**
         * @private
         */
        protected var _color:uint = 0xFF0000 ;
        
        /**
         * @private
         */
        protected var _h:Number = 0 ;
        
        /**
         * @private
         */
        protected var _w:Number = 0 ;
        
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */ 
        private var ___isLock___:Boolean ;
    }
}
