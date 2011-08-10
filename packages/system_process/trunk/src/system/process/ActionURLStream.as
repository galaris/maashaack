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

package system.process 
{
	import flash.net.ObjectEncoding;
    import flash.events.IEventDispatcher;
    import flash.net.URLStream;
    
    /**
     * This action process launch the load of an URLStream object.
     */
    public class ActionURLStream extends CoreActionLoader 
    {
        /**
         * Creates a new ActionURLStream instance.
         * @param stream The URLStream reference to insert in a task engine.
         */
        public function ActionURLStream( stream:URLStream = null )
        {
            super( stream ) ;
        }
        
        /**
         * Returns the number of bytes of data available for reading in the input buffer.
         */
        public function get bytesAvailable():uint
        {
            return (_loader is URLStream) ? (_loader as URLStream).bytesAvailable : 0 ;
        }
        
        /**
         * Indicates whether this URLStream object is currently connected.
         */
        public function get connected():Boolean
        {
            return (_loader is URLStream) ? (_loader as URLStream).connected : false ;
        }
        
        /**
         * Indicates the byte order for the data.
         */
        public function get endian():String
        {
            return (_loader is URLStream) ? (_loader as URLStream).endian : null ;
        }
        
        /**
         * @private
         */
        public function set endian(type:String):void
        {
            if ( _loader != null && _loader is URLStream )
            {
                (_loader as URLStream).endian = endian ;
            }
        }
        
        /**
         * @private
         */
        public override function set loader( loader:IEventDispatcher ):void
        {
            super.loader = loader as URLStream ;
        }
        
        /**
         * Controls the version of Action Message Format (AMF) used when writing or reading an object.
         */
        public function get objectEncoding():uint
        {
            return (_loader is URLStream) ? (_loader as URLStream).objectEncoding : ObjectEncoding.AMF3 ;
        }
        
        /**
         * @private
         */
        public function set objectEncoding( version:uint ):void
        {
            if ( _loader != null && _loader is URLStream )
            {
                (_loader as URLStream).objectEncoding = version ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new ActionURLStream( loader as URLStream ) ;
        }
        
        /**
         * Cancels a load() method operation that is currently in progress for the Loader instance.
         */
        public override function close():void
        {
            if ( _loader != null && _loader is URLStream )
            {
                (_loader as URLStream).close() ;
            }
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * This protected method contains the invokation of the load method of the current loader of this process.
         */
        protected override function _run():void
        {
            var l:URLStream = (_loader as URLStream) ;
            if ( l != null )
            { 
                l.load( request ) ;
            }
        }
    }
}
