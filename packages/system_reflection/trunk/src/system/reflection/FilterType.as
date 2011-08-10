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
    import system.Enum;
    
    /**
     * The filter type enumeration class.
     * <p><b>Description :</b></p>
     * <pre class="prettyprint">
     * 0x000000
     *      |||_  0: both, 1: only prototype, 2: only trait
     *      ||__  0: both declared and inherited, 1: declared only
     *      |___  0: ignore static, 1: include static
     * </pre>
     */
    public class FilterType extends Enum
    {
        /**
         * Creates a new FilterType instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function FilterType( value:int = 0 , name:String = "" )
        {
            super( value , name ) ;
        }
        
        /**
         * Default filter type value.
         * <li>use both prototype and trait</li>
         * <li>both declared and inherited</li>
         * <li>ignore static</li>
         */
        public static const none:FilterType = new FilterType( 0x000 , "none" ) ;
        
        /**
         * Trait members will not be searched. 
         */
        public static const prototypeOnly:FilterType = new FilterType( 0x001 , "prototypeOnly" ) ;
        
        /**
         * Prototype members will not be searched. 
         */
        public static const traitOnly:FilterType = new FilterType( 0x002 , "traitOnly" ) ;
        
        /**
         * Inherited members will not be searched.
         * <p><b>Note:</b></p>
         * <p>For Trait this will apply only to methods and accessors not to variables and constants reason : 
         * variables and constants does not have a declaredBy attribute (from describeType), but that's normal 
         * because "inherited properties are copied down from superclasses into the traits object of subclasses" 
         * (cf: OOP in ActionScript/Advanced Topics/The Trait Object).</p>
         * <p>For prototype this will apply both to properties and methods.</p>
         */
        public static const declaredOnly:FilterType = new FilterType( 0x010 , "declaredOnly" ) ;
        
        /**
         * Static members will be searched too.
         */
        public static const includeStatic:FilterType = new FilterType( 0x100 , "includeStatic" ) ;
        
        /**
         * Indicates if the declared class are showed.
         */
        public function get showDeclared():Boolean
        {
            return ( (valueOf() & 0x0000F0) >>> 4 ) <= 1 ;
        }
        
        /**
         * Indicates if the inherited class are showed.
         */
        public function get showInherited():Boolean
        {
            return ( (valueOf() & 0x0000f0) >>> 4 ) == 0 ;
        }
        
        /**
         * Indicates if the static members are showed.
         */
        public function get showStatic():Boolean
        {
            return ( (valueOf() & 0x000f00) >>> 8 ) != 0 ;
        }
        
        /**
         * Indicates if use prototype information.
         */
        public function get usePrototypeInfo():Boolean
        {
            return ( valueOf() & 0x00000F ) < 2 ;
        }
        
        /**
         * Indicates if use trait information.
         */
        public function get useTraitInfo():Boolean
        {
            return ( valueOf() & 0x00000F ) != 1 ;
        }
    }
}