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

package system.data 
{
    import flash.utils.Dictionary;
    
    /**
     * A weak reference is a reference that does not protect the referent object from collection by a garbage collector. 
     * An object referenced only by weak references is considered unreachable (or "weakly reachable") and so may be collected at any time.
     * Weak references are used to prevent circular references and to avoid keeping in memory referenced by unneeded objects.
     */
    public class WeakReference 
    {
        /**
         * Create a new <code>WeakReference</code> instance.
         * @param value The value of the weak reference.
         */
        public function WeakReference( value:* = null )
        {
            this.value = value ;
        }
        
        /**
         * The value of the weak reference.
         */
        public function get value():*
        {
            for( var value:* in _d )
            {
                return value;
            }
            return null ;
        }
        
        /**
         * @private
         */
        public function set value( value:* ):void
        {
            if( value )
            {
                _d          = new Dictionary( true ) ;
                _d[ value ] = PRESENT ;
            }
            else
            {
                _d = null ;
            }
        }
        
        /**
         * Dispose the reference.
         */
        public function dispose(): void
        {
            _d = null;
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString(): String
        {
            return "[WeakReference " + value.toString() + "]" ;
        }
        
        /**
         * @private
         */
        private var _d:Dictionary ;
        
        /**
         * @private
         */
        private static const PRESENT:Boolean = true ;
    }
}
