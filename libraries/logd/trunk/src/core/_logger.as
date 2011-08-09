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

package core
{
    import flash.utils.getTimer;
    
    /* note:
       implementation of the Logger interface
    */
    internal final class _logger implements Logger
    {
        private namespace raw;
        private namespace clean;
        private namespace data;
        private namespace short;
        
        private const _RAW_SEP:String = "|";
        
        private const _SUPPRESS:int = -1;
        private const _VERBOSE:int  =  2;
        private const _DEBUG:int    =  3;
        private const _INFO:int     =  4;
        private const _WARN:int     =  5;
        private const _ERROR:int    =  6;
        private const _ASSERT:int   =  7;
        
        private var _id:String;
        private var _level:int;
        private var _tag:String;
        
        private var _priorities:Array;
        private var _formatUpdated:Boolean;
        private var _configUpdated:Boolean;
        
        private var _input:Function;
        private var _output:Function;
        
        private var _sep:String;
        private var _mode:String;
        private var _useTag:Boolean;
        private var _useTime:Boolean;
        
        public function _logger( tag:String = "", level:int = 4 )
        {
            _id    = _generateUnique( 8 );
            _level = level;
            _tag   = tag;
            
            _input   = null;
            _output  = trace;
            
            _sep     = _RAW_SEP;
            _mode    = "raw";
            _useTag  = true;
            _useTime = true;
            _configUpdated = false;
            
            _priorities = [];
            _priorities[ VERBOSE ] = ["V",   "",       "" ];
            _priorities[ DEBUG   ] = ["D",   "[ ",   " ]" ];
            _priorities[ INFO    ] = ["I",   "( ",   " )" ];
            _priorities[ WARN    ] = ["W",   "!! ", " !!" ];
            _priorities[ ERROR   ] = ["E",   "## ", " ##" ];
            _priorities[ ASSERT  ] = ["WTF", "@ ",   " @" ];
            _formatUpdated = false;
        }
        
        private function _generateUnique( letters:uint ):String
        {
            var str:String = "";
            //var l:Array    = "abcdefghijklmnopqrstuvwxyz".split( "" );
            var l:Array    = "0123456789abcdef".split( "" );
            
            function randomLetter():String
            {
                //return l[ Math.floor( Math.random() * 26) ];
                return l[ Math.floor( Math.random() * 16) ];
            }
            
            var i:uint;
            for( i=0; i <= letters; i++ )
            {
                str += randomLetter().toUpperCase();
            }
            
            return str;
        }
        
        public final function get SUPPRESS():int { return _SUPPRESS; }
        public final function get VERBOSE():int  { return _VERBOSE; }
        public final function get DEBUG():int    { return _DEBUG; }
        public final function get INFO():int     { return _INFO; }
        public final function get WARN():int     { return _WARN; }
        public final function get ERROR():int    { return _ERROR; }
        public final function get ASSERT():int   { return _ASSERT; }
        
        public final function get id():String { return _id; }
        
        public final function get level():int { return _level; }
        public final function set level( value:int ):void { _level = value; }
        
        public final function get input():Function { return _input; }
        public final function set input( value:Function ):void { _input = value; }
        
        public final function get output():Function { return _output; }
        public final function set output( value:Function ):void { _output = value; }
        
        public final function config( cfg:Object ):void
        {
            if( "id"   in cfg ) { _id      = cfg.id;   _configUpdated = true; }
            if( "sep"  in cfg ) { _sep     = cfg.sep;  _configUpdated = true; }
            if( "mode" in cfg ) { _mode    = cfg.mode; _configUpdated = true; }
            if( "tag"  in cfg ) { _useTag  = cfg.tag;  _configUpdated = true; }
            if( "time" in cfg ) { _useTime = cfg.time; _configUpdated = true; }
        }
        
        public final function format( priority:int, pre:String = "", post:String = "" ):void
        {
            /* note:
               we don't want to allow to change the tag format
               as the flashlogs.txt reader depends on it
               to parse the different lines.
            */
            if( _priorities[ priority ] )
            {
                var tag:String = _priorities[ priority ][0];
                _priorities[ priority ] = [ tag, pre, post ];
                _formatUpdated = true;
            }
        }
        
        public final function tag( name:String, level:int = -2 ):Logger
        {
            if( level == -2 ) { level = _level; }
            
            var newlog:Logger = new _logger( name, level );
                newlog.input  = input;
                newlog.output = output;
            
            if( _formatUpdated )
            {
                newlog.format( VERBOSE, _priorities[ VERBOSE ][1], _priorities[ VERBOSE ][2] );
                newlog.format( DEBUG,   _priorities[ DEBUG   ][1], _priorities[ DEBUG   ][2] );
                newlog.format( INFO,    _priorities[ INFO    ][1], _priorities[ INFO    ][2] );
                newlog.format( WARN,    _priorities[ WARN    ][1], _priorities[ WARN    ][2] );
                newlog.format( ERROR,   _priorities[ ERROR   ][1], _priorities[ ERROR   ][2] );
                newlog.format( ASSERT,  _priorities[ ASSERT  ][1], _priorities[ ASSERT  ][2] );
            } 
            
            var cfg:Object = { id: _id, sep: _sep, mode: _mode, tag: _useTag, time: _useTime };
            newlog.config( cfg );
            
            return newlog;
        }
        
        public final function v( msg:String, o:*=null ):void   { println( _VERBOSE, _tag, msg, o ); }
        public final function d( msg:String, o:*=null ):void   { println( _DEBUG,   _tag, msg, o ); }
        public final function i( msg:String, o:*=null ):void   { println( _INFO,    _tag, msg, o ); }
        public final function w( msg:String, o:*=null ):void   { println( _WARN,    _tag, msg, o ); }
        public final function e( msg:String, o:*=null ):void   { println( _ERROR,   _tag, msg, o ); }
        public final function wtf( msg:String, o:*=null ):void { println( _ASSERT,  _tag, msg, o ); }
        
        public final function println( priority:int, tag:String, msg:String, o:* = null ):void
        {
            if( _level < 0 ) { return; }
            
            if( priority < _level ) { return; }
            
            if( _input != null )
            {
                var result:Object = _input( msg, o );
                msg = result.msg;
                o   = result.o;
            }
            
            var ns:Namespace;
            
            switch( _mode )
            {
                case "raw":   ns = raw;   break;
                case "clean": ns = clean; break;
                case "data":  ns = data;  break;
                case "short": ns = short; break;
                default:      ns = raw;
            }
            
            ns::println( priority, tag, msg, o );
        }
        
        /* note:
           the "raw" mode is meant to be written to text file like flashlogs.txt
           
           ex:
           B9734018C|I|mytag|test info message|61
        */
        raw final function println( priority:int, tag:String, msg:String, o:* = null ):void
        {
            var str:String = "";
                
                str += _id;
                str+= _sep;
                
                str += _priorities[ priority ][0];
                str += _sep;
                
                if( _useTag )
                {
                str += tag;
                str += _sep;
                }
                
                str += msg;
                
                if( _useTime )
                {
                str += _sep;
                str += getTimer();
                }
            
            if( o ) { _output( str, o ); } else { _output( str ); }
        }
        
        /* note:
           the "clean" mode is meant to be written to console output
           
           ex:
           mytag (test info message) 61
        */
        clean final function println( priority:int, tag:String, msg:String, o:* = null ):void
        {
            var str:String = "";
                
                if( _useTag && (tag != "") )
                {
                str += tag;
                str += _sep;
                }
                
                str += _priorities[ priority ][1];
                str += msg;
                str += _priorities[ priority ][2];
                
                if( _useTime )
                {
                str += _sep;
                str += getTimer();
                }
            
            if( o ) { _output( str, o ); } else { _output( str ); }
        }
        
        /* note:
           the "data" mode is meant to pass a detailled data set for advanced custom output
           
           ex:
           function custom_output( msg:String, o:* = null ):void
           {
                 myOtherSuperDuperLogger.log( msg, o.tag, o.priority );
           }
        */
        data final function println( priority:int, tag:String, msg:String, o:* = null ):void
        {
            var str:String = msg;
            
            var obj:Object = {};
                obj.id       = _id;
                obj.priority = priority;
                obj.letter   = _priorities[ priority ][0];
                obj.pre      = _priorities[ priority ][1];
                obj.post     = _priorities[ priority ][2];
                obj.tag      = tag;
                obj.time     = getTimer();
                obj.sep      = _sep;
                obj.o        = o;
            
            _output( str, obj );
        }
        
        /* note:
           the "short" mode is meant to be written to text fields and as short as possible
           (like a `trace()` call)
           
           ex:
           test info message
        */
        short final function println( priority:int, tag:String, msg:String, o:* = null ):void
        {
            var str:String = msg;
            
            if( o ) { _output( str, o ); } else { _output( str ); }
        }

    }
}