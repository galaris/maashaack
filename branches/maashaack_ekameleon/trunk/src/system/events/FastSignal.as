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

package system.events 
{
    import system.Cloneable;
    import system.data.WeakReference;
    
    /**
     * This class provides a fast Signal implementation.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import system.events.FastSignal ;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.Event;
     *     
     *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class FastSignalExample extends Sprite
     *     {
     *         public function FastSignalExample()
     *         {
     *             var signal:FastSignal = new FastSignal() ;
     *             
     *             signal.connect( write ) ;
     *             
     *             signal.emit( "hello world" ) ; // hello world
     *             signal.emit( "thank you" ) ; // thank you
     *         }
     *         
     *         public function write( message:String ):void
     *         {
     *             trace( message ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class FastSignal extends InternalSignal implements Cloneable
    {
        /**
         * Creates a new FastSignal instance.
         * @param receivers The Array collection of receiver objects to connect with this signal.
         */
        public function FastSignal( receivers:Array = null )
        {
            super( receivers ) ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new FastSignal( toArray() ) ;
        }
        
        /**
         * Emit the specified values to the listeners.
         */
        public override function emit( ...values:Array ):void
        {
            if ( values == null  && receivers.size() == 0 )
            {
                return ;
            }
            var removed:Array = [] ;
            var receiver:* ;
            var a:Array = receivers.toArray() ;
            var l:int   = a.length ;
            for ( var i:int ; i<l ; i++ ) 
            {
                receiver = a[i] ;
                if ( receiver is WeakReference )
                {
                    receiver = (receiver as WeakReference).value ;
                    if( receiver == null )
                    {
                        removed.push( receiver ) ;
                    }
                }
                if ( receiver is Function )
                {
                    (receiver as Function).apply( null , values ) ;
                }
                // garbage collector / remove null weak reference
                if ( removed.length > 0 ) 
                {
                    l = removed.length ;
                    while( --l > -1 )
                    {
                        receivers.remove( removed[l] ) ;
                    }
                }
            }
        }
    }
}
