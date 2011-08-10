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
package examples.vo
{
    public class Filter
    {
        /**
         * Creates a new Filter instance. 
         * @param value (optional) The default filter value of this value object.
         */
        public function Filter( value:Number = 0 )
        {
            setFilter( value ) ;
        }
        
        /**
         * The default filter value of the filter value objects.
         */
        public static var NONE:Number = 0 ;
        
        /**
         * The filter value of this object.
         */
        public var filter:Number ;
        
        /**
         * Clear the filter value.
         */
        public function clear():void
        {
            filter = NONE ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the filter number value contains the option number value.
         * @return <code class="prettyprint">true</code> if the filter number value contains the option number value.
         */
        public function contains( value:Number ) : Boolean
        {
            return Boolean( value & getFilter() ) ;
        }
        
        /**
         * Returns the current filter value of this object.
         * @return the current filter value of this object.
         */
        public function getFilter():Number
        {
            return isNaN( filter ) ? NONE : filter ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the filter is NONE.
         * @return <code class="prettyprint">true</code> if the filter is NONE.
         */
        public function isNone():Boolean
        {
            return getFilter() == NONE ;
        }
        
        /**
         * Sets the current filter value of this object.
         */
        public function setFilter( n:Number ):void
        {
            filter = isNaN(n) ? NONE : n ;
        }
        
        /**
         * Toggle a filter value in this filter object.
         */
        public function toggleFilter( value:Number, b:Boolean ):Boolean
        {
            var old:Number = filter ;
            filter = b ? ( filter | value ) : ( filter & ~value ) ;
            return old != filter ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object
        {
            return { filter:filter } ;
        }
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public function toString():String
        {
            return "[Filter " + filter + "]" ;
        }
    }
}
