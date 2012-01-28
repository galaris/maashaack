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

package system.events
{
    import system.Cloneable;
    import system.process.Runnable;
    
    import flash.events.Event;
    
    /**
     * Delegate event listener, this listener create a proxy over a method and this scope.
     * <p><b>Note :</b>
     * <li>The <code class="prettyprint">Delegate</code> class implements <code class="prettyprint">EventListener</code> interface. you can use a Delegate instances in the <code class="prettyprint">addEventListener</code> method for all <code class="prettyprint">IEventDispatcher</code> implementations.</li>
     * <li>The <code class="prettyprint">Delegate</code> class implements <code class="prettyprint">system.process.Runnable</code> interface</li>
     * </p>
     */
    public class Delegate implements Cloneable, EventListener, Runnable
    {
        /**
         * Creates a new Delegate instance.
         * @param scope the scope to be used by calling this method.
         * @param method the method to be executed.
         * @param ...args the optional argument to pass in the method.
         */
        public function Delegate( scope:* , method:Function , ...args:Array )
        {
            _s = scope ;
            _m = method ;
            _a = [].concat( args ) ;
            _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
        }
         
        /**
         * Determinates the <code class="prettyprint">Array</code> representation of all arguments called in the proxy method.
         */
        public function get arguments():Array
        {
            return _a ;
        }
        
        /**
         * @private
         */
        public function set arguments( args:Array ):void
        {
            _a = _a.concat( args ) ;
            _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
        }
        
        /**
         * Indicates the proxy method reference.
         */
        public function get method():Function 
        {
            return _m ;
        }
        
        /**
         * Indicates the scope reference of the proxy target.
         */
        public function get scope():*
        {
            return _s ;
        }
        
        /**
         * Adds arguments in the list of all arguments passed-in the proxy method.
         */
        public function addArguments( ...args:Array ):void 
        {
            if ( args.length > 0 ) 
            {
                _a = [].concat( _a , args ) ;
                _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
            }
        } 
        
        /**
         * Returns a shallow copy of the instance.
         * @return a shallow copy of the instance.
         */
        public function clone():*
        {
            var d:Delegate = new Delegate( _s, _m ) ;
            d.addArguments.apply( d,  _a ) ;
            return d ;
        }
        
        /**
         * Creates a method that delegates its arguments to a specified scope. This static method is a wrapper for MM compatibility.
         * @param scope this scope to be used by calling this method.
         * @param method the method to be called.
         * @return a Function that delegates its call to a custom scope, method and arguments.
         */
        public static function create( scope:* , method:Function, ...arguments:Array ):Function 
        {
            var f:Function = function( ...args:Array ):* 
            {    
                var s:* = f["s"] ;
                var m:Function = f["m"] ;
                var a:Array = [].concat(args, f["a"]) ;
                return m.apply( s , a ) ;
            } ;
            f["s"] = scope ;
            f["m"] = method ;
            f["a"] = arguments ;
            return f ;
        }
        
        /**
         * Handles the event.
         */
        public function handleEvent( e:Event ):void
        {
            Delegate.create.apply( this, [_s].concat([_m], [].concat(e, _a)) )() ;
        }
        
        /**
         * Run the proxy method in the provided context. 
         */
        public function run( ...arguments:Array ):void
        {
            if (arguments.length > 0)
            {
                addArguments.apply(this, arguments) ;
            }
            _p() ;
        }
        
        /**
         * @private
         */
        private var _m:Function ;
        
        /**
         * @private
         */
        private var _s:* ;
        
        /**
         * @private
         */
        private var _a:Array ;
        
        /**
         * @private
         */
        private var _p:Function ;
    }
}