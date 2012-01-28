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

package core
{
    /**
     * Dumps a string representation of any object reference.
     * <p>Works like the <code>eden.serialize()</code> function and supports the <code>toSource()</code> method.</p>
     * @example basic usage
     * <listing version="3.0">
     * <pre class="prettyprint">
     * var test0:Object = { a:1, b:2, c:null, d:undefined, e:[1,2,3], f:"hello world", g:new Date() };
     * 
     * trace( dump( test0 ) );
     * 
     * //output
     * //{a:1,b:2,c:null,d:undefined,e:[1,2,3],f:"hello world",g:new Date(2010,4,3,20,35,7,860)}
     * 
     * trace( dump( test0, true ) );
     * 
     * //output
     * // {
     * //     a:1,
     * //     b:2,
     * //     c:null,
     * //     d:undefined,
     * //     e:
     * //     [
     * //         1,
     * //         2,
     * //         3
     * //     ],
     * //     f:"hello world",
     * //     g:new Date(2010,4,3,20,35,7,860)
     * // }
     * 
     * </pre>
     * </listing>
     * @param o an object reference
     * @param prettyprint (optional) boolean option to output a pretty printed string
     * @param indent (optional) initial indentation
     * @param indentor (optional) initial string used for the indent
     */
    public const dump:Function = function( o:*, prettyprint:Boolean = false, indent:int = 0, indentor:String = "    " ):String
    {
        if( o === undefined ) 
        {
            return "undefined"; 
        }
        else if( o === null ) 
        { 
            return "null"; 
        }
        else if( "toSource" in o ) 
        { 
            return o.toSource( indent ); 
        }
        else if( o is String ) 
        { 
            return dumpString( o ); 
        }
        else if ( o is Boolean ) 
        { 
            return o ? "true" : "false"; 
        }
        else if( o is Number ) 
        { 
            return o.toString() ; 
        }
        else if( o is Date ) 
        { 
            return dumpDate( o ); 
        }
        else if( o is Array ) 
        { 
            return dumpArray( o , prettyprint, indent, indentor ); 
        }
        else if( o is Object ) 
        { 
            return dumpObject( o , prettyprint, indent, indentor ); 
        }
        else
        {
            return "<unknown>";
        }
    };
    
}