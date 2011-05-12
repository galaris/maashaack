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

package system.ioc 
{
    import system.formatters.ExpressionFormatter;
    
    /**
     * This object is an helper who contains type expressions and can format a type with all expression registered in the dictionnary.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.ioc.TypeExpression ;
     * 
     * var exp:TypeExpression = new TypeExpression() ;
     * 
     * exp.put( "package"            , "foo.bar.myPackage" ) ;
     * exp.put( "package.controller" , "{package}.controller" ) ;
     * 
     * var type:String = "{package.controller}.InitApplication" ;
     * 
     * var result:String = exp.format(type) ;
     * 
     * trace( "type:" + type + ", result:" + result ) ;
     * </pre>
     */
    public dynamic class TypeExpression extends ExpressionFormatter 
    {
        /**
         * Creates a new TypeExpression instance.
         * @param weakKeys Instructs the Dictionary object to use "weak" references on object keys. 
         * If the only reference to an object is in the specified Dictionary object, the key is eligible 
         * for garbage collection and is removed from the table when the object is collected.
         */
        public function TypeExpression( weakKeys:Boolean = false )
        {
            super( weakKeys );
        }
        
        /**
         * Inserts a new expression in the collector. If the expression already exist, the value in the collector is replaced.
         * @param alias The alias name, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @param value The value of the alias type, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</code> if the alias can be registered.
         */
        public function put( key:String , value:String ):Boolean
        {
            if ( key == null || value == null || key.length == 0  || value.length == 0 )
            {
                return false ;
            }
            this[key] = value ;
            return true ;
        }
    }
}
