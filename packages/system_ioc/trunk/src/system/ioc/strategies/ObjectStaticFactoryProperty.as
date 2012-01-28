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

package system.ioc.strategies 
{
    import system.ioc.IObjectFactoryStrategy;
    import system.ioc.ObjectAttribute;
    import system.ioc.ObjectProperty;
    
    /**
     * This object create a static proxy factory configured in the IObjectDefinition and replace the natural factory of the ObjectFactory.
     */
    public class ObjectStaticFactoryProperty extends ObjectProperty implements IObjectFactoryStrategy 
    {
        /**
         * Creates a new ObjectStaticFactoryProperty instance.
         * @param type The type of the static class use to create the object reference with a static property or constant.
         * @param name The name of the static property or constant to invoke to create the object "reference".
         * @param evaluators The Array representation of all evaluators who evaluate the value of the property.
         */
        public function ObjectStaticFactoryProperty(name:String, type:String , evaluators:Array = null)
        {
            super( name, null, null, evaluators );
            this.type = type ;
        }
        
        /**
         * The string representation of the type name of the static factory class.
         */
        public var type:String ;
        
        /**
         * Returns the ObjectStaticFactoryProperty representation of the specified generic object or null.
         * @return the ObjectStaticFactoryProperty representation of the specified generic object or null.
         */
        public static function build( o:Object=null ):ObjectStaticFactoryProperty
        {
            if ( o == null ) 
            {
                return null ;
            }
            if ( ObjectAttribute.TYPE in o && ObjectAttribute.NAME in o )
            {
                return new ObjectStaticFactoryProperty
                ( 
                    o[ ObjectAttribute.NAME       ] as String , 
                    o[ ObjectAttribute.TYPE       ] as String , 
                    o[ ObjectAttribute.EVALUATORS ] as Array 
                ) ;
            }
            else
            {
                return null ;
            }
        }
    }
}
