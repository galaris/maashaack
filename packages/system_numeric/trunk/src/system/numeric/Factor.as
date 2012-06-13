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

package system.numeric 
{
    /**
     * Implements the static behaviours of the Factor Class.
     */
    public final class Factor 
    {
        /**
         * Returns the factorial of a positive integer.
         * @param n The value to use to calculate the factorial product.
         * @return the factorial of a positive integer.
         */
        public static function factorial( n:uint ):uint 
        {
            if ( n == 0 ) 
            {
                return 1 ;
            }
            else 
            {
                var result:uint = n ;
                while (--n > 1)
                {
                    result *= n ;
                    if ( result == Number.POSITIVE_INFINITY ) 
                    {
                        return Infinity ;
                    }
                }
                return result;
            }
        }
        
        /**
         * Uses the Gamma function to approximate factorial - very fast.
         */
        public static function factorialApprox( n:Number ):Number 
        {
            return Math.round( Factor.gammaApprox(n+1) ) ;
        }
        
        /**
         * Extends the domain of the factorial function by calculating the factorial of decimal numbers.
         */
        public static function gammaApprox(n:Number):Number 
        {
            var x:Number = n - 1 ;
            return Math.sqrt( (2*x+1/3) * Math.PI ) * Math.pow(x,x) * Math.exp(-x) ;
        }
        
        /**
         * Defines the inverse of a number.
         */
        public static function inverse(n:Number):Number 
        {
            return 1/n ;
        }
        
        /**
         * Defines the logarithm with base 'a' of 'n'.
         * @param a :Number a real number for 'log base'.
         * @param n :Number a real number.
         * @return returns the logarithm with base 'a' of 'n'.
         */
        public static function logA(a:Number, n:Number):Number 
        {
            return Math.log(n) / Math.log(a) ;
        }
        
        /**
         * Defines the nth root of a number.
         */
        public static function nRoot( a:Number , n:Number ):Number 
        {
            return Factor.pow(a, 1/n) ;
        }
        
        /**
         * Solves the negative value input bug.
         */
        public static function pow( a:Number , n:Number ):Number 
        {
            return a==0 ? 0 : (a>0 ? Math.pow(a,n) : Math.pow(a*-1,n)*-1) ;
        }
        
        /**
         * Calculates the product of factors of 'n'.
         */
        public static function productFactors( n:Number ):Number 
        {
            var k:uint = 1 ;
            for ( var i:int=3 ; i<=n ; i+=2 ) 
            {
                if (Prime.isPrime(i)) 
                {
                    k *= i ;
                }
            }
            if (n>2) 
            {
                k *= 2;
            }
            return k;
        }
        
        /**
         * Defines the square value of a number.
         */
        public static function square(n:Number):Number 
        {    
            return n*n ;
        }
        
        /**
         * Defines the sum of all the numbers between 1 and 'n' raised to the 'x' power.
         */
        public static function summation(n:Number, x:Number):Number 
        {    
            var sum:Number = 0 ;
            for (var i:Number = 1; i<=n; i++) 
            {
                sum += Math.pow(i, x) ;
            }
            return sum ;
        }
    }
}
