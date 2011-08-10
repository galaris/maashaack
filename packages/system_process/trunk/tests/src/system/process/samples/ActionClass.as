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

package system.process.samples 
{    import system.events.EventDispatcher;
    import system.process.Action;
    import system.process.TaskPhase;
    import system.signals.Signal;
    import system.signals.Signaler;

    public class ActionClass extends EventDispatcher implements Action
    {    
        public function ActionClass()
        {
            //
        }
        
        public function get finishIt():Signaler
        {
            return _finishIt ;
        }
        
        public function set finishIt( signal:Signaler ):void
        {
            _finishIt = signal ;
        }
        
        public function get phase():String
        {
            return _phase ;
        }
        
        public function get running():Boolean
        {
            return true ;
        }     
        
        public function get startIt():Signaler
        {
            return _startIt ;
        }
        
        public function set startIt( signal:Signaler ):void
        {
            _startIt = signal ;
        }
        
        public function clone():*
        {
            return new ActionClass() ;
        }
        
        public function notifyFinished():void
        {
            throw new Error("finished") ;
        }
        
        public function notifyStarted():void
        {
            throw new Error("started") ;
        }
        
        public function run(...arguments:Array):void
        {
            throw new Error("run") ;
        }
        
        private var _finishIt:Signaler = new Signal() ;
        private var _phase:String      = TaskPhase.INACTIVE ;
        private var _startIt:Signaler = new Signal() ;
    }}