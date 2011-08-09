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

package
{
    import core.Logger;
    import core.log;
    
    import flash.display.Sprite;
    import flash.utils.getQualifiedClassName;
    
    [ExcludeClass]
    [SWF(width="400", height="400", backgroundColor="0xffffff", frameRate="24", pageTitle="logd_test", scriptRecursionLimit="1000", scriptTimeLimit="60")]
    public class logd_test extends Sprite
    {
        public var mylog:Logger;
        
        public function logd_test()
        {
            //assert( 1 < 0, "one is not bigger than zero ?!?" );
            //trace( "logger id: " + log.id );
            LOG::P
            {
            log.config( { mode: "raw" } );
            log.level = log.VERBOSE;
            log.i( "test info message" );
            log.d( "test debug message" );
            }
            
            
            //mylog = log.tag( getQualifiedClassName( this ) );
            mylog = log.tag( "test", log.VERBOSE );
            //mylog.config( { mode: "clean", sep: " " } );
            mylog.config( { mode: "data", sep: " " } );
            mylog.output = custom_output2;
            //mylog.output = custom_output1;
            mylog.i( "constructor", Sprite );
            mylog.d( "constructor" );
            
            trace( mylog is Logger );
        }
        
        public function custom_output1( msg:String, o:* = null ):void
        {
            if( o )
            {
                trace( msg + " - " + getQualifiedClassName(o) );
            }
            else
            {
                trace( msg );
            }
        }
        
        public function custom_output2( msg:String, o:* = null ):void
        {
            var clazz:String = "";
            
            if( o && o.o ) { clazz = getQualifiedClassName( o.o ); }
            
            
            var d:Date = new Date();
            
            var _yyyy:Number = d.getFullYear();
            var _mm:Number   = d.getMonth() + 1;
            var _dd:Number   = d.getDate();
            
            var yyyy:String = _yyyy.toString();
            var mm:String;
            var dd:String;
            
            if( _mm < 10 ) { mm = "0" + _mm; }
            else { mm = _mm.toString(); }
            
            if( _dd < 10 ) { dd = "0" + _dd; }
            else { dd = _dd.toString(); }
            
            if( clazz == "" )
            {
                trace( o.id + " " + [yyyy,mm,dd].join("/") + " - [" + o.tag + "] : " + msg );
            }
            else
            {
                trace( o.id + " " + [yyyy,mm,dd].join("/") + " - " + clazz + "{} : " + msg );
            }
        }
    }
}
