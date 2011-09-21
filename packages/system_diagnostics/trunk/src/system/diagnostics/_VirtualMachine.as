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

package system.diagnostics
{
    import core.strings.startsWith;
    
    import system.terminals.InteractiveConsole;
    import system.terminals.console;
    
    import flash.system.Capabilities;
    import flash.system.System;
    import flash.trace.Trace;
    import flash.utils.getDefinitionByName;
    
    /**
     * The internal VirtualMachine class.
     */
    public class _VirtualMachine
    {
        /**
         * @private
         */
        private var _tracing:Boolean = false;
        
        /**
         * @private
         */
        private var _writer:InteractiveConsole = console;
        
        /**
         * @private
         */
        private function _filterBuiltin( str:String, beginWith:String, replaceWith:String ):String
        {
            if( startsWith( str, beginWith ) )
            {
                str = str.split( beginWith ).join( replaceWith );
            }
            
            return str;
        }
        
        /**
         * @private
         */
        private function _forceMarkSweep():void
        {
            try
            {
                var LCclass:Class = getDefinitionByName( "flash.net::LocalConnection" ) as Class ;
                var lc1:* = new LCclass( );
                var lc2:* = new LCclass( );
                lc1.connect( "force_garbage_collection" );
                lc2.connect( "force_garbage_collection" );
            }
            catch( e:* )
            {
                //nothing
            }
        }
        
        /**
         * Indicates if the machine filter the methods.
         */
        public var filterMethods:Boolean = true;
        
        /**
         * Indicates the list of the filtered methods.
         */
        public var filteredMethods:Array = [ "flash.trace::Trace$/setLevel",
                                             "system.diagnostics::_VirtualMachine/beginTrace" ,
                                             "system.diagnostics::_VirtualMachine/endTrace" ] ;
        
        /**
         * Indicates the formatter pattern.
         */
        public var formatter:String = "  * {method}({args})";
        
        /**
         * Indicates if show the packages.
         */
        public var showPackages:Boolean = true;
        
        /**
         * Creates a new VirtualMachine instance.
         * @param listener The callback listener function use to dispatch the messages.
         */
        public function _VirtualMachine( listener:Function = null )
        {
            if( listener == null )
            {
                Trace.setListener( traceListener );
            }
            else
            {
                Trace.setListener( listener );
            }
        }
        
        /**
         * The Virtual Machine version
         */
        public function get version():String
        {
            return System.vmVersion;
        }
        
        /**
         * Force the garbage collection on the Virtual Machine
         */
        public function garbageCollection():void
        {
            if( Capabilities.isDebugger )
            {
                System.gc( );
            }
            else
            {
                _forceMarkSweep( );
            }
        }
        
        /**
         * Indicates if we are tracing.
         */
        public function isTracing():Boolean
        {
            return _tracing;
        }
        
        /**
         * Trace the messages in the console.
         */
        public function traceListener( line:String, index:int, method:String, args:String ):void
        {
            if( filterMethods )
            {
                var i:int;
                var len:int = filteredMethods.length;
                for( i = 0; i < len ; i++ )
                {
                    if( filteredMethods[i] == method )
                    {
                        return;
                    }
                }
            }
            
            method = _filterBuiltin( method, "String/http://adobe.com/AS3/2006/builtin::", "String/" );
            method = _filterBuiltin( method, "Array/http://adobe.com/AS3/2006/builtin::", "Array/" );
            
            if( ! showPackages && (method.indexOf( "::" ) > - 1) )
            {
                method = method.split( "::" )[1];
            }
            
            /* TODO:
            Strings.format is too slow to parse the flow of data from Trace
            and make the flash player crash
            define a special really fast Strings.format using a namespace ?
             */
            //public::trace( Strings.format( formatter, {line:line,index:index,method:method,args:args} ) );
            //_writer.writeLine( formatter, {line:line,index:index,method:method,args:args} );
            _writer.writeLine( method + "(" + args + ")" );
        }
        
        /**
         * Insert in the console the header (begin trace).
         */
        public function beginTrace():void
        {
            _tracing = true;
            _writer.writeLine( "------------------------------------------------------" );
            Trace.setLevel( Trace.METHODS_WITH_ARGS, Trace.LISTENER );
        }
        
        /**
         * Insert in the console the footer (begin trace).
         */
        public function endTrace():void
        {
            Trace.setLevel( Trace.OFF, Trace.LISTENER );
            _writer.writeLine( "------------------------------------------------------" );
            _tracing = false;
        }
    }
}
