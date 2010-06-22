/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package flash.utils
{
    import flash.errors.*;

    /**
     * The Proxy class lets you override the default behavior of ActionScript operations
     * (such as retrieving and modifying properties) on an object.
     * 
     * <p>
     * The Proxy class has no constructor, and you should not attempt to instantiate Proxy.
     * Instead, subclass the Proxy class to override methods such as <code>getProperty</code>
     * and provide custom behavior.
     * If you try to use a method of the Proxy class without overriding the method, an exception is thrown.
     * </p>
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Proxy
    {

        flash_proxy function getProperty( name:* ):*
        {
            CFG::dbg{ trace( "Proxy.getProperty( " + name + " )" ); }
            Error.throwError( IllegalOperationError, 2088 );
            return null;
        }
        
        flash_proxy function setProperty( name:*, value:* ):void
        {
            CFG::dbg{ trace( "Proxy.setProperty( " + [name,value].join(", ") + " )" ); }
            Error.throwError( IllegalOperationError, 2089 );
        }
        
        flash_proxy function callProperty( name:*, ...rest ):*
        {
            CFG::dbg{ trace( "Proxy.callProperty( " + [name,rest].join(", ") + " )" ); }
            Error.throwError( IllegalOperationError, 2090 );
            return null;
        }
        
        flash_proxy function hasProperty( name:* ):Boolean
        {
            CFG::dbg{ trace( "Proxy.hasProperty( " + name + " )" ); }
            Error.throwError( IllegalOperationError, 2091 );
            return null;
        }
        
        flash_proxy function deleteProperty( name:* ):Boolean
        {
            CFG::dbg{ trace( "Proxy.deleteProperty( " + name + " )" ); }
            Error.throwError( IllegalOperationError, 2092 );
            return null;
        }
        
        flash_proxy function getDescendants( name:* ):*
        {
            CFG::dbg{ trace( "Proxy.getDescendants( " + name + " )" ); }
            Error.throwError( IllegalOperationError, 2093 );
            return null;
        }
        
        flash_proxy function nextNameIndex( index:int ):int
        {
            CFG::dbg{ trace( "Proxy.nextNameIndex( " + index + " )" ); }
            Error.throwError( IllegalOperationError, 2105 );
            return null;
        }
        
        flash_proxy function nextName( index:int ):String
        {
            CFG::dbg{ trace( "Proxy.nextName( " + index + " )" ); }
            Error.throwError( IllegalOperationError, 2106 );
            return null;
        }
        
        flash_proxy function nextValue( index:int ):*
        {
            CFG::dbg{ trace( "Proxy.nextValue( " + index + " )" ); }
            Error.throwError( IllegalOperationError, 2107 );
            return null;
        }
        
        //flash_proxy native function isAttribute( name:* ):Boolean;
        flash_proxy function isAttribute( name:* ):Boolean
        {
            CFG::dbg{ trace( "Proxy.isAttribute( " + name + " )" ); }
            //TODO
            return false;
        }
        
    }
}
