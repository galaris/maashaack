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

package system.reflection
{

    /**
     * This interface defines the object who indicates all informations about a class in the reflection pattern of system.
     */
    public interface ClassInfo extends TypeInfo
    {
        /**
         * List all accessors in the class.
         */
        function get accessors():Array;

        /**
         * List all constants in the class.
         */
        function get constants():Array;

        /**
         * The filter type reference of this class info.
         */
        function get filter():FilterType;
        
        /**
         * @private
         */
        function set filter( value:FilterType ):void;

        /**
         * List all members in the class.
         * Members are the combination of properties and methods.
         */
        function get members():Array;

        /**
         * List all methods in the class.
         */
        function get methods():Array;  

        /**
         * Indicates the name of the class.
         */
        function get name():String ;

        /**
         * List all properties in the class.
         * Properties are the combination of variables, constants and accessors.
         */
        function get properties():Array;

        /**
         * Indicates the ClassInfo object of the super class.
         */
        function get superClass():ClassInfo ;

        /**
         * List all variables in the class.
         */
        function get variables():Array;

        /**
         * Indicates if the specified class implements all interfaces passed-in arguments.
         * @param ...interfaces All the interfaces to search in the current ClassInfo.
         * @return <code class="prettyprint">true</code> if the class has the specified interfaces.
         */
        function hasInterface( ...interfaces ):Boolean ;
        
        /**
         * Indicates if the specified class inherit fromm all class passed-in arguments.
         * @param ...interfaces All the interfaces to search in the current ClassInfo.
         * @return <code class="prettyprint">true</code> if the class has the specified interfaces.
         */
        function inheritFrom( ...classes ):Boolean ;
        
        /**
         * Indicates if the specified object is dynamic.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * trace( Reflection.getClassInfo(Object).isDynamic() ) ; // true
         * </pre>
         */
        function isDynamic():Boolean;
        
        /**
         * Indicates if the specified object is final.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * trace( Reflection.getClassInfo(String).isFinal() ) ; // true
         * </pre>
         */
        function isFinal():Boolean;

        /**
         * Indicates if the specified object is instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * 
         * trace( Reflection.getClassInfo( Array ).isInstance() ) ; // false
         * trace( Reflection.getClassInfo( new Array() ).isInstance() ) ; // true
         * </pre>
         */
        function isInstance():Boolean;
        
        /**
         * Indicates if the specified object is static.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * trace( Reflection.getClassInfo(Math).isStatic() ) ; // true
         * </pre>
         */
        function isStatic():Boolean;
        
        /**
         * Returns the XML representation of the class.
         * @return the XML representation of the class.
         */
        function toXML():XML;
    }
}