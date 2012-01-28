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

package graphics.transitions 
{
    /**
     * The Tween class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
     * The Tween class also lets you specify a variety of easing methods.
     * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.transitions.Tween ;
     * var tw:Tween = new Tween (mc, "_x", Elastic.easeOut, mc._x, 400, 2, true, true) ;
     * </pre>
     */
    public class Tween extends Motion 
    {
        /**
         * Creates a new Tween instance.
         * <p><b>Usage :</b></p>
         * <pre class="prettyprint">
         * var tw:Tween = new Tween( obj, prop:String, e:*, b:Number, f:Number, d:Number , u:Boolean, auto:Boolean ) ;
         * var tw:Tween = new Tween( obj, entries:Array , d:Number , u:Boolean, auto:Boolean ) ;
         * </pre>
         */
        public function Tween( ...arguments:Array )
        {
            _buffer = new TweenBuffer() ;
            if (arguments[0] != null) 
            {
                target = arguments[0] ;
            }
            var auto:Boolean ;
            var l:int = arguments.length ;
            if ( l > 1 )
            {
                if ( arguments[1] is Array ) 
                {
                    buffer     = arguments[1] as Array ;
                    duration   = arguments[2] > 0 ? arguments[2] : null ;
                    useSeconds = arguments[3] === true ;
                    auto       = arguments[4] === true ;
                }
                else
                {
                    add( new TweenEntry( arguments[1] , arguments[2], arguments[3], arguments[4]) )  ;
                    duration   = ( arguments[5] > 0 ) ? arguments[5] : null ;
                    useSeconds = arguments[6] === true ;
                    auto       = arguments[7] === true ; // auto start
                }
            }
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * Determinates the buffer reference of this Tween.
         * @see graphics.transitions.TweenBuffer
         */
        public function get buffer():* 
        {
            return _buffer ;
        }
        
        /**
         * @private
         */
        public function set buffer( o:* ):void 
        {
            _unCheck() ;
            if ( o is TweenBuffer ) 
            {
                _buffer = o as TweenBuffer ;
            }
            else if ( o is Array ) 
            {
                _buffer = new TweenBuffer( o as Array ) ;
            }
            else 
            {
                _buffer = new TweenBuffer() ;
            }
        }
        
        /**
         * Inserts a TweenEnry in the model of the Tween object.
         * @param entry a TweenEntry reference.
         */
        public function add( entry:TweenEntry ):void 
        {
            _buffer.add( entry ) ;
            _unCheck() ;
        }
        
        /**
         * Inserts a new property in the Tween object.
         * @param prop the string representation of the number property.
         * @param easing the easing method used by the Tween on this property (use a Function or a Easing object).
         * @param begin the begin value.
         * @param finish the finish value.
         * @return a TweenEntry defined by the specified arguments.
         */
        public function addProperty( prop:String=null , easing:*=null, begin:Number=NaN, finish:Number=NaN):TweenEntry 
        { 
            var e:TweenEntry = new TweenEntry(prop, easing, begin, finish) ;
            add(e) ;
            return e ;
        }
        
        /**
         * Removes all entries in the model of this Tween object.
         */
        public function clear():void 
        {
            if ( running ) 
            {
                this.stop() ;
            }    
            if ( _buffer )
            {
                _buffer.clear() ;
            }
            _unCheck() ;
            notifyCleared() ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            var t:Tween = new Tween() ;
            t.target     = target ;
            t.duration   = duration ;
            t.useSeconds = useSeconds ;
            if (size() > 0) 
            {
                t.buffer = buffer.clone() ;
            }
            return t ;
        }
        
        /**
         * Remove a TweenEntry in the Tween Object.
         * @param entry The entry to remove in this Tween.
         */
        public function remove( entry:TweenEntry ):Boolean 
        {
            var b:Boolean =  _buffer.remove( entry ) ;
            _unCheck() ;
            return b ;
        }    
        
        /**
         * Remove a property in the Tween Object.
         */
        public function removeProperty( prop:String ):Boolean 
        {
            var b:Boolean = _buffer.remove( prop ) ;
            _unCheck() ;
            return b ;
        }
        
        /**
         * Set the TweenEntry property of this TweenLite object.
         * @param prop the property name of the object to change.
         * @param easing the easing function of the tween entry (use a Function or a Easing object).
         * @param begin the begin value.
         * @param finish the finish value. 
         */
        public function setTweenEntry( prop:String, easing:* , begin:Number , finish:Number ):void
        {
            if ( _buffer.contains( prop ) )
            {
                var entry:TweenEntry = _buffer.get(prop) ;
                entry.easing = easing ;
                entry.begin  = begin  ;
                entry.finish = finish ;
                _unCheck() ;
            }
            else
            {
                addProperty.apply( this , arguments ) ;
            }
        }
        
        /**
         * Returns the numbers of elements(properties) in the model of this Tween.
         * @return the numbers of elements(properties) in the model of this Tween.
         */
        public function size():Number 
        {
            return _buffer.size() ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            if ( _buffer == null )
            {
                return ;
            }
            if ( _memory == null )
            {
                _memory = _buffer.toArray() ;
            }
            _len = _memory.length ;
            while(--_len > -1) 
            {
                _entry = _memory[_len] as TweenEntry ;
                _target[ _entry.prop ] = _entry.set( _time , _duration ) ;
            }
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        private var _entry:TweenEntry ;
        
        /**
         * @private
         */
        private var _len:int ;
        
        /**
         * @private
         */
        private var _memory:Array ;
         
        /**
         * @private
         */
        private var _buffer:TweenBuffer ;
        
        /**
         * @private
         */
        private function _unCheck():void
        {
            _memory = null ;
            _entry  = null ;
            _len    = 0    ;
        }
    }
}
