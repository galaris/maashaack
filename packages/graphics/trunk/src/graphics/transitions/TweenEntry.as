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
    import graphics.easings.linear;

    import system.Cloneable;
    import system.hack;
    
    /**
     * A basic TweenEntry used in the Tween and TweenLite class.
     */
    public class TweenEntry implements Cloneable 
    {
        use namespace hack ;
        
        /**
         * Creates a new TweenEntry instance.
         * @param prop the property string value.
         * @param easing the easing function of the tween entry (use a Function or an Easing object).
         * @param begin the begin value.
         * @param finish the finish value.
         */
        public function TweenEntry( prop:String=null , easing:*=null , begin:Number=NaN , finish:Number=NaN )
        {
            this.begin  = begin  ;
            this.easing = easing ;
            this.finish = finish ;
            this.prop   = prop   ;
        }
        
        /**
         * Defines the begin value of the value.
         */
        public var begin:Number ;
        
        /**
         * Indicates the change value of this tween entry.
         */
        public function get change():Number 
        {
            return _change ;
        }
        
        /**
         * Defines the easing method reference of this entry (use a Function or an Easing object).
         */
        public function get easing():Function
        {
            return _easing ;
        }
            
        /**
         * @private
          */
        public function set easing( f:Function ):void 
        {
            _easing = f || linear ;
        }
        
        /**
         * Defines the finish value of the entry.
         */
        public function get finish():Number 
        {
            return _finish ;
        }
        
        /**
         * @private
         */
        public function set finish(n:Number):void 
        {
            _finish = n ;
            _change = n - begin ;
            if ( isNaN(_change ) )
            {
                _change = 0 ;
            }
        }
        
        /**
         * The property of the tween entry.
         */
        public var prop:String ;
        
        /**
         * Returns a shallow copy of this entry.
         * @return a shallow copy of this entry.
         */
        public function clone():*
        {
            return new TweenEntry(prop, easing, begin, finish);
        }
        
        /**
         * Returns the current position of this entry with the specified time value and with the specified duration.
         * @param t The time position of the motion.
         * @param d The duration value of the motion.
         * @return the current position of this entry with the specified time value and with the specified duration.
         */
        public function getPosition( t:Number , d:Number ):Number 
        {
            return _easing( t, begin, _change , d ) ;
        }
        
        /**
         * Sets the position of the tween entry with the specified time value and with the specified duration.
         * @param t The time position of the motion.
         * @param d The duration value of the motion.
         * @return the current position of this entry with the specified time value and with the specified duration.
         */
        public function set( t:Number , d:Number ):Number 
        {
            return _pos = _easing( t, begin, _change , d ) ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String 
        {
            return "[TweenEntry" + (prop ? (":" + prop) : "") + "]" ;
        }
        
        /**
         * @private
         */
        hack var _change:Number = 0 ;
        
        /**
         * @private
         */
        hack var _finish:Number ;
        
        /**
         * @private
         */
        hack var _easing:Function ;
        
        /**
         * @private
         */
        private var _pos:Number ;
    }
}
