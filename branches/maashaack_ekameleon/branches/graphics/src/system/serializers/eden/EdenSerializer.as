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

package system.serializers.eden
{
    import system.Serializable;
    import system.Serializer;
    
    /**
     * The eden Serializer class
     */    
    public class EdenSerializer implements Serializer, Serializable
    {

        /**
         * @private
         */
        private var _prettyIndent:int = 0;     
        
        //default
        
        /**
         * @private
         */
        private var _prettyPrinting:Boolean = false; 
        
        //default
        
        /**
         * @private
         */
        private var _indentor:String = "    ";
        
        //default
        
        /**
         * Creates a new EdenSerializer instance.
         */
        public function EdenSerializer()
        {
            /* note:
               later we may want to configure the instanciation of the serializer
               ex: custom config, custom authorized etc.
            */
        }

        /**
         * Indicates the pretty indent value.
         */        
        public function get prettyIndent():int
        {
            return _prettyIndent;
        }

        /**
         * Indicates the indentor string representation.
         */        
        public function get indentor():String
        {
            return _indentor;
        }

        /**
         * @private
         */
        public function set indentor( value:String ):void
        {
            _indentor = value;
        }

        /**
         * @private
         */
        public function set prettyIndent( value:int ):void
        {
            _prettyIndent = value;
        }

        /**
         * Indicates the pretty printing flag value.
         */
        public function get prettyPrinting():Boolean
        {
            return _prettyPrinting;
        }

        /**
         * @private
         */
        public function set prettyPrinting( value:Boolean ):void
        {
            _prettyPrinting = value;
        }

        /**
         * Inserts an authorized path in the white list of the parser.
         */
        public function addAuthorized( ...arguments:Array ):void
        {
            var a:Array = config.authorized as Array ;
            if ( a != null )
            {
                var l:int = arguments.length ;
                for( var i:int = 0 ; i < l ; i++ )
                {
                    if( ! a.indexOf( arguments[i] ) > - 1 )
                    {
                        a.push( arguments[i] );
                    }
                }
            }
            else
            {
                throw new Error( this + " addAuthorized failed with a null 'authorized' Array to configurate the eden parser." ) ;
            }
        }        

        /**
         * Parse a string and interpret the source code to the correct ECMAScript construct.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * "undefined" --> undefined
         * "0xFF"      --> 255
         * "{a:1,b:2}" --> {a:1,b:2}
         * </pre>
         * @return a string representing the data.
         */         
        public function deserialize( source:String ):*
        {
            return ECMAScript.evaluate( source );
        }

        /**
         * Removes an authorized path in the white list of the parser.
         */
        public function removeAuthorized( ...arguments:Array ):void
        {
            var paths:* ;
            var i:int ;
            var found:* ;
            
            paths = [].concat( arguments ) ;
            
            var l:int = paths.length ;
            for( i = 0 ; i < l ; i++ )
            {
                found = config.authorized.indexOf( paths[i] );
                if( found > - 1 )
                {
                    config.authorized.splice( found, 1 );
                }
            }
        }        

        /**
         * Serialize the specified value object passed-in argument.
         */          
        public function serialize( value:* ):String
        {
            if( value === undefined )
            {
                return "undefined";
            }
            
            if( value === null )
            {
                return "null";
            }
            
            if( value is Serializable )
            {
                return value.toSource( prettyIndent );
            }
            
            if( value is String )
            {
                return BuiltinSerializer.emitString( value );
            }
            
            if( value is Boolean )
            {
                return value ? "true" : "false";
            }
            
            if( value is Number )
            {
                return value.toString( );
            }
            
            if( value is Date )
            {
                return BuiltinSerializer.emitDate( value );
            }
            
            /* TODO:
            - add RegExp serializer
            cf: new RegExp( "abc", "i" );
            - add XML serializer
            cf: new XML( "<data><node>xyz</node></data>" );
             */
            if( value is Array )
            {
                return BuiltinSerializer.emitArray( value );
            }
            
            if( value is Object )
            {
                return BuiltinSerializer.emitObject( value );
            }            
            
            return "<unknown>";
        }

        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return info( false, false );
        }
    }
}

