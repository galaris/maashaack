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

package system.logging 
{
    import core.strings.indexOfAny;
    
    import system.errors.InvalidChannelError;
    
    import flash.utils.Dictionary;
    
    /**
     * This factory provides pseudo-hierarchical logging capabilities with multiple format and output options.
     * <p>This class in an internal class in the package system.logging you can use the Log singleton to deploy all the loggers in your application.</p>
     */
    public final class LoggerFactory 
    {
        /**
         * Creates a new LoggerFactory instance.
         */
        public function LoggerFactory()
        {
            //
        }
        
        /**
         * Allows the specified target to begin receiving notification of log events.
         * @param target The specific target that should capture log events.
         * @throws ArgumentError If the target is invalid.
         */
        public function addTarget( target:LoggerTarget ):void
        {
            if( target )
            {
                var filters:Array = target.filters ;
                var channel:String ;
                for ( channel in _loggers )
                {
                    if( _channelMatchInFilterList( channel, filters ) )
                    {
                        target.addLogger( _loggers[channel] as Logger ) ;
                    }
                }
                _targets.push( target );
                if ( ( _targetLevel == LoggerLevel.NONE ) || ( int( target.level ) < int( _targetLevel ) ) )
                {
                    _targetLevel = target.level ;
                }
            }
            else
            {
                throw new ArgumentError( LoggerStrings.INVALID_TARGET );
            }
        }
        
        /**
         * This method removes all of the current loggers from the cache of the factory.
         * Subsquent calls to the <code class="prettyprint">getLogger()</code> method return new instances of loggers rather than any previous instances with the same category.
         * This method is intended for use in debugging only.
         */
        public function flush():void
        {
            _loggers = new Dictionary() ;
            _targets = new Vector.<LoggerTarget>() ;
            _targetLevel = LoggerLevel.NONE ;
        }
        
        /**
         * Returns the logger associated with the specified channel.
         * If the category given doesn't exist a new instance of a logger will be returned and associated with that channel.
         * Channels must be at least one character in length and may not contain any blanks or any of the following characters:
         * []~$^&amp;\/(){}&lt;&gt;+=`!#%?,:;'"&#64;
         * This method will throw an <code class="prettyprint">InvalidChannelError</code> if the category specified is malformed.
         * @param channel The channel of the logger that should be returned.
         * @return An instance of a logger object for the specified name.
         * If the name doesn't exist, a new instance with the specified name is returned.
         */
        public function getLogger( channel:String ):Logger
        {
            _checkChannel( channel ) ;
            var result:Logger = _loggers[channel] as Logger ;
            if( result == null )
            {
                result = new Logger( channel ) ;
                _loggers[channel] = result ;
            }
            var target:LoggerTarget ;
            var len:int = _targets.length ;
            for( var i:int ; i<len ; i++ )
            {
                target = _targets[i] as LoggerTarget ;
                if( _channelMatchInFilterList( channel , target.filters ) )
                {
                    target.addLogger(result);
                }
            } 
            return result ;
        }
        
        /**
         * This method checks the specified string value for illegal characters.
         * @param value The String to check for illegal characters. The following characters are not valid: []~$^&amp;\/(){}&lt;&gt;+=`!#%?,:;'"&#64;
         * @return <code class="prettyprint">true</code> if there are any illegal characters found, <code class="prettyprint">false</code> otherwise.
         */
        public function hasIllegalCharacters( value:String ):Boolean
        {
            return indexOfAny( value , LoggerStrings.ILLEGALCHARACTERS.split("") ) != -1 ;
        }
        
        /**
         * Indicates whether a 'all' level log event will be processed by a log target.
         * @return true if a 'all' level log event will be logged; otherwise false.
         */
        public function isAll():Boolean
        {
            return _targetLevel == LoggerLevel.ALL ;
        }
        
        /**
         * Indicates whether a debug level log event will be processed by a log target.
         * @return true if a debug level log event will be logged; otherwise false.
         */
        public function isDebug():Boolean
        {
            return int(_targetLevel) <= int( LoggerLevel.DEBUG ) ;
        }
        
        /**
         * Indicates whether an error level log event will be processed by a log target.
         * @return true if an error level log event will be logged; otherwise false.
         */
        public function isError():Boolean
        {
            return int(_targetLevel) <= int( LoggerLevel.ERROR ) ;
        }
        
        /**
         * Indicates whether a fatal level log event will be processed by a log target.
         * @return true if a fatal level log event will be logged; otherwise false.
         */
        public function isFatal():Boolean
        {
            return int(_targetLevel) <= int( LoggerLevel.FATAL ) ;
        }
        
        /**
         * Indicates whether an info level log event will be processed by a log target.
         * @return true if an info level log event will be logged; otherwise false.
         */    
        public function isInfo():Boolean
        {
            return int(_targetLevel) <= int( LoggerLevel.INFO ) ;
        }
        
        /**
         * Indicates whether a warn level log event will be processed by a log target.
         * @return true if a warn level log event will be logged; otherwise false.
         */
        public function isWarn():Boolean
        {
            return int(_targetLevel) <= int( LoggerLevel.WARN ) ;
        }
        
        /**
         * Indicates whether a wtf level log event will be processed by a log target.
         * @return true if a wtf level log event will be logged; otherwise false.
         */
        public function isWtf():Boolean
        {
            return int(_targetLevel) <= int( LoggerLevel.WTF ) ;
        }
        
        /**
         * Stops the specified target from receiving notification of log events.
         * @param target The specific target that should capture log events.
         * @throws ArgumentError If the target is invalid.
         */
        public function removeTarget( target:LoggerTarget ):void
        {
            if( target )
            {
                var filters:Array = target.filters;
                for ( var channel:String in _loggers )
                {
                    if( _channelMatchInFilterList( channel, filters ) )
                    {
                        target.removeLogger( _loggers[channel] as Logger );
                    }
                }
                var len:int = _targets.length ;
                for( var i:int ; i < len ; i++ )
                {
                    if( target == _targets[i] )
                    {
                        _targets.splice(i, 1) ;
                        i-- ;
                    }
                }
                _resetTargetLevel() ;
            }
            else
            {
                throw new ArgumentError( LoggerStrings.INVALID_TARGET );
            }
        }
        
        /**
         * @private
         */
        private var _loggers:Dictionary = new Dictionary(true) ;
        
        /**
         * The most verbose supported log level among registered targets.
         * @private
         */
        private var _targetLevel:LoggerLevel = LoggerLevel.NONE ;
        
        /**
         * Array of targets that should be searched any time a new logger is created.
         * @private
         */
        private var _targets:Vector.<LoggerTarget> = new Vector.<LoggerTarget>() ;
        
        /**
         * This method checks that the specified category matches any of the filter expressions provided in the <code class="prettyprint">filters</code> Array.
         * @param category The category to match against.
         * @param filters A list of Strings to check category against.
         * @return <code class="prettyprint">true</code> if the specified category matches any of the filter expressions found in the filters list, <code class="prettyprint">false</code> otherwise.
         */
        private function _channelMatchInFilterList( channel:String , filters:Array ):Boolean
        {
            var filter:String;
            var index:int = -1;
            var len:int = filters.length ;
            for( var i:int ; i<len ; i++ )
            {
                filter = filters[i] ;
                index  = filter.indexOf("*") ;
                if(index == 0)
                {
                    return true ;
                }
                index = (index < 0) ? index = channel.length : index -1 ;
                if( channel.substring(0, index) == filter.substring(0, index) )
                {
                    return true ;
                }
            }
            return false ;
        }
        
        /**
         * This method will ensure that a valid category string has been specified.
         * If the category is not valid an <code class="prettyprint">InvalidCategoryError</code> will be thrown.
         * Categories can not contain any blanks or any of the following characters: []`*~,!#$%^&amp;()]{}+=\|'";?&gt;&lt;./&#64; or be less than 1 character in length.
         */
        private function _checkChannel( channel:String ):void
        {
            if( channel == null || channel.length == 0 )
            {
                throw new InvalidChannelError( LoggerStrings.INVALID_LENGTH );
            }
            if( hasIllegalCharacters( channel ) || ( channel.indexOf("*") != -1 ) )
            {
                throw new InvalidChannelError( LoggerStrings.INVALID_CHARS ) ;
            }
        }
        
        /**
         * This method resets the Log's target level to the most verbose log level for the currently registered targets.
         */
        private function _resetTargetLevel():void
        {
            var target:LoggerTarget ;
            var min:LoggerLevel = LoggerLevel.NONE ;
            var len:int = _targets.length ;
            for ( var i:int ; i < len ; i++ )
            {
                target = _targets[i] ;
                if ( ( min == LoggerLevel.NONE ) || ( int( target.level ) < int(min) ) )
                {
                    min = target.level ;
                }
            }
            _targetLevel = min ;
        }
    }
}
