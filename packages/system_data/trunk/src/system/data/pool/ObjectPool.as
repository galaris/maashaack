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
  Portions created by the Initial Developers are Copyright (C) 2006-2013
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

package system.data.pool 
{
    /**
     * This class implements the object pool design pattern implementation.
     * 
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.data.pool.ObjectPool ;
     * 
     * import examples.pool.MyBuilder ;
     * import examples.pool.MyClass ;
     * 
     * var i:int;
     * 
     * var pool:ObjectPool = new ObjectPool() ;
     * 
     * pool.allocate( 10 , MyClass , ["hello label"] ) ;
     * 
     * pool.apply( "init", ["arg1", "arg2"] ) ;
     * 
     * var activeObjects:Array = [] ;
     * 
     * //read the first object
     * 
     * activeObjects[0] = pool.get() ;
     * 
     * var k:int = pool.wasteCount ;
     * 
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 9
     * 
     * for ( i = 0 ; i &lt; k ; i++ )
     * {
     *     activeObjects.push( pool.get() ) ; // read the remaining 9 objects
     * }
     * 
     * // wasteCount is now zero, but usageCount reports 10.
     * 
     * trace("pool.usageCount : " + pool.usageCount) ;
     * 
     * try
     * {
     *     //this will fail because the pool is now empty
     *     activeObjects.push( pool.get() );
     * }
     * catch (e:Error)
     * {
     *     trace(e);
     * }
     * 
     * k = pool.size ;
     * 
     * // give all objects back to the pool
     * 
     * for (i = 0; i &lt; k; i++)
     * {
     *     pool.dispose( activeObjects.shift() ) ;
     * }
     * 
     * // usage count is zero
     * 
     * trace( pool.usageCount ) ;
     * 
     * trace( "======= use grow property" ) ;
     * 
     * pool.grow = true ;
     * 
     * pool.get() ; // create a new object and the pool is growing witn 10 new objects inside the buffer.
     * 
     * trace("pool.usageCount : " + pool.usageCount) ; // 1
     * 
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 9
     * 
     * trace( "======= use destroy method" ) ;
     * 
     * pool.destroy() ;
     * 
     * trace("pool.usageCount : " + pool.usageCount) ; // 0
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 0
     * 
     * trace( "======= Assign a custom object factory, see the test.pool.MyBuilder class") ;
     * 
     * pool.builder = new MyBuilder();
     * 
     * pool.allocate( 20 ) ;
     * 
     * trace( pool.object ) ;
     * 
     * trace("pool.usageCount : " + pool.usageCount) ; // 1
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 19
     * </code>
     * </listing>
     */
    public class ObjectPool 
    {
        /**
         * Creates a new ObjectPool instance.
         * @param grow Indicates if the pool of objects is auto growing when a new user is called with the "object" property.
         * @param builder the builder responsible for creating all pool objects. 
         */
        public function ObjectPool( growing:Boolean = false , builder:ObjectPoolBuilder = null )
        {
            this.growing = growing ;
            this.builder = builder ;
        }
        
        /**
         * Defines the builder responsible for creating all pool objects. 
         * If you don't want to use a factory, you must provide a class to the allocate method instead.
         * @see #allocate
         */
        public var builder:ObjectPoolBuilder ;
        
        /**
         * Indicates if the pool of objects is auto growing when a new user is called with the "object" property.
         */
        public var growing:Boolean ;
        
        /**
         * Indicates the pool size.
         */
        public function get length():int
        {
            return _currSize;
        }
        
        /**
         * The optional Array representation of parameters to send in the ObjectPoolBuilder.build() method use in the pool to create all objects. 
         */
        public var parameters:Array ;
        
        /**
         * Indicates the total number of 'checked out' objects currently in use.
         */
        public function get usageCount():int
        {
            return _usageCount;
        }
        
        /**
         * The total number of unused thus wasted objects. Use the purge() method to compact the pool.
         * @see #purge
         */
        public function get wasteCount():int
        {
            return _currSize - _usageCount; 
        }
        
        /**
         * Allocates the pool by creating all objects from the builder. 
         * @param clazz The class to create for each object node in the pool.
         * @param size The number of objects to create.
         * @param parameters The optional Array representation of parameters to send in the ObjectPoolBuilder.build() method use in this method to create all pooling objects. 
         * This overwrites the current factory.
         */
        public function allocate( size:uint = 1 , clazz:Class = null, parameters:Array=null ):void
        {
            destroy();
            
            if ( parameters != null )
            {
                this.parameters = parameters ;
            }
            
            if ( clazz )
            {
                builder = new ObjectBuilder( clazz );
            }
            else
            {
                if ( !builder )
                {
                    throw new Error( this + " allocate failed, nothing to instantiate.");
                }
            } 
            
            _initSize = _currSize = size;
            
            _head      = _tail = new ObjectPoolNode();
            _head.data = builder.build.apply( builder , this.parameters ) ;
            
            var n:ObjectPoolNode;
            
            for ( var i:int = 1 ; i < _initSize ; i++ )
            {
                n      = new ObjectPoolNode() ;
                n.data = builder.build.apply(builder, this.parameters) ;
                n.next = _head ;
                _head  = n ;
            }
            
            _empty     = _allocate = _head ;
            _tail.next = _head;
        }
        
        /**
         * Helper method for applying a function to all objects in the pool.
         * @param name The name of the method invoked to initialize all objects in the pool.
         * @param args The Array representation of all arguments of the init method.
         */
        public function apply( name:String , args:Array ):void
        {
            var n:ObjectPoolNode = _head ;
            while (n)
            {
                if ( name in n.data && n.data[ name ] is Function )
                {
                    n.data[ name ].apply( n.data, args ) ;
                }
                if ( n == _tail ) 
                {
                    break ;
                }
                n = n.next ; 
            }
        }
        
        /**
         * Destroy and unlock all ressources for the garbage collector.
         */
        public function destroy():void
        {
            var tmp:ObjectPoolNode ;
            var cur:ObjectPoolNode = _head ;
            while (cur)
            {
                tmp      = cur.next ;
                cur.next = null ;
                cur.data = null ;
                cur      = tmp ;
            }
            _head      = _tail     = _empty      = _allocate = null ;
            _initSize  = _currSize = _usageCount = 0 ;
            parameters = null ;
        }
        
        /**
         * Puts it back for the next use the specified object.
         */
        public function dispose( o:* ):void
        {
            if ( _usageCount > 0 )
            {
                _usageCount-- ;
                _empty.data = o ;
                _empty      = _empty.next;
            }
        }
        
        /**
         * Removes all unused objects from the pool. 
         * If the number of remaining used objects is smaller than the initial capacity defined by the allocate() method, 
         * new objects are created to refill the pool. 
         */
        public function flush():void
        {
            var i:int ;
            var node:ObjectPoolNode ;
            
            if (_usageCount == 0)
            {
                if ( _currSize == _initSize )
                {
                    return ;
                }   
                if (_currSize > _initSize)
                {
                    i = 0; 
                    node = _head;
                    while (++i < _initSize)
                    {
                        node = node.next;   
                    }
                    _tail     = node ;
                    _allocate = _empty = _head ;
                    _currSize = _initSize;
                    return; 
                }
            }
            else
            {
                var nodes:Vector.<ObjectPoolNode> = new Vector.<ObjectPoolNode>;
                
                node = _head ;
                
                while (node)
                {
                    if (!node.data) 
                    {
                        nodes[int(i++)] = node ;
                    }
                    if (node == _tail) 
                    {
                        break;
                    }
                    node = node.next ;
                }
                
                _currSize = nodes.length;
                _usageCount = _currSize;
                _head = _tail = nodes[0];
                
                for (i = 1; i < _currSize; i++)
                {
                    node = nodes[i];
                    node.next = _head;
                    _head = node;
                }
                
                _empty     = _allocate = _head ;
                _tail.next = _head;
                
                if (_usageCount < _initSize)
                {
                    _currSize = _initSize;
                    
                    var n:ObjectPoolNode = _tail ;
                    var t:ObjectPoolNode = _tail ;
                    var k:int = _initSize - _usageCount ;
                    for ( i = 0 ; i < k ; i++ )
                    {
                        node      = new ObjectPoolNode();
                        node.data = builder.build.apply(builder, parameters) ;
                        t.next    = node ;
                        t         = node ; 
                    }
                    _tail      = t ;
                    _tail.next = _empty = _head ;
                    _allocate  = n.next ;
                }
            }
        }
        
        /**
         * Returns the next available object from the pool. 
         * @throws Error If the pool is empty and resizable, an error is thrown.
         */
        public function get():*
        {
            if ( _usageCount == _currSize )
            {
                if ( growing )
                {
                    _currSize += _initSize ;
                    
                    var n:ObjectPoolNode = _tail ;
                    var t:ObjectPoolNode = _tail ;
                    
                    var node:ObjectPoolNode;
                    
                    for ( var i:int ; i < _initSize ; i++ )
                    {
                        node      = new ObjectPoolNode() ;
                        node.data = builder.build() ;
                        t.next    = node ;
                        t         = node ;
                    }
                    _tail = t ;
                    _tail.next = _empty = _head ;
                    _allocate = n.next ;
                    return get();
                }
                else
                {
                    throw new Error( this + " object property failed, object pool exhausted." );
                }
            }
            else
            {
                var o:*        = _allocate.data ;
                _allocate.data = null ;
                _allocate      = _allocate.next ;
                _usageCount++;
                return o ;
            }
        }
        
        /**
         * Initialize all objects in the pool with a generic object.
         * @param init The generic object to enumerate to initialize all objects in the pool factory.
         */
        public function initialize( init:Object ):void
        {
            if( init )
            {
                var node:ObjectPoolNode = _head ;
                while ( node )
                {
                    for( var prop:String in init )
                    {
                        node.data[ prop ] = init[prop] ;
                    }
                    if ( node == _tail ) 
                    {
                        break ;
                    }
                    node = node.next ; 
                }
            }
        }
        
        /**
         * @private
         */
        private var _allocate:ObjectPoolNode;
        
        /**
         * @private
         */
        private var _currSize:int;
        
        /**
         * @private
         */
        private var _empty:ObjectPoolNode;
                
        /**
         * @private
         */
        private var _head:ObjectPoolNode;
        
        /**
         * @private
         */
        private var _initSize:int;
        
        /**
         * @private
         */
        private var _tail:ObjectPoolNode;
        
        /**
         * @private
         */
        private var _usageCount:int;
    }
}
