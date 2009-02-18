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
     * This class use an internal typed <code class="prettyprint">SimpleCollection</code> to register all <code class="prettyprint">Action</code> objects.  
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageAlign ;
     * import flash.display.StageScaleMode ;
     * 
     * import system.events.ActionEvent ;
     * import system.process.Batch ;
     * 
     * import pegas.transitions.easing.Back ;
     * import pegas.transitions.easing.Bounce ;
     * import pegas.transitions.easing.Elastic ;
     * import pegas.transitions.Tween ;
     * 
     * Stage.align     = StageAlign.TOP_LEFT ;
     * Stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var batch:Batch = new Batch();
     * 
     * var change:Function = function( e:ActionEvent ):void
     * {
     *     if ( e.target is Tween )
     *     {
     *         var tw:Tween = e.target as Tween ;
     *         var display:Shape = (tw.target as Shape) ;
     *         display.scaleY  = display.scaleX ;
     *     }
     * }
     * 
     * var max:int = 50 ;
     * for ( var i:int = 0; i < max ; i++ )
     * {
     *     var rec:Shape = addChild( new Shape() ) ;
     *     rec.x = Math.random()*740 ;
     *     rec.y = Math.random()*400 ;
     *     rec.graphics.beginFill( Math.round( Math.random() * 0xFFFFFF ) , 1) ;
     *     rec.graphics.drawRect(0,0,20,20) ;
     *     rec.filters = [ new BlurFilter( Math.random() * 12 , Math.random() * 12 , 2 ) ] ;
     *     
     *     var tw:Tween = new Tween( rec ) ;
     *     tw.addEventListener( ActionEvent.CHANGE , change , false, 0, true ) ;
     *     tw.duration = 10 + Math.round( Math.random() * 24 ) ;
     *     tw.insertProperty( "x"      , Bounce.easeOut  , rec.x      , Math.random() * 740 ) ;
     *     tw.insertProperty( "y"      , Back.easeOut    , rec.y      , Math.random() * 400 ) ;
     *     tw.insertProperty( "scaleX" , Elastic.easeOut , rec.scaleX , Math.random() ) ;
     *     tw.insertProperty( "scaleY" , Back.easeOut    , rec.scaleY , Math.random() ) ;
     *     
     *     batch.insert( tw );
     *     
     * }
     * 
     * trace ("Press a key or your mouse to run the process...") ;
     * 
     * var run:Function = function ( e:Event ):void
     * {
     *     batch.run() ;
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , run ) ;
     * stage.addEventListener( MouseEvent.MOUSE_DOWN  , run ) ;
     * </pre>
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
            var ar:Array = toArray() ;
            var i:Number = -1 ;
            var l:Number = ar.length ;
            if (l>0) while (++i < l) 
            { 
                ar[i].run() ; 
            }
        }
        
        /**
         * Stops the tweened animation at its current position.
         * @return <code class="prettyprint">true</code> if one or more process in the batch is stopped (must be IStoppable).
         */
        public function stop( ...args:Array ):*
        {
        	var b:Boolean ;
            var ar:Array = toArray() ;
            var i:Number = -1 ;
            var l:Number = ar.length ;
            if (l>0) while (++i < l) 
            { 
            	if ( ar[i] is Stoppable )
            	{
                    (ar[i] as Stoppable).stop() ;
                    b = true ;
            	} 
            }
            return b ;
        }        
        
    }
}