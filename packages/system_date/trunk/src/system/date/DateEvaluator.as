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
package system.date 
{
    import system.Evaluable;
    
    /**
     * Evaluates Date object and transform it in string expressions.
     * <p>All characters from 'A' to 'Z' and from 'a' to 'z' are reserved, although not all of these characters are interpreted right now.</p> 
     * <p>If you want to include plain text in the pattern put it into quotes (') to avoid interpretation.</p>
     * <p>If you want a quote in the formatted date-time, put two quotes directly after one another.</p>
     * <p>For example: <code class="prettyprint"> "hh 'o''clock'"</code></p>
     * <pre class="prettyprint">
     * import system.evaluators.DateEvaluator ;
     * 
     * var evaluator:DateEvaluator = new DateEvaluator() ;
     * 
     * evaluator.pattern = "DDDD d MMMM yyyy" ;
     * trace( evaluator.eval( new Date(2008,1,21,10,15,0,0) ) ) ;
     * 
     * evaluator.pattern = "hh 'h' nn 'mn' ss 's' tt" ;
     * trace( evaluator.eval( new Date(2008,1,21,10,15,0,0) ) ) ; // 02 h 15 mn 00 s am
     * 
     * evaluator.pattern = "hh 'h' nn 'mn' ss 's' t" ;
     * trace( evaluator.eval( new Date(2008,1,21,10,15,0,0) ) ) ; // 02 h 15 mn 00 s a
     * 
     * evaluator.pattern = "hh 'h' nn 'mn' ss 's' TT" ; // capitalize the pm expression.
     * trace( evaluator.eval( new Date(2008,1,21,14,15,0,0) ) ) ; // 02 h 15 mn 00 s PM
     * </pre>
     */
    public class DateEvaluator implements Evaluable 
    {
        /**
         * @private
         */
        private var _formatter:DateFormatter ;
        
        /**
         * Creates a new DateEvaluator instance.
         * @param pattern (optional) the pattern describing the date and time format.
         */
        public function DateEvaluator( pattern:String = "dd.mm.yyyy HH:nn:ss" )
        {
            _formatter = new DateFormatter( ) ; 
            if ( pattern != null )
            {
                _formatter.pattern = pattern ;
            }
        }
        
        /**
         * Indicates the internal pattern of this formatter.
         */
        public function get pattern():String 
        {
            return _formatter.pattern ;
        }
        
        /**
         * @private
         */
        public function set pattern( expression:String ):void 
        {
            _formatter.pattern = expression ;
        }
        
        /**
         * Evaluates the specified object.
         */
        public function eval(o:*):*
        {
            return _formatter.format( o ) ;
        }
    }
}
