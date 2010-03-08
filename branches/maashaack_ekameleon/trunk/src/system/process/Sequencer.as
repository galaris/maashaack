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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
     * A Sequencer of Action process.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import system.process.Sequencer  ;
     * 
     * var handleEvent:Function = function( e:ActionEvent ):void
     * {
     *     trace(e) ;
     * }
     * 
     * var seq:Sequencer = new Sequencer() ;
     * 
     * seq.addEventListener( ActionEvent.START    , handleEvent ) ;
     * seq.addEventListener( ActionEvent.PROGRESS , handleEvent ) ;
     * seq.addEventListener( ActionEvent.FINISH   , handleEvent ) ;
     * 
     * seq.addAction( new Pause( 10 , true ) );
     * seq.addAction( new Pause(  2 , true ) ) ;
     * seq.addAction( new Pause(  5 , true ) ) ;
     * seq.addAction( new Pause( 10 , true ) ) ;
     * seq.run() ;
     * </pre>
     */
    public class Sequencer extends Chain
    {
        /**
         * Creates a new Sequencer instance.
         * @param length The initial length (number of elements) of the Vector. If this parameter is greater than zero, the specified number of Vector elements are created and populated with the default value appropriate to the base type (null for reference types).
         * @param fixed Whether the chain length is fixed (true) or can be changed (false). This value can also be set using the fixed property.
         * @param looping Specifies whether playback of the clip should continue, or loop (default false). 
         * @param numLoop Specifies the number of the times the presentation should loop during playback.
         * @param mode Specifies the mode of the chain. The mode can be "normal", "transient" (default) or "everlasting".
         * @param actions A dynamic object who contains Action references to initialize the chain.
         */
        public function Sequencer( length:uint = 0 , fixed:Boolean = false , looping:Boolean = false , numLoop:uint = 0 , mode:String = "transient" , actions:* = null )
        {
            super( length, fixed, looping, numLoop, mode, actions ) ;
        }
        
        /**
         * Determinates the "everlasting" mode of the chain. In this mode the action register in the chain can't be auto-remove.
         */
        public static const EVERLASTING:String = "everlasting" ;
        
        /**
         * Determinates the "normal" mode of the chain. In this mode the chain has a normal life cycle.
         */
        public static const NORMAL:String = "normal" ;
        
        /**
         * Determinates the "transient" mode of the chain. In this mode all actions are strictly auto-remove in the chain when are invoked.
         */
        public static const TRANSIENT:String = "transient" ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            var clone:Sequencer = new Sequencer( 0 , false , looping , numLoop , _mode, _actions.length > 0 ? toVector() : null ) ;
            clone.fixed = fixed ;
            return clone ;
        }
    }
}