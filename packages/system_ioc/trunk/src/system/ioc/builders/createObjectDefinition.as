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
    import system.ioc.ObjectDefinition ;
    
    /**
     * Creates a new ObjectDefinition instance and populated it with the specified init object in argument.
     * @param o A generic object to populate the new ObjectDefinition instance.
     * @return A ObjectDefinition instance.
     */
    public const createObjectDefinition:Function = function( o:* ):ObjectDefinition
    {
        var definition:ObjectDefinition = new ObjectDefinition
        ( 
            o[ ObjectAttribute.OBJECT_ID ]        as String  , 
            o[ ObjectAttribute.TYPE ]             as String  , 
            o[ ObjectAttribute.OBJECT_SINGLETON ] as Boolean , 
            o[ ObjectAttribute.LAZY_INIT ]        as Boolean 
        ) ;
        
        definition.identify = o[ ObjectAttribute.IDENTIFY ] as Boolean  ;
        definition.lock     = o[ ObjectAttribute.LOCK ]     as Boolean  ;
        
        definition.setFactoryStrategy      ( createObjectFactoryStrategy( o ) ) ;
        
        definition.setConstructorArguments ( createArguments( o[ ObjectAttribute.ARGUMENTS  ] as Array ) ) ;
        definition.setListeners            ( createListeners( o ) ) ;
        definition.setProperties           ( createProperties( o ) ) ;
        definition.setReceivers            ( createReceivers( o ) ) ;
        
        definition.setDestroyMethodName    ( o[ ObjectAttribute.OBJECT_DESTROY_METHOD_NAME ] as String ) ;
        definition.setInitMethodName       ( o[ ObjectAttribute.OBJECT_INIT_METHOD_NAME    ] as String ) ;
        definition.setScope                ( o[ ObjectAttribute.OBJECT_SCOPE               ] as String ) ;
        
        definition.setDependsOn( o[ ObjectAttribute.OBJECT_DEPENDS_ON ] as Array ) ;
        definition.setGenerates( o[ ObjectAttribute.OBJECT_GENERATES  ] as Array ) ;
        
        return definition ;
    };
}
