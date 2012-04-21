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

package graphics.display.palettes
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * Calculates the average color of the specified BitmapData Object.
     * @param source The BitmapData to analyse.
     * @return The Vector.<uint> of average colors defines by the BitmapData object.
     */
    public function averageColors( source:BitmapData , colors:uint ):Vector.<uint>
    {
        var row:int ;
        var col:int ;
        
        var x:int ;
        var y:int ;
        
        var averages:Vector.<uint> = new Vector.<uint>();
        var columns:int = Math.round( Math.sqrt( colours ) );
        
        var w:int = Math.round( source.width  / columns );
        var h:int = Math.round( source.height / columns );
        
        var box:BitmapData ;
        var origin:Point   = new Point() ;
        var rect:Rectangle = new Rectangle();
        
        rect.width  = w ;
        rect.height = h ;
        
        for (var i:int ; i < colours ; i++ ) 
        {
            rect.x = x ;
            rect.y = y ;
            
            box = new BitmapData( w , h , false ) ;
            box.copyPixels( source , rect , origin );
            
            averages.push( averageColour( box ) );
            box.dispose();
            
            col = i % columns;
            
            x = w * col;
            y = h * row;
            
            if ( col == columns - 1 ) 
            {
                row++;
            }
        }
        
        return averages;
    }
}
