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
package graphics.media 
{
    import system.data.SimpleValueObject;
    
    import flash.media.Microphone;
    
    /**
     *  An optional object to set a specific flash.media.Microphone reference.
     */
    public class MicrophoneOption extends SimpleValueObject 
    {
        /**
         * Creates a new MicrophoneOption instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function MicrophoneOption( init:Object=null )
        {
            super( init );
        }
        
        /**
         * Routes audio captured by a microphone to the local speakers.
         */
        public var loopBack:Boolean = true ;
           
        /**
         * The rate at which the microphone captures sound, in kHz.
         */
        public var rate:Number = 11 ;
        
        /**
         * The amount of sound required to activate the microphone and dispatch the activity event.
         */
        public var silenceLevel:Number ;
        
        /**
         * The number of milliseconds between the time the microphone stops detecting sound and the time the activity event is dispatched.
         */
        public var silenceTimeout:Number ;
         
        /**
         * Set to true if echo suppression is enabled; false otherwise.
         */
        public var useEchoSuppression:Boolean ;
         
        /**
         * Apply this value object in the specified Microphone reference.
         */
        public function apply( micro:Microphone ):void
        {
            if ( micro != null )
            {
                micro.setLoopBack( loopBack ) ;
                micro.setUseEchoSuppression( useEchoSuppression ) ;
                micro.setSilenceLevel( silenceLevel, silenceTimeout ) ;
            }
        }
        
        /**
         * Returns the <code class="prettyprint">Object</code> representation of this object.
         * @return the <code class="prettyprint">Object</code> representation of this object.
         */
        public override function toObject():Object
        {
            var object:Object =
            {
                rate               : rate  ,
                silenceLevel       : silenceLevel ,
                timeout            : silenceTimeout ,
                useEchoSuppression : useEchoSuppression
            };
            return object ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            return formatToString( "MicrophoneOption" , "rate" , "silenceLevel" , "silenceTimeout" , "useEchoSuppression" ) ;
        } 
    }
}
