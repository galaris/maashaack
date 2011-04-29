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

package graphics.transitions 
{
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.display.MovieClip;
    
    [Embed(source="FrameLoop.swf", symbol="FrameLoopAsset")]
    
    /**
     * This MovieClip contains two frames and emit a signal when is playing.
     * <p><b>Note:</b> The FLA to compile the FrameLoopAsset symbol embed in this class is in the folder trunk/build/frameloop of the project.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.transitions.FrameLoop ;
     * 
     * var cpt:uint = 0 ;
     * 
     * var loop:Function = function():void
     * {
     *     cpt++ ;
     *     trace( "loop : " + cpt ) ;
     *     if ( cpt == 100 )
     *     {
     *         frame.stop() ;
     *     }
     * }
     * 
     * var frame:FrameLoop = new FrameLoop() ;
     * 
     * frame.connect( loop ) ;
     * 
     * frame.play() ; // start the frame loop
     * </pre>
     */
    public class FrameLoop extends MovieClip implements Signaler
    {
        /**
         * Creates a new FrameLoop instance.
         */
        public function FrameLoop()
        {
            stop() ;
            _signal = new Signal() ;
            addFrameScript( 0 , _signal.emit ) ;
            addFrameScript( 1 , _signal.emit ) ;
        }
        
        /**
         * Indicates the number of receivers connected.
         */
        public function get length():uint
        {
            return _signal.length ;
        }
        
        /**
         * Connects a Function or a Receiver object.
         * @param receiver The receiver to connect : a Function reference or a Receiver object.
         * @param priority Determinates the priority level of the receiver.
         * @param autoDisconnect Apply a disconnect after the first trigger
         * @return <code>true</code> If the receiver is connected with the signal emitter.
         */
        public function connect( receiver:*, priority:uint = 0, autoDisconnect:Boolean = false ):Boolean
        {
            return _signal.connect( receiver , priority , autoDisconnect ) ;
        }
        
        /**
         * Returns <code>true</code> if one or more receivers are connected.
         * @return <code>true</code> if one or more receivers are connected.
         */
        public function connected():Boolean
        {
            return _signal.connected() ;
        }
        
        /**
         * Disconnect the specified object or all objects if the parameter is null.
         * @return <code>true</code> if the specified receiver exist and can be unregister.
         */
        public function disconnect( receiver:* = null ):Boolean
        {
            return _signal.disconnect( receiver ) ;
        }
        
        /**
         * Emit the specified values to the receivers.
         * @param ...values All values to emit to the receivers.
         */
        public function emit(...values:Array):void
        {
            _signal.emit.apply( _signal, values ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified receiver is connected.
         * @return <code class="prettyprint">true</code> if the specified receiver is connected.
         */
        public function hasReceiver( receiver:* ):Boolean
        {
            return _signal.hasReceiver( receiver ) ;
        }
        
        /**
         * @private
         */
        private var _signal:Signal ;
    }
}
