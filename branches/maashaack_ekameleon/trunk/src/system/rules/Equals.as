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
package system.rules
{
    import system.Equatable;
    /**
     * Used to perform a logical conjunction on two conditions and more.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.rules.BooleanRule ;
     * import system.rules.Equals ;
     * import system.rules.Rule ;
     * 
     * var e:Equals ;
     * 
     * ///// Compares objects.
     * 
     * e = new Equals( 1 , 1 ) ;
     * trace( e.eval() ) ; // true
     * 
     * e = new Equals( 1 , 2 ) ;
     * trace( e.eval() ) ; // false
     * 
     * ///// Compares Rule objects.
     * 
     * var cond1:Rule = new BooleanRule( true  ) ;
     * var cond2:Rule = new BooleanRule( false ) ;
     * var cond3:Rule = new BooleanRule( true  ) ;
     * 
     * e = new Equals( cond1 , cond1 ) ;
     * trace( e.eval() ) ; // true
     * 
     * e = new Equals( cond1 , cond2 ) ;
     * trace( e.eval() ) ; // false
     * 
     * e = new Equals( cond1 , cond3 ) ;
     * trace( e.eval() ) ; // true
     * 
     * ///// Compares Equatable objects.
     * 
     * var equals:Function = function( o:Object ):Boolean
     * {
     *     return this.id == o.id ;
     * }
     * 
     * var o1:Object = { id:1 , equals:equals } ;
     * var o2:Object = { id:2 , equals:equals } ;
     * var o3:Object = { id:1 , equals:equals } ;
     * 
     * e = new Equals( o1 , o1 ) ;
     * trace( e.eval() ) ; // true
     * 
     * e = new Equals( o1 , o2 ) ;
     * trace( e.eval() ) ; // false
     * 
     * e = new Equals( o1 , o3 ) ;
     * trace( e.eval() ) ; // true
     * </code>
     * </listing>
     */
    public class Equals implements Rule
    {
        /**
         * Creates a new Equals instance.
         * @param value1 The first value to evaluate.
         * @param value1 The second value to evaluate.
         */
        public function Equals( value1:* = null , value2:* = null )
        {
            this.value1 = value1 ;
            this.value2 = value2 ;
        }
        
        /**
         * The first value to evaluate.
         */
        public var value1:* ;
        
        /**
         * The second value to evaluate.
         */
        public var value2:* ;
        
        /**
         * Evaluates the specified condition.
         */
        public function eval():Boolean
        {
            if ( value1 == value2 )
            {
                return true ;
            }
            else if ( (value1 is Rule) && (value2 is Rule) )
            {
                return (value1 as Rule).eval() == (value2 as Rule).eval() ;
            }
            else if ( value1 is Equatable )
            {
                return (value1 as Equatable).equals( value2 ) ;
            }
            else if( ( "equals" in value1 ) && ( value1["equals"] is Function ) )
            {
                return value1["equals"]( value2 ) ;
            }
            else
            {
                return false ;
            }
        }
    }
}
