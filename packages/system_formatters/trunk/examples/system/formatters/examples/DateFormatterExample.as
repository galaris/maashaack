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

package examples 
{
    import system.formatters.DateFormatter;
    
    import flash.display.Sprite;
    
    /**
     * This class provides an example of the DateFormatter class.
     */
    public class DateFormatterExample extends Sprite 
    {
        public function DateFormatterExample()
        {
            var f:DateFormatter = new DateFormatter( "yyyy DDDD d MMMM - hh 'h' nn 'mn' ss 's'" ) ;
            var result:String = f.format() ;
            
            trace("pattern:" + f.pattern + " :: result:" + result ) ;
            
            trace("----") ;
            
            f.pattern = "DDDD d MMMM yyyy" ;
            result    = f.format(new Date(2005, 10, 22)) ;
            trace("pattern:" + f.pattern + " :: result:" + result ) ;
            
            trace("----") ;
            
            var formatter:DateFormatter = new DateFormatter() ;
            
            // use AM/PM designator with 't' or 'tt' or 'T' or 'TT' format expression.
            
            formatter.pattern = "hh 'h' nn 'mn' ss 's' TT" ;
            trace( formatter.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 10 h 15 mn 00 s AM
            
            formatter.pattern = "hh 'h' nn 'mn' ss 's' tt" ;
            trace( formatter.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 10 h 15 mn 00 s am
            
            formatter.pattern = "hh 'h' nn 'mn' ss 's' t" ;
            trace( formatter.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 10 h 15 mn 00 s a
            
            formatter.pattern = "hh 'h' nn 'mn' ss 's' TT" ;
            trace( formatter.format( new Date(2008,1,21,14,15,0,0) ) ) ; // 02 h 15 mn 00 s PM 
            
            formatter.pattern = "hh 'h' nn 'mn' ss 's' tt" ;
            trace( formatter.format( new Date(2008,1,21,14,15,0,0) ) ) ; // 02 h 15 mn 00 s pm
            
            formatter.pattern = "hh 'h' nn 'mn' ss 's' t" ;
            trace( formatter.format( new Date(2008,1,21,14,15,0,0) ) ) ; // 02 h 15 mn 00 s p
        }
    }
}
