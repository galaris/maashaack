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
    import flash.utils.Dictionary;
    
    /**
     * Generates a Vector.<ColorEntry> representing each colour present in an image. Each object has a 'color' and a 'count' property.
     * @param source The BitmapData to analyse.
     * @param sort Whether to sort results by their count.
     * @param order If sort is true, results will be sorted in this order.
     * @param preprocess Indicates if the image reduce this number of colors (64 colors only).
     * @return The Vector.<ColorEntry> of colors defines by the BitmapData object.
     */
    public function indexColors( source:BitmapData, sort:Boolean = true, order:uint = Array.DESCENDING , preprocess:Boolean = true ):Vector.<ColorEntry>
    {
        if ( preprocess )
        {
            reduce( source, 64 );
        }
        
        var pixel:uint;
        
        var colors:Array = [] ;
        
        var buffer:Dictionary = new Dictionary( true );
        
        var width:int  = source.width ;
        var height:int = source.height ; 
        
        for (var x:int ; x < width ; x++ ) 
        {
            for ( var y:int ; y < height ; y++ ) 
            {
                pixel = source.getPixel(x, y);
                if( buffer[pixel] )
                {
                    (buffer[pixel] as ColorEntry).count++ ;
                }
                else
                {
                    buffer[pixel] = new ColorEntry( pixel , 1 ) ;
                    colors.push( buffer[pixel] ) ;
                }
            }
        }
        
        if ( sort ) 
        {
            return Vector.<ColorEntry>( colors.sort( sortColorEntryByCount, order ) );
        }
        else
        {
            return Vector.<ColorEntry>(colors) ;
        }
    }
}
