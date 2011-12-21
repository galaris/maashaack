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

package system.models
{
    import system.signals.Signal;
    import system.signals.Signaler;
    
    /**
     * This model can keep an object in memory and emit messages if this object is changing.
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.models.ChangeModel ;
     * 
     * var beforeChanged:Function = function( value:* , model:ChangeModel ):void
     * {
     *     trace( "before old:" + value + " current:" + model.current ) ;
     * }
     * 
     * var changed:Function = function( value:* , model:ChangeModel ):void
     * {
     *     trace( "change current:" + value ) ;
     * }
     * 
     * var model:ChangeModel = new ChangeModel() ;
     * 
     * model.beforeChanged.connect( beforeChanged ) ;
     * model.changed.connect( changed ) ;
     * 
     * model.current = "hello" ;
     * model.current = "world" ;
     * model.current = null ;
     * </code>
     * </listing>
     */
    public class ChangeModel extends KernelModel 
    {
        /**
         * Creates a new ChangeModel instance.
         */
        public function ChangeModel()
        {
            _beforeChanged = new Signal() ;
            _changed       = new Signal() ;
            _cleared       = new Signal() ;
        }
        
        /**
         * Emits a message before the current object in the model is changed.
         */
        public function get beforeChanged():Signaler
        {
            return _beforeChanged ;
        }
        
        /**
         * Emits a message when the current object in the model is changed.
         */
        public function get changed():Signaler
        {
            return _changed ;
        }
        
        /**
         * Emits a message when the current object in the model is cleared.
         */
        public function get cleared():Signaler
        {
            return _cleared ;
        }
        
        /**
         * Determinates the selected value in this model.
         */
        public function get current():*
        {
            return _current ;
        }
        
        /**
         * @private
         */
        public function set current( o:* ):void
        {
            if ( o == _current && security )
            {
                return ;
            }
            
            if( o )
            {
                validate( o ) ;
            }
            
            const old:* = _current ;
            
            _current = o ;
            
            if ( old != null )
            {
                notifyBeforeChange( old ) ;
            }
            
            if ( _current != null )
            {
                notifyChange( _current );
            }
        }
        
        /**
         * This property defined if the current property can accept the same object in argument as the current one. 
         */
        public var security:Boolean = true ;
        
        /**
         * Clear the model.
         */
        public function clear():void
        {
            _current = null;
            notifyClear() ;
        }
        
        /**
         * Notify a signal before the specified value is changed.
         */ 
        public function notifyBeforeChange( value:* ):void
        {
            if ( !isLocked( ) )
            {
                _beforeChanged.emit( value , this ) ;
            }
        }
        
        /**
         * Notify a signal when the model is changed.
         */
        public function notifyChange( value:*  ):void
        {
            if ( !isLocked( ) )
            {
                _changed.emit( value , this ) ;
            }
        }
        
        /**
         * Notify a signal when the model is cleared.
         */ 
        public function notifyClear():void
        {
            if ( !isLocked( ) )
            {
                _cleared.emit( this ) ;
            }
        }
        
        /**
         * @private
         */
        protected var _current:* ;
        
        /**
         * @private
         */
        protected var _beforeChanged:Signaler ;
        
        /**
         * @private
         */
        protected var _changed:Signaler ;
        
        /**
         * @private
         */
        protected var _cleared:Signaler ;
    }
}
