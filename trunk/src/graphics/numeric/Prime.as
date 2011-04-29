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

package graphics.numeric 
{
    /**
     * Implements the static behaviours of the Prime Class.
     */
    public final class Prime 
    {
        /**
         * Defines an array of all primes between 'from' and 'n' inclusive, positive but restricted integer value, ignores decimals.
         * @return a array representation of all primes between <code class="prettyprint">from</code> and <code class="prettyprint">n</code> inclusive}
         */
        public static function findPrimeFrom( n:int , from:uint = 0  ):Array 
        {
            n    |= 0 ;
            from |= 0 ;
            var i:int ;
            var j:int ;
            var aOut:Array   = [] ;
            var aCount:Array = [] ;
            if (isNaN(from) ) 
            {
                from = 0 ;
            }
            else 
            {
                from -= 1 ;
            }
            n += 1 ;
            for (i=0 ; i<n; i++) 
            {
                aCount[i] = 0;
            }
            var sqrtN:Number = Math.round(Math.sqrt(n+1));
            var last:Number = 2 ;
            for (i=2 ; i<=sqrtN ;i++ ) 
            {
                if (aCount[i]==0) 
                {
                    for (j=last*i ; j<n ; j+=i ) 
                    {
                        aCount[j] = 1 ;
                    }
                    last = i ;
                }
            }
            for (i=n-1 ;i>from ; i--) 
            {
                if (aCount[i] == 0) 
                {
                    aOut.push(i);
                }
            }
            return aOut;
        }
        
        /**
         * Defines an array of all primes between 2 and 'n' inclusive.
         */
        public static function generatePrimes( limit:Number ):Array 
        {
            var a:Array = [] ;
            var i:int = 1 ;
            while (++i<=limit) 
            {
                if ( isPrime(i) ) 
                {
                    a.push(i) ;
                }
            }
            return a ;
        }
        
        /**
         * Boolean for 'isPrime' integer condition, ignores decimals.
         * Successive division.
         */
        public static function isPrime( n:int ):Boolean 
        { 
            if (n<3) 
            {
                return ( n == 2 ) ;
            }
            else if ((n%2) == 0) 
            {
                return false ;
            }
            var i:int = 3 ;
            while (i*i <= n) 
            {
                if ( (n%i) == 0 ) 
                {
                    return false ;
                }
                i+= 2 ;
            }
            return true ;
        }
        
        /**
         * Defines prime factors of 'n', positive but restricted integer value, ignores decimals.
         * @return a string representation of the multiplication of primes of 'n'.
         */
        public static function primeFactor(n:Number):String 
        {
            var bFlag:Boolean;
            n |= 0;
            if (n==1)
            {
                return "1";
            }
            var temp:Number    = n   ;
            var delim:String   = "*" ;
            var sFactor:String = ""  ;
            while (1) 
            {
                if (temp%2==0) 
                {
                    temp /= 2;
                    sFactor += 2+delim;
                }
                else 
                {
                    break;
                }
            }
            var num:Number = 3;
            while (1<temp) 
            {
                bFlag = true;
                while (bFlag) 
                {
                    if (temp%num==0) 
                    {
                        temp /= num;
                        sFactor += num+delim;
                    }
                    else 
                    {
                        bFlag = false;
                    }
                }
                num += 2;
            }
            return sFactor.substr(0,-1);
        }
        
        /**
         * Defines total of relative primes of 'n'.
         */
        public static function totient( n:Number ):Number 
        {
            var k:uint = 1;
            var j:uint;
            if (n%2==0)
            {
                j++ ;
            }
            for ( j=3 ; j<=n ; j+=2 ) 
            {
                if ( isPrime(j) ) 
                {
                    k++ ;
                }
            }
            return k;
        }
    }
}
