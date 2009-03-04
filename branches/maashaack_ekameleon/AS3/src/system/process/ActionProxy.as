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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.process 
{
    import system.events.Delegate ;
    
    /**
     * This <code class="prettyprint">Action</code> object run a proxy method.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import system.process.ActionProxy ;
     * 
     * var debug:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e ) ;
     * }
     * 
     * var test:Function = function( ...args:Array ):void
     * {
     *     trace( this + " test : " + args ) ;
     * }
     * 
     * var o:Object = {} ;
     * o.toString = function():String
     * {
     *     return "myObject" ;
     * }
     * 
     * var ap:ActionProxy = new ActionProxy( o, test, ["hello world", true] ) ;
     * trace ( "action proxy    : " + ap ) ;
     * trace ( "action toSource : " + ap.toSource() ) ;
     * ap.addEventListener( ActionEvent.START  , debug ) ;
     * ap.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * ap.run() ; // run the process
     * 
     * // action proxy : [ActionProxy]
     * // action toSource : new system.process.ActionProxy()
     * // [ActionEvent type="onStarted" target=[ActionProxy] context=null bubbles=false cancelable=false eventPhase=2]
     * // myObject test : hello world,true
     * // [ActionEvent type="onFinished" target=[ActionProxy] context=null bubbles=false cancelable=false eventPhase=2]
     * </pre>
     */
    public class ActionProxy extends Task
    {
    
        /**
         * Creates a new ActionProxy instance.
         * @param scope The scope of the proxy method invoked in this process.
         * @param method The method invoked in this process.
         * @param args The Arguments injected in the method.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        function ActionProxy( scope:*, method:Function , args:Array=null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal, sChannel );
            this.args   = args ;
            this.method = method ;
            this.scope  = scope ;
        }
        
        /**
         * The array representation of the proxy method invoked in this process.
         */
        public var args:Array ;
        
        /**
         * The proxy method invoked in this process.
         */
        public var method:Function ;
        
        /**
         * The scope reference of the proxy method of this process.
         */
        public var scope:Object ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new ActionProxy( scope, method, args ) ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            var params:Array = [scope, method] ;
            if ( args != null && args.length > 0 )
            {
                params = params.concat(args) ;
            }
            Delegate.create.apply(this, params)();
            notifyFinished() ;
        }
    
    }

}