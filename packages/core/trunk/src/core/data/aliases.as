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
package core.data 
{
    import flash.utils.Dictionary;
    
    /**
     * This object is an helper to defines an dictionary of aliases. 
     */
    public final class aliases
    {
        /**
         * Creates a new aliases instance.
         */
        public function aliases()
        {
            _dictionary = new Dictionary() ;
        }
        
        /**
         * Indicates the number of alias registered in the collector.
         */
        public function get length():uint
        {
            return _size ;
        }
        
        /**
         * Clear all alias in the internal map of this object.
         */
        public function clear():void
        {
            _dictionary = new Dictionary() ;
            _size       = 0 ;
        }
        
        /**
         * Indicates if the collector contains the passed-in alias expression.
         * @return <code class="prettyprint">true</code> if the collector contains the passed-in alias expression.
         */
        public function containsAlias( alias:String ):Boolean
        {
            if ( _size == 0  || alias == null || alias.length == 0 )
            {
                return false ;
            }
            return _dictionary[alias] != null ;
        }
        
        /**
         * Indicates if the collector contains the passed-in type value expression.
         * @return <code class="prettyprint">true</code> if the collector contains the passed-in value expression.
         */
        public function containsValue( value:String ):Boolean
        {
            if ( _size == 0  || value == null || value.length == 0 )
            {
                return false ;
            }
            for each ( var v:String in _dictionary )
            {
                 if ( v == value )
                 {
                    return true ;
                 }
            }
            return false ;
        }
        
        /**
         * Returns the Array representation of all aliases registered in this collector.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var aliases:Aliases = new Aliases() ;
         * 
         * aliases.register( "Sprite"    , "flash.display.Sprite" ) ;
         * aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
         * 
         * trace( aliases.getAliases() ) ; // Sprite,MovieClip
         * </pre>
         * @return the Array representation of all aliases registered in this collector.
         */
        public function getAliases():Array 
        {
            var ar:Array = [] ;
            for( var alias:String in _dictionary )
            {
                ar.push( alias ) ;
            }
            return ar.length > 0 ? ar : null ;
        }
        
        /**
         * Returns the value of the specified alias.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var aliases:Aliases = new Aliases() ;
         * 
         * aliases.register( "Sprite" , "flash.display.Sprite" ) ;
         * 
         * trace( aliases.getValue("Sprite") ) ; // flash.display.Sprite
         * </pre>
         * @return the value of the specified alias.
         */
        public function getValue( alias:String ):String 
        {
            return _dictionary[alias] ;
        }
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of all type values registered in this collector.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var aliases:Aliases = new Aliases() ;
         * 
         * aliases.register( "Sprite"    , "flash.display.Sprite" ) ;
         * aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
         * 
         * trace( aliases.getValues() ) ; // flash.display.Sprite,flash.display.MovieClip
         * </pre>
         * @return the <code class="prettyprint">Array</code> representation of all type values registered in this collector.
         */
        public function getValues():Array 
        {
            var ar:Array = [] ;
            for each( var values:String in _dictionary )
            {
                ar.push( values ) ;
            }
            return ar.length > 0 ? ar : null ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the collector is empty.
         * @return <code class="prettyprint">true</code> if the collector is empty.
         */
        public function isEmpty():Boolean
        {
            return _size == 0 ;
        }
        
        /**
         * Inserts an alias in the collector. If the alias already exist the value in the collector is replaced.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var aliases:Aliases = new Aliases() ;
         * aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
         * </pre>
         * @param alias The alias name, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @param value The value of the alias type, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</code> if the alias can be registered.
         */
        public function register( alias:String , value:String ):Boolean
        {
            if ( alias == null || value == null || alias.length == 0  || value.length == 0 )
            {
                return false ;
            }
            var exist:Boolean = (_dictionary[alias] != null) ;
            _dictionary[ alias ] = value ;
            if ( !exist )
            {
                _size++ ;
            }
            return true ;
        }
        
        /**
         * Inserts an alias in the collector. If the alias already exist the value in the collector is replaced.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * var aliases:Aliases = new Aliases() ;
         * aliases.register( "MovieClip" , "flash.display.MovieClip" ) ;
         * aliases.unregister( "MovieClip" ) ;
         * </pre>
         * @param alias The alias name, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @param value The value of the alias type, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</code> if the alias can be uregistered.
         */
        public function unregister( alias:String ):Boolean
        {
            if ( _size == 0 || alias == null || alias.length == 0  )
            {
                return false ;
            }
            var exist:Boolean = (_dictionary[alias] != null) ;
            _dictionary[ alias ] = undefined ;
            if ( exist )
            {
                _size-- ;
            }
            return exist ;
        }
        /**
         * Returns the internal Dictionary reference of this collector.
         * @return the internal Dictionary reference of this collector.
         */
        public function toDictionary():Dictionary
        {
            var clone:Dictionary = new Dictionary() ;
            if ( _size > 0 )
            {
                for( var alias:String in _dictionary )
                {
                    clone[alias] = _dictionary[alias] ;
                }
            }
            return clone ;
        }
        
        /**
         * @private
         */
        protected var _dictionary:Dictionary ;
        
        /**
         * @private
         */
        protected var _size:uint ;
    }
}
