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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.network
{
    
    /**
    * URIScheme clas
    * 
    * see:
    * http://en.wikipedia.org/wiki/URI_scheme
    * http://esw.w3.org/topic/UriSchemes/
    * 
    * generic syntax:
    * <scheme>://[<username>[:<password>]@]<host>[:<port>]/<path>[?<query][#<fragment>]
    */
    public class URIScheme
    {
        public var scheme:String;
        
        public var delimiter:String;
        
        public var defaultPort:int;
        
        public function URIScheme( scheme:String, delimiter:String, defaultPort:int = -1 )
        {
            this.scheme      = scheme;
            this.delimiter   = delimiter;
            this.defaultPort = defaultPort;
        }
        
        /**
        * HTTP resources
        * 
        * syntax:
        * http://[<username>[:<password>]@]<host>[:<port>]/<path>[?<query][#<fragment>]
        * 
        * example:
        * http://www.ietf.org/rfc/rfc2396.txt
        */
        public static const HTTP:URIScheme           = new URIScheme( "http", "://", 80 );
        
        /**
        * HTTP connections secured using SSL/TLS
        * 
        * syntax:
        * https://[<username>[:<password>]@]<host>[:<port>]/<path>[?<query][#<fragment>]
        */
        public static const HTTPS:URIScheme          = new URIScheme( "https", "://", 443 );
        
        /**
        * FTP resources
        * 
        * syntax:
        * ftp://[<username>[:<password>]@]<host>[:<port>]/<path>
        * 
        * example:
        * ftp://ftp.is.co.za/rfc/rfc1808.txt
        */
        public static const FTP:URIScheme            = new URIScheme( "ftp", "://", 21 );
        
        /**
        * Addressing files on local or network file systems
        * 
        * syntax:
        * file://[<host>]/<path>
        * 
        * example:
        * file:///C:/Documents%20and%20Settings/bob/Desktop
        * file:///Users/bob/Desktop
        * file://alpha.hut.fi/u/lai/tik/tik76002/public_html/lerman.files/chaps
        * file:///u/lai/tik/tik76002/public_html/lerman.files/chaps
        * file:///etc/motd
        */
        public static const FILE:URIScheme           = new URIScheme( "file", "://", -1 );
        
        /**
        * 
        * syntax:
        * mailto:<address>[?<header1>=<value1>[&<header2>=<value2>]]
        * 
        * example:
        * mailto:John.Doe@example.com
        * mailto:jsmith@example.com?subject=A%20Test&body=My%20idea%20is%3A%20%0A
        */
        public static const MAILTO:URIScheme         = new URIScheme( "mailto", ":", 25 );
        
        /**
        * Newsgroups and postings
        * 
        * syntax:
        * news:<newsgroupname>
        * news:<message-id>
        * 
        * example:
        * news:comp.infosystems.www.servers.unix
        */
        public static const NEWS:URIScheme           = new URIScheme( "news", ":", -1 );
        
        /**
        * Usenet NNTP (Network News Transfer Protocol)
        * syntax:
        * nntp://<host>:<port>/<newsgroup-name>/<article-number>
        */
        public static const NNTP:URIScheme           = new URIScheme( "nntp", "://", 119 );
        
        /**
        * Gopher protocol
        * 
        * syntax:
        * gopher://<host>:<port>/<item type>/<path>
        */
        public static const GOPHER:URIScheme         = new URIScheme( "gopher", "://", 70 );
        
        /**
        * AIR Application protocol
        * 
        * syntax:
        * app:<path>
        * 
        * example:
        * app:/DesktopPathTest.xml
        */
        public static const AIRAPPLICATION:URIScheme = new URIScheme( "app", ":", -1 );
        
        /**
        * AIR Storage protocol
        * 
        * syntax:
        * app-storage:<path>
        * 
        * example:
        * app-storage:/preferences.xml
        */
        public static const AIRSTORAGE:URIScheme     = new URIScheme( "app-storage", ":", -1 );
        
    }
}