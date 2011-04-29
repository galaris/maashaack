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

package system.logging
{
    import core.strings.format;
    
    import system.data.Set;
    import system.data.sets.ArraySet;
    import system.errors.InvalidFilterError;
    import system.signals.Receiver;
    
    /**
     * This class provides the basic functionality required by the logging framework for a logger target implementation. 
     * It handles the validation of filter expressions and provides a default level property. 
     */
    public class LoggerTarget implements Receiver
    {
        /**
         * Creates a new LoggerTarget instance.
         */
        public function LoggerTarget()
        {
            /* note:
               I had problem with the unit tests no passing
               when the Log is assigned directly to the property
               when we assign the default in the ctor all the unit tests pass
            */
            _factory = Log;
            _filters = new ArraySet( ["*"] );
            _level   = LoggerLevel.ALL;
        }
        
        /**
         * Determinates the LoggerFactory reference of the target, by default the target use the <code>system.logging.Log</code> singleton.
         */
        public function get factory():LoggerFactory
        {
            return _factory ;
        }
        
        /**
         * @private
         */
        public function set factory( factory:LoggerFactory ):void
        {
            if ( _factory )
            {
                _factory.removeTarget( this ) ;
            }
            _factory = factory || Log ;
            _factory.addTarget( this ) ;
        }
        
        /**
         * Indicates the filters array representation of this target.
         */
        public function get filters():Array
        {
            return _filters.toArray() ;
        }
        
        /**
         * @private
         */
        public function set filters( value:Array ):void
        {
            if ( value != null && value.length > 0 )
            {
                var len:int = value.length ;
                for ( var i:int ; i<len ; i++ )
                {
                    _checkFilter( value[i] as String ) ;
                }
            }
            else
            {
                value = ["*"] ;
            }
            
            if ( _count > 0 )
            {
                _factory.removeTarget( this ) ;
            }
            
            _filters = new ArraySet( value ) ;
            if ( _count > 0 )
            {
                _factory.addTarget( this ) ;
            }
        }
        
        /**
         * Indicates the level of this target.
         */
        public function get level():LoggerLevel
        {
            return _level ;
        }
        
        /**
         * @private
         */
        public function set level( value:LoggerLevel ):void
        {
            _factory.removeTarget( this ) ;
            _level = value || LoggerLevel.ALL ;
            _factory.addTarget( this ) ;
        } 
        
        /**
         * Insert a channel in the fllters if this channel don't exist.
         * Returns a boolean if the channel is add in the list.
         */
        public function addFilter( channel:String ):Boolean 
        {
            _checkFilter( channel ) ;
            return _filters.add( channel ) ;
        }
        
        /**
         * Sets up this target with the specified logger.
         * Note : this method is called by the framework and should not be called by the developer.
         */
        public function addLogger( logger:Logger ):void 
        {
            if ( logger != null )
            {
                _count++ ;
                logger.connect( this ) ;
            }
        }
        
        /**
         *  This method receive a <code class="prettyprint">LoggerEntry</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the target's level.
         *  <b><i>Descendants need to override this method to make it useful.</i></b>
         */
        public function logEntry( entry:LoggerEntry ):void
        {
            // override please.
        }
        
        /**
         * This method is called when the receiver is connected with a Signal object.
         * @param ...values All the values emitting by the signals connected with this object.
         */
        public function receive( ...values:Array ):void
        {
            var entry:LoggerEntry = values[0] as LoggerEntry ;
            if ( entry )
            {
                if ( _level == LoggerLevel.NONE )
                {
                    return ; // logging off
                }
                else if ( int( entry.level ) >= int( _level ) )
                {
                    logEntry( entry ) ;
                }
            }
        }
        
        /**
         * Remove a channel in the fllters if this channel exist.
         * @return a boolean if the channel is removed.
         */
        public function removeFilter( channel:String ):Boolean
        {
            return _filters.remove( channel ) ;
        }
        
        /**
         * Stops this target from receiving events from the specified logger.
         */
        public function removeLogger( logger:Logger ):void 
        {
            if ( logger != null )
            {
                _count-- ;
                logger.disconnect( this ) ;
            }
        }
        
        /**
         * Count of the number of loggers this target is listening to. 
         * When this value is zero changes to the filters property shouldn't do anything.
         * @private
         */
        private var _count:uint ;
        
        /**
         * @private
         */
        private var _factory:LoggerFactory;
        
        /**
         * @private
         */
        private var _filters:Set;
        
        /**
         * @private
         */
        private var _level:LoggerLevel;
        
        /**
         * @private
         */
        private function _checkFilter( filter:String ):void
        {
            if ( filter == null )
            {
                throw new InvalidFilterError( LoggerStrings.EMPTY_FILTER  ) ;
            }
            
            if ( _factory.hasIllegalCharacters(filter) )
            {
                 throw new InvalidFilterError( format( LoggerStrings.ERROR_FILTER , filter ) + LoggerStrings.CHARS_INVALID ) ;
            }
            
            var index:int = filter.indexOf("*") ;
            if ((index >= 0) && (index != (filter.length -1)))
            {
                throw new InvalidFilterError( format( LoggerStrings.ERROR_FILTER , filter) + LoggerStrings.CHAR_PLACEMENT ) ;
            }
        }
    }
}