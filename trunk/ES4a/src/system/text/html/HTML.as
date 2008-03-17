
package system.text.html
    {
    import system.text.html.Entities;
        
    
    public class HTML
        {
        
        private var _data:String;
        
        public function HTML( text:String = "", convert:Boolean = true )
            {
            _data = text;
            }
        
        static public function encode( text:String ):String
            {
            var html:String = "";
            var c:String;
            var last:String;
            
            for( var i:int = 0; i<text.length; i++ )
                {
                c = text.charAt(i);
                
                if( (c == " ") && (last != " ") )
                    {
                    html += c;
                    last = c;
                    continue;
                    }
                
                if( Entities.findByChar( c ) )
                    {
                    html += Entities.toHTML( c );
                    } 
                else
                    {
                    html += c;
                    }
                
                last = c;
                }
            
            return html;
            }
        
        static public function decode( html:String ):String
            {
            var text:String = "";
            var c:String;
            var ent:String;
            
            for( var i:int = 0; i<html.length; i++ )
                {
                c = html.charAt(i);
                
                if( c == "&" )
                    {
                    ent = c;
                    i++;
                    
                    while( c != ";" )
                        {
                        c = html.charAt(i);
                        ent += c;
                        i++;
                        }
                    
                    text += Entities.fromName( ent );
                    i--;
                    continue;
                    }
                
                text += c;
                }
            
            return text;
            }
        
        
        public function append( text:String, convert:Boolean = true ):void
            {
            _data += text;
            }
        
        public function toString():String
            {
            return _data;
            }
        
        
        }
    }

