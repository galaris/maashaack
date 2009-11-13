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

package system 
{
    import flash.system.ApplicationDomain;
    import flash.utils.getQualifiedClassName;
    
    /**
     * A static class for Vectors utilities.
     */
    public class Vectors 
    {
        /**
         * @private
         */
        private static const VECTOR_CLASS_NAME:String = getQualifiedClassName( Vector );
        
        /**
         * Creates a new dynamic Vector object with the specified arguments.
         * @return a new dynamic Vector object with the specified arguments.
         */
        public static function create( clazz:Class, length:uint = 0 , fixed:Boolean = false , applicationDomain:ApplicationDomain = null ):Vector.<*>
        {
            var def:Class = getVectorDefinition( clazz , applicationDomain ) as Class ;
            if ( def == null )
            {
                return null ;
            }
            var v:* = new def( length , fixed ) ;
            return v ;
        }
        
        /**
         * Returns the definition of the Vector defines with the specified class. A specific ApplicationDomain can be specified.
         * @return the definition of the Vector defines with the specified class. A specific ApplicationDomain can be specified.
         */
        public static  function getVectorDefinition( clazz:Class , applicationDomain:ApplicationDomain = null ):Class
        {
            if ( clazz == null )
            {
                return null ;
            }
            if( applicationDomain == null )
            {
                applicationDomain = ApplicationDomain.currentDomain ;
            }
            return applicationDomain.getDefinition( VECTOR_CLASS_NAME + '.<' + getQualifiedClassName( clazz ) +'>' ) as Class ;
        }
        
        /**
         * Converts an Vector to an Array.
         * @return The Array reprensentation of the specified Vector.
         */
        public static function toArray( v:* ):Array
        {
            if ( v == null )
            {
                return null ;
            }
            var ar:Array = [] ;
            var len:int = v.length ;
            if ( len == 0 )
            {
                return ar ;
            }
            for( var i:int ; i<len ; i++)
            {
                ar[i] = v[i] ;
            }
            return ar ;
        }
    }
}
