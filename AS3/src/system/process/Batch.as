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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.process 
{
    import system.data.Iterator;
    import system.data.collections.ArrayCollection;
    import system.data.collections.TypedCollection;
    import system.process.Runnable;
    import system.process.Stoppable;    

    /**
     * A batch is a collection of <code class="prettyprint">Action</code> objects. All <code class="prettyprint">Action</code> objects are processed as a single unit.
     * <p>This class use an internal typed Collection to register all <code class="prettyprint">Action</code> objects.</p>  
     */
    public class Batch extends TypedCollection implements Runnable, Stoppable
    {
        
        /**
         * Creates a new Batch instance.
         */
        public function Batch()
        {
            super( Runnable, new ArrayCollection() ) ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():*
        {
            var b:Batch = new Batch() ;
            var it:Iterator = iterator() ;
            while (it.hasNext()) 
            {
                b.add(it.next()) ;
            }
            return b ;
        }
        
        /**
         * Runs the process.
         */
        public function run( ...arguments:Array ):void
        {
            var a:Array = toArray() ;
            var i:int   = -1 ;
            var l:int   = a.length ;
            if (l>0) 
            {
                while (++i < l) 
                { 
                    a[i].run() ; 
                }
            }
        }
        
        /**
         * Stops the tweened animation at its current position.
         * @return <code class="prettyprint">true</code> if one or more process in the batch is stopped (must be IStoppable).
         */
        public function stop( ...args:Array ):*
        {
            var b:Boolean ;
            var a:Array = toArray() ;
            var i:int   = -1 ;
            var l:int   = a.length ;
            if (l>0) 
            {
            	while (++i < l) 
                { 
                    if ( a[i] is Stoppable )
                    {
                        (a[i] as Stoppable).stop() ;
                        b = true ;
                    }
                } 
            }
            return b ;
        }
        
    }
}