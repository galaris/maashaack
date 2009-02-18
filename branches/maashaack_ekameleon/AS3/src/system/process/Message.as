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
     * This <code class="prettyprint">Action</code> object create a pause in the process.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * 
     * var handleEvent:Function = function( e:ActionEvent ) :void
     * {
     *     trace( e ) ;
     * }
     * 
     * var m:Message = new Message("hello world", "happy", 10, true) ;
     * m.addEventListener( ActionEvent.START  , handleEvent ) ;
     * m.addEventListener( ActionEvent.FINISH , handleEvent ) ;
     * m.run() ;
     * </pre>
     */
    public class Message extends Pause
    {
        
        /**
         * Creates a new Message instance.
         * @param message The message to notify when the pause if finished.
         * @param face The optional face value of this message.
         * @param duration the duration of the pause.
         * @param seconds the flag to indicates if the duration is in second or not.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function Message( message:String , face:String = null, duration:Number = 0 , seconds:Boolean = false , to:* = null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super(duration, seconds, bGlobal, sChannel) ;
            this.message = message ;
            this.face    = face    ;
            this.to      = to      ;
        }
        
        /**
         * Determinates a value to send the message in the local application.
         */
        public static const ME:Number = 0 ;
        
        /**
         * Determinates a value to send the message to all users.
         */
        public static const ALL:Number = 1 ;
        
        /**
         * The message value.
         */
        public var message:String ;
        
        /**
         * An optional face value.
         */
        public var face:String ;
        
        /**
         * An optional to value.
         */
        public var to:* ;

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new Message(message, face, duration, useSeconds, to) ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public override function toString():String 
        {
            var txt:String = "[Message duration:" + duration + (useSeconds ? "s" : "ms") ;
            
            if ( message != null && message.length > 0 ) 
            {
                txt += " message:" + message ;
            }
            
            if (face != null && face.length > 0)
            {
                txt += " face:" + face ;
            }
            
            if (this.to != null)
            {
                txt += " to:" + this.to ;
            } 
            
            txt += "]" ;
            return txt ;
            
        }

    }

}