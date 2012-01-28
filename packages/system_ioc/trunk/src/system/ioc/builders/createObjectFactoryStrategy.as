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

package system.ioc.builders
{
    import system.ioc.ObjectAttribute ;
    import system.ioc.IObjectFactoryStrategy ;
    import system.ioc.strategies.ObjectFactoryReference;
    import system.ioc.strategies.ObjectFactoryValue;
    import system.ioc.strategies.ObjectStaticFactoryProperty;
    import system.ioc.strategies.ObjectFactoryProperty;
    import system.ioc.strategies.ObjectStaticFactoryMethod;
    import system.ioc.strategies.ObjectFactoryMethod;
    
    /**
     * This helper create an IObjectFactoryStrategy object with a generic object in the IoC context.
     * @return An IObjectFactoryStrategy object or null.
     */
    public const createObjectFactoryStrategy:Function = function( o:* ):IObjectFactoryStrategy
    {
        switch( true )
        {
            case ObjectAttribute.OBJECT_FACTORY_METHOD in o :
            {
                return ObjectFactoryMethod.build( o[ ObjectAttribute.OBJECT_FACTORY_METHOD ] ) ;
            }
            case ObjectAttribute.OBJECT_FACTORY_PROPERTY in o :
            {
                return ObjectFactoryProperty.build( o[ ObjectAttribute.OBJECT_FACTORY_PROPERTY ] ) ;
            }
            case ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD in o :
            {
                return ObjectStaticFactoryMethod.build( o[ ObjectAttribute.OBJECT_STATIC_FACTORY_METHOD ] ) ;
            }
            case ObjectAttribute.OBJECT_STATIC_FACTORY_PROPERTY in o :
            {
                return ObjectStaticFactoryProperty.build( o[ ObjectAttribute.OBJECT_STATIC_FACTORY_PROPERTY ] ) ;
            }
            case ObjectAttribute.OBJECT_FACTORY_VALUE in o :
            {
                return ObjectFactoryValue.build( o[ ObjectAttribute.OBJECT_FACTORY_VALUE ] ) ;
            }
            case ObjectAttribute.OBJECT_FACTORY_REFERENCE in o :
            {
                return ObjectFactoryReference.build( o[ ObjectAttribute.OBJECT_FACTORY_REFERENCE ] ) ;
            }
            default :
            {
                return null ;
            }
        }
    };
}
