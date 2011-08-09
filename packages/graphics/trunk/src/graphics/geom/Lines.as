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

package graphics.geom 
{
    /**
     * Static tool class to manipulate and transform <code class="prettyprint">Line</code> references.
     */
    public class Lines 
    {
        /**
         * Returns a Line reference defines with the two vectors in argument. 
         * This line is a line equation as two properties (a,b) such that (y = a*x + b) for any x or a unique c property such that (x = c) for all y.
         * The function takes two points as parameter, p0 and p1 containing two properties x and y.
         * @return a line equation as two properties (a,b) such that (y = a*x + b) for any x or a unique c property such that (x = c) for all y.
         */
        public static function getLine( p1:Vector2, p2:Vector2 ):Line 
        {
            var x0:Number = p1.x;
            var y0:Number = p1.y;
            var x1:Number = p2.x;
            var y1:Number = p2.y;
            var l:Line = new Line() ;
            if (x0 == x1) 
            {
                if (y0 == y1)
                {
                    l = null ;
                }
                else 
                {
                    l.c = x0 ; // Otherwise, the line is a vertical line
                }
            }
            else 
            {
                l.a = (y0 - y1) / (x0 - x1) ;
                l.b = y0 - (l.a * x0) ;
            }
            return l ;
        }
        
        /**
         * Returns a point (x,y) that is the intersection of two lines.
         * A line is defined either by a and b parameters such that (y = a*x + b) for any x or 
         * a single parameter c such that (x = c) for all y.
         * @return a vector (x,y) that is the intersection of two lines.
         */
        public static function getLineCross( l1:Line , l2:Line ):Vector2
        {
            if ( l1 == null || l2 == null )
            {
                return null ;
            }
            var a0:Number = l1.a ;
            var b0:Number = l1.b ;
            var c0:Number = l1.c ;
            var a1:Number = l2.a ;
            var b1:Number = l2.b ;
            var c1:Number = l2.c ;
            var u:Number ;
            if ( !c0 && !c1 )
            {
                if (a0 == a1)
                {
                    return null ;
                } 
                u = (b1 - b0) / (a0 - a1) ;
                return new Vector2( u , a0 * u + b0 ) ;
            } 
            else 
            {
                if (c0) 
                {
                    if (c1) 
                    {    
                        return null ;
                    }
                    else 
                    {
                        return new Vector2 (c0, (a1*c0)+b1) ;
                    }
                } 
                else if (c1) 
                {
                    return new Vector2(c1, (a0*c1) + b0) ;
                }
                else
                {
                    return null ;
                }
            }
        }
        
        /**
         * Returns a point on a segment [p1, p2] which distance from p1 is ratio of the length [p1, p2].
         * @return a point on a segment [p1, p2] which distance from p1 is ratio of the length [p1, p2].
         */
        public static function getPointOnSegment(p1:Vector2, p2:Vector2, ratio:Number):Vector2 
        {
            return new Vector2( p1.x + ((p2.x - p1.x) * ratio) , p1.y + ((p2.y - p1.y) * ratio) ) ;
        }
        
        /**
         * Returns a line equation as two properties (a,b) such that (y = a*x + b) for any x or a unique c property such that (x = c) for all y.
         * The function takes two parameters, a point p(x,y) through which the line passes and a direction vector v(x,y).
         * @return a line equation as two properties (a,b) such that (y = a*x + b) for any x.
         */
        public static function getVectorLine(p:Vector2, v:Vector2):Line 
        {
            var l:Line = new Line() ;
            var x:Number  = p.x ;
            var vx:Number = v.x ;
            if (vx == 0) 
            {
                l.c = x ;
            }
            else 
            {
                l.a = v.y / vx ;
                l.b = p.y - (l.a * x);
            }
            return l ;
        }
    }
}
