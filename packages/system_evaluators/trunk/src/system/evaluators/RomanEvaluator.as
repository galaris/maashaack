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

package system.evaluators 
{
    import system.Evaluable;
    import system.numeric.RomanNumber;
    
    /**
     * Evaluates an int value and transform it in roman numeral expression.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * RomanEvaluator =  system.evaluators.RomanEvaluator ;
     * 
     * var evaluator = new RomanEvaluator() ;
     * 
     * trace( evaluator.eval( 1 ) ) ; // I
     * trace( evaluator.eval( 2 ) ) ; // II
     * trace( evaluator.eval( 3 ) ) ; // III
     * trace( evaluator.eval( 4 ) ) ; // IV
     * trace( evaluator.eval( 5 ) ) ; // V
     * trace( evaluator.eval( 9 ) ) ; // IX
     * trace( evaluator.eval( 10 ) ) ; // X 
     * trace( evaluator.eval( 50 ) ) ; // L 
     * trace( evaluator.eval( 2459 ) ) ; // MMCDLIX
     * trace( evaluator.eval( 3999 ) ) ;  // MMMCMXCIX
     * 
     * // roman string to number
     * 
     * trace( evaluator.eval( "I" ) ) ; // 1
     * trace( evaluator.eval( "II" ) ) ; // 2
     * trace( evaluator.eval( "III" ) ) ; // 3
     * trace( evaluator.eval( "IV" ) ) ; // 4
     * trace( evaluator.eval( "V" ) ) ; // 5
     * trace( evaluator.eval( "IX" ) ) ; // 9
     * trace( evaluator.eval( "X" ) ) ; // 10
     * trace( evaluator.eval( "L" ) ) ; // 50
     * trace( evaluator.eval( "MMCDLIX" ) ) ; // 2459
     * trace( evaluator.eval( "MMMCMXCIX" ) ) ; // 3999
     * 
     * try
     * {
     *     evaluator.eval( 4000 ) ;
     * }
     * catch( e )
     * {
     *     trace( e.message ) ;  // Max value for a RomanNumber is 3999
     * }
     * 
     * try
     * {
     *     evaluator.eval( -1 ) ;
     * }
     * catch( e )
     * {
     *     trace( e.message ) ; // Min value for a RomanNumber is 0
     * }
     * </pre>
     */
    public class RomanEvaluator implements Evaluable 
    {
        /**
         * Creates a new RomanEvaluator instance.
         */
        public function RomanEvaluator()
        {
            //
        }
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if( o is String )
            {
               return RomanNumber.parseRomanString( o );
            }
            else if ( o is Number )
            {
                return RomanNumber.parse( o ); 
            }
            else
            {
                return null ;
            }
        }
    }
}
