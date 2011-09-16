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

package system.data
{
    import core.dump;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    
    import system.Equatable;
    import system.Serializable;
    
    /**
     * The SimpleValueObject class provides a basic implementation of the ValueObject interface.
     */
    public class SimpleValueObject implements Equatable, Serializable, ValueObject
    {
        /**
         * Creates a new SimpleValueObject instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function SimpleValueObject( init:Object=null )
        {
            if ( init != null )
            {
                for (var prop:String in init )
                {
                    this[prop] = init[prop] ;
                }
            }
        }
        
        /**
         * Indicates the id of this ValueObject.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _id = id ;
        }
        
        /**
         * Compares the specified object with this object for equality. This method compares the ids of the objects.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if (o is Identifiable)
            {
                return ( o as Identifiable ).id == this.id ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * A utility function for implementing the toString() method. 
         * Overriding the toString() method is recommended, but not required.
         */
        public function formatToString( className:String = null , ...args:Array ):String
        {
            var source:String ;
            
            source = "[" ;
            
            source += ( className != null && className != "" ) ? className : getClassName(this) ;
            
            if ( args.length > 0 )
            {
                var m:String ; 
                var i:int ;
                var l:int = args.length ;
                for( i = 0 ; i<l ; i++ )
                {
                    m = args[i] as String;
                    if ( m && m in this )
                    {
                        source += " " + m + ":" + (this[m] == null ? "null" : String(this[m]) ) ;
                    }
                }
            }
            
            source += "]" ;
            
            return source ;
        }
        
        /**
         * Returns the generic Object representation of this object.
         * @return the generic Object representation of this object.
         */
        public function toObject():Object
        {
            return { id:id } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" + dump(toObject()) + ")" ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function toString():String
        {
            return formatToString( getClassName(this) , "id" ) ;
        }
        
        /**
         * @private
         */
        private var _id:* ;
    }
}