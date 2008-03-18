
package system.text.html
    {
    import system.text.html.Entities;
        
    
    public class HTML
        {
        
        private var _data:String;
        
        public function HTML( text:String = "", convert:Boolean = true )
            {
            if( convert )
                {
                text = HTML.encode( text );
                }
            _data = text;
            }
        
        public static function encode( text:String ):String
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
        
        public static function decode( html:String ):String
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
            if( convert )
                {
                text = HTML.encode( text );
                }
            _data += text;
            }
        
        public function toString():String
            {
            return _data;
            }
        
        /* TODO:
           - method toXML or toXMLString
           - method valueOf ? doing an HTML decode to obtain the raw string ? or toHTMLString method
           - static methods to handle HTML tags as bold, paragraph, font, etc. (or a Tag class, BoldTag class, FontTag class, etc...)
        */
        
        }
    }

