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

package system.network
{
    /**
     * The URIScheme class.
     * <p><b>See:</b></p>
     * <ul>
     * <li><a href="http://en.wikipedia.org/wiki/URI_scheme">http://en.wikipedia.org/wiki/URI_scheme</a></li>
     * <li><a href="http://esw.w3.org/topic/UriSchemes/">http://esw.w3.org/topic/UriSchemes/</a></li>
     * </ul>
     * <p><b>generic syntax :</b></p>
     * <pre>
     * &lt;scheme>://[&lt;username>[:&lt;password>]&#64;]&lt;host>[:&lt;port>]/&lt;path>[?&lt;query>][#&lt;fragment>]
     * </pre>
     */
    public class URIScheme
    {
        /**
         * The default port of the scheme.
         */
        public var defaultPort:int;
        
        /**
         * The delimiter value.
         */
        public var delimiter:String;
        
        /**
         * The scheme expression.
         */
        public var scheme:String;
        
        /**
         * Creates a new URIScheme instance.
         * @param scheme The String representation of the uri scheme.
         * @param delimiter The delimiter value.
         * @param defaultPort The default port of the scheme.
         */
        public function URIScheme( scheme:String, delimiter:String, defaultPort:int = -1 )
        {
            this.scheme      = scheme;
            this.delimiter   = delimiter;
            this.defaultPort = defaultPort;
        }
        
        /**
         * HTTP resources
         * <p><b>Syntax:</b></p>
         * <pre>
         * http://[&lt;username&gt;[:&lt;password&gt;]&#64;]&lt;host&gt;[:&lt;port&gt;]/&lt;path&gt;[?&lt;query&gt;][#&lt;fragment&gt;]
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * http://www.ietf.org/rfc/rfc2396.txt
         * </pre>
         */
        public static const HTTP:URIScheme = new URIScheme( "http", "://" , 80 );
        
        /**
         * HTTP connections secured using SSL/TLS
         * <p><b>Syntax:</b></p>
         * <pre>
         * https://[&lt;username&gt;[:&lt;password&gt;]&#64;]&lt;host&gt;[:&lt;port&gt;]/&lt;path&gt;[?&lt;query&gt;][#&lt;fragment&gt;]
         * </pre>
         */
        public static const HTTPS:URIScheme = new URIScheme( "https", "://" , 443 );
        
        /**
         * FTP resources
         * <p><b>Syntax:</b></p>
         * <pre>
         * ftp://[&lt;username$gt;[:&lt;password&gt;]&#64;]&lt;host&gt;[:&lt;port&gt;]/&lt;path&gt;
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * ftp://ftp.is.co.za/rfc/rfc1808.txt
         * </pre>
         */
        public static const FTP:URIScheme = new URIScheme( "ftp", "://" , 21 );
        
        /**
         * Addressing files on local or network file systems.
         * <p><b>Syntax:</b></p>
         * <pre>
         * file://[&lt;host&gt;]/&lt;path&gt;
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * file:///C:/Documents%20and%20Settings/bob/Desktop
         * file:///Users/bob/Desktop
         * file://alpha.hut.fi/u/lai/tik/tik76002/public_html/lerman.files/chaps
         * file:///u/lai/tik/tik76002/public_html/lerman.files/chaps
         * file:///etc/motd
         * </pre>
         */
        public static const FILE:URIScheme = new URIScheme( "file", "://", -1 );
        
        /**
         * Mail to resources
         * <p><b>Syntax:</b></p>
         * <pre>
         * mailto:&lt;address&gt;[?&lt;header1&gt;=&lt;value1&gt;[&#38;&lt;header2$gt;=&lt;value2&gt;]]
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * mailto:John.Doe&#64;example.com
         * mailto:jsmith&#64;example.com?subject=A%20Test&#38;body=My%20idea%20is%3A%20%0A
         * </pre>
         */
        public static const MAILTO:URIScheme = new URIScheme( "mailto", ":", 25 );
        
        /**
         * Newsgroups and postings.
         * <p><b>Syntax:</b></p>
         * <pre>
         * news:&lt;newsgroupname&gt;
         * news:&lt;message-id&gt;
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * news:comp.infosystems.www.servers.unix
         * </pre>
         */
        public static const NEWS:URIScheme = new URIScheme( "news", ":", -1 );
        
        /**
         * Usenet NNTP (Network News Transfer Protocol).
         * <p><b>Syntax:</b></p>
         * <pre>
         * nntp://&lt;host&gt;:&lt;port&gt;/&lt;newsgroup-name&gt;/&lt;article-number&gt;
         * </pre>
         */
        public static const NNTP:URIScheme = new URIScheme( "nntp", "://", 119 );
        
        /**
         * Gopher protocol
         * <p><b>Syntax:</b></p>
         * <pre>
         * gopher://&lt;host&gt;:&lt;port&gt;/&lt;item type&gt;/&lt;path&gt;
         * </pre>
         */
        public static const GOPHER:URIScheme = new URIScheme( "gopher", "://", 70 );
        
        /**
         * AIR Application protocol.
         * <p><b>Syntax:</b></p>
         * <pre>
         * app:&lt;path&gt;
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * app:/DesktopPathTest.xml
         * </pre>
         */
        public static const AIRAPPLICATION:URIScheme = new URIScheme( "app", ":", -1 );
        
        /**
         * AIR Storage protocol.
         * <p><b>Syntax:</b></p>
         * <pre>
         * app-storage:&lt;path&gt;
         * </pre>
         * <p><b>Example:</b></p>
         * <pre>
         * app-storage:/preferences.xml
         * </pre>
         */
        public static const AIRSTORAGE:URIScheme = new URIScheme( "app-storage", ":", -1 );
    }
}