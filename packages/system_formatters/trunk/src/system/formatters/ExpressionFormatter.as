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

package system.formatters 
{
    import core.strings.format;
    
    import system.Formattable;
    
    import flash.utils.Dictionary;
    
    /**
     * This dictionary register formattable expression and format a String with all expressions in the dictionnary. 
     * <pre class="prettyprint">
     * import system.formatters.ExpressionFormatter ;
     * 
     * var source:String ;
     * 
     * var formatter:ExpressionFormatter = new ExpressionFormatter() ;
     * 
     * formatter["root"]      = "c:" ;
     * formatter["system"]    = "{root}/project/system" ;
     * formatter["data.maps"] = "{system}/data/maps" ;
     * formatter["map"]       = "{data.maps}/HashMap.as" ;
     * 
     * source = "the root : {root} - the class : {map}" ; 
     * // the root : c: - the class : c:/project/system/data/maps/HashMap.as
     * 
     * trace( formatter.format( source ) ) ;
     * 
     * trace( "----" ) ;
     * 
     * formatter["system"]    = "%root%/project/system" ;
     * formatter["data.maps"] = "%system%/data/maps" ;
     * formatter["HashMap"]   = "%data.maps%/HashMap.as" ;
     * 
     * formatter.beginSeparator = "%" ;
     * formatter.endSeparator   = "%" ;
     * 
     * source = "the root : %root% - the class : %HashMap%" ;
     * 
     * trace( formatter.format( source ) ) ;
     * // the root : c: - the class : c:/project/system/data/maps/HashMap.as
     * </pre>
     */
    public dynamic class ExpressionFormatter extends Dictionary implements Formattable
    {
        /**
         * Creates a new Expression instance.
         * @param weakKeys Instructs the Dictionary object to use "weak" references on object keys. 
         * If the only reference to an object is in the specified Dictionary object, 
         * the key is eligible for garbage collection and is removed from the table when the object is collected. 
         */
        public function ExpressionFormatter( weakKeys:Boolean = false )
        {
            super( weakKeys );
            _reset() ;
        }
        
        /**
         * The max recursion value.
         */
        public static var MAX_RECURSION:uint = 200 ;
        
        /**
         * The begin separator of the expression to format (default "{").
         */
        public function get beginSeparator():String
        {
            return _beginSeparator ;
        }
        
        /**
         * @private
         */
        public function set beginSeparator( str:String ):void
        {
            _beginSeparator = str || "{" ;
            _reset() ;
        }
        
        /**
         * The end separator of the expression to format (default "}").
         */
        public function get endSeparator():String
        {
            return _endSeparator ;
        }
        
        /**
         * @private
         */
        public function set endSeparator( str:String ):void
        {
            _endSeparator = str || "}" ;
            _reset() ;
        }
        
        /**
         * Formats the specified value.
         * @param value The object to format.
         * @return the string representation of the formatted value. 
         */
        public function format( value:* = null ):String
        {
            return _format( value.toString() ) ;
        }
        
        /**
         * @private
         */
        private var _beginSeparator:String = "{" ;
        
        /**
         * @private
         */
        private var _endSeparator:String = "}" ;
        
        /**
         * @private
         */
        private var _pattern:String = "{0}((\\w+\)|(\\w+)((.\\w)+|(.\\w+))){1}" ;
        
        /**
         * @private
         */
        private var _reg:RegExp ;
        
        /**
         * @private
         */
        private function _format( str:String , depth:uint=0 ):String
        {
            if ( depth >= MAX_RECURSION )
            {
                return str ;
            } 
            var m:Array = str.match( _reg ) ;
            var l:int   = m.length ;
            if ( l > 0 )
            {
                var key:String ;
                for ( var i:int ; i<l ; i++ )
                {
                    key = m[i].substr(1) ;
                    key = key.substr( 0 , key.length-1 ) ;
                    if ( this[key] != null && (this[key] is String) )
                    {
                        this[key] = _format( this[key] as String , depth + 1 ) ;
                        str       = str.replace( m[i]  , this[key] ) ;
                    }
                }
            }
            return str ;
        }
        
        /**
         * @private
         */
        private function _reset():void
        {
            _reg = new RegExp( core.strings.format( _pattern , beginSeparator , endSeparator ), "g" ) ;
        }
    }
}
