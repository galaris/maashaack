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

    /**
     * This Action launch the init method of ths process but notify an event before (ActionEvent.START) and after(ActionEvent.FINISH) the process.
     * This class is a pseudo abstract class. Don't instanciate this class but create a custom class with it.
     * @example
     * You must use this class with a custom class who extends this class.
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import examples.InitTest ; // extends InitProcess.
     * 
     * var debug:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e ) ;
     * }
     * 
     * var p:InitTest = new InitTest() ;
     * 
     * p.addEventListener( ActionEvent.START  , debug ) ;
     * p.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * p.run() ;
     * 
     * // [ActionEvent type="onStarted" target=[InitTest] context=null bubbles=false cancelable=false eventPhase=2]
     * // [InitTest] custom initialize
     * // [ActionEvent type="onFinished" target=[InitTest] context=null bubbles=false cancelable=false eventPhase=2]
     * </pre>
     * <code class="prettyprint">InitTest</code> is the child class of the <code class="prettyprint">InitProcess</code> pseudo abstract class :
     * <pre class="prettyprint">
     * package examples
     * {
     *     import system.process.InitProcess ;
     *     
     *     public class InitTest extends InitProcess
     *     {
     *     
     *         public function InitTest( global:Boolean = false , channel:String = null )
     *         {
     *             super( global, channel );
     *         }
     *         
     *         public function init():void
     *         {
     *             trace( this + " custom initialize") ;
     *         }
     *     }
     * }
     * </pre>
     */
    public dynamic class InitProcess extends ActionProxy
    {

        /**
         * Creates a new InitProcess instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function InitProcess( global:Boolean = false , channel:String = null ) 
        {
            super( this, this["init"], null, global, channel);
        }

        /**
         * Invoked when the process is run. 
         * Overrides this method.
         */
        prototype.initialize = function():void
        {
            // override
        };
        
    }
}
