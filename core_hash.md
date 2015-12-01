# About #

**core.hash** contains hashing utility functions.

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a>



| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| `core.hash.*` | FP\_10\_0<br>FP_9_0 <table><thead><th> n/a    </th><th> n/a              </th><th> yes                </th><th> 0.3.1          </th></thead><tbody></tbody></table>

<br>
<br>

<h1>Introduction</h1>

<pre>
A hash function is any algorithm or subroutine that maps large data sets of variable length,<br>
called keys, to smaller data sets of a fixed length. For example, a person's name, having a<br>
variable length, could be hashed to a single integer. The values returned by a hash function<br>
are called hash values, hash codes, hash sums, checksums or simply hashes.<br>
</pre>

Here we provide AS3 implementations of most common hash functions.<br>
<br>
Those have been verified and tested with their C implementation counterpart.<br>
<br>
We focus mainly on 32 bits or less digests.<br>
<br>
<br>
<h1>Details</h1>

Hashes can be used in a lot of different way, wether you want a checksum,<br>
a CRC or just a simple hash.<br>
<br>
From implementing a HashMap, or build a cache of files, we thought<br>
those functions were a good candidate to insert in a <b>core</b> package.<br>
<br>
Every implementations have the same strategy<br>
<ul><li>we take a ByteArray as an input<br>so you can hash strings, binaries etc.<br>
</li><li>we apply the algorithm on each byte</li></ul>

We don't do that<br>
<pre><code>function hash( value:String ):uint<br>
{<br>
    var len:uint = value.length;<br>
    var i:uint;<br>
    var c:uint;<br>
<br>
    for( i = 0; i &lt; len; i++ )<br>
    {<br>
        c = value.charCodeAt( i );<br>
        //...<br>
    }<br>
    //...<br>
}<br>
</code></pre>
<ul><li>limited to strings<br>
</li><li>does not make sens to use <code>charCodeAt</code> on a binary</li></ul>

Instead we're doing this<br>
<pre><code>function hash( bytes:ByteArray ):uint<br>
{<br>
    var len:uint = bytes.length;<br>
    bytes.position = 0<br>
    var i:uint;<br>
    var c:uint;<br>
<br>
    for( i = 0; i &lt; len; i++ )<br>
    {<br>
        c = bytes[ i ];<br>
        //...<br>
    }<br>
    //...<br>
}<br>
</code></pre>
<ul><li>everything is considered as a serie of bytes<br>
</li><li>we hash each byte<br>
</li><li>allows to hash anything: strings, AMF packet, ByteArrays, files, etc.</li></ul>

Some implementations can provide a <code>seed</code> parameter<br>
see <a href='http://code.google.com/p/maashaack/source/browse/packages/core/trunk/src/core/hash/bkdr.as#51'>BKDR implementation</a>.<br>
<br>
We will not deal with cryptographic hash function in this package<br>
because those can generate digests of 128 bits or more and require<br>
implementing special classes like BigInteger, BigNumber, etc.<br>
<br>
Using redtamarin we will provide one executable that can use any hash functions<br>
<pre><code>$ ./hash -u elf myfile.bin<br>
18131988<br>
<br>
$ ./hash -u elf -h myfile.bin<br>
0x0114ac14<br>
</code></pre>
TODO<br>
<br>
<hr />
<h1>Documentation</h1>

<h2>List of algorithms</h2>

Cyclic redundancy checks<br>
<table><thead><th> <b>name</b> </th><th> <b>digest size</b> </th><th> <b>endianness</b> </th><th> <b>names, aliases</b> </th></thead><tbody>
<tr><td> crc8        </td><td> 8bits              </td><td> big               </td><td> CRC-8                 </td></tr>
<tr><td> crc8_itu    </td><td> 8bits              </td><td> big               </td><td> CRC-8/ITU             </td></tr>
<tr><td> crc8_atm    </td><td> 8bits              </td><td> big               </td><td> CRC-8/ATM             </td></tr>
<tr><td> crc8_ccitt  </td><td> 8bits              </td><td> big               </td><td> CRC-8/CCITT           </td></tr>
<tr><td> crc8_maxim  </td><td> 8bits              </td><td> little            </td><td> CRC-8/MAXIM, DOW-CRC  </td></tr>
<tr><td> crc8_icode  </td><td> 8bits              </td><td> big               </td><td> CRC-8/I-CODE          </td></tr>
<tr><td> crc8_j1850  </td><td> 8bits              </td><td> big               </td><td> CRC-8/J1850           </td></tr>
<tr><td> crc8_wcdma  </td><td> 8bits              </td><td> little            </td><td> CRC-8/WCDMA           </td></tr>
<tr><td> crc8_rohc   </td><td> 8bits              </td><td> little            </td><td> CRC-8/ROHC            </td></tr>
<tr><td> crc8_darc   </td><td> 8bits              </td><td> little            </td><td> CRC-8/DARC            </td></tr>
<tr><td> crc16       </td><td> 16bits             </td><td> little            </td><td> CRC-16, ARC, CRC-IBM, CRC-16/ARC, CRC-16/LHA </td></tr>
<tr><td> crc16_buypass </td><td> 16bits             </td><td> big               </td><td> CRC-16/BUYPASS, CRC-16/VERIFONE </td></tr>
<tr><td> crc16_dds10 </td><td> 16bits             </td><td> big               </td><td> CRC-16/DDS-110        </td></tr>
<tr><td> crc16_en13757 </td><td> 16bits             </td><td> big               </td><td> CRC-16/EN-13757       </td></tr>
<tr><td> crc16_teledisk </td><td> 16bits             </td><td> big               </td><td> CRC-16/TELEDISK       </td></tr>
<tr><td> modbus      </td><td> 16bits             </td><td> little            </td><td> MODBUS                </td></tr>
<tr><td> crc16_maxim </td><td> 16bits             </td><td> little            </td><td> CRC-16/MAXIM          </td></tr>
<tr><td> crc16_usb   </td><td> 16bits             </td><td> little            </td><td> CRC-16/USB            </td></tr>
<tr><td> crc16_t10dif </td><td> 16bits             </td><td> big               </td><td> CRC-16/T10-DIF        </td></tr>
<tr><td> crc16_dect_x </td><td> 16bits             </td><td> big               </td><td> CRC-16/DECT-X, X-CRC-16 </td></tr>
<tr><td> crc16_dect_r </td><td> 16bits             </td><td> big               </td><td> CRC-16/DECT-R, R-CRC-16 </td></tr>
<tr><td> crc16_dnp   </td><td> 16bits             </td><td> little            </td><td> CRC-16/DNP            </td></tr>
<tr><td> xmodem      </td><td> 16bits             </td><td> big               </td><td> XMODEM, ZMODEM, CRC-16/ACORN </td></tr>
<tr><td> crc16_ccitt_false </td><td> 16bits             </td><td> big               </td><td> CRC-16/CCITT-FALSE, CRC-16/CCITT-FFFF </td></tr>
<tr><td> crc16_aug_ccitt </td><td> 16bits             </td><td> big               </td><td> CRC-16/AUG-CCITT, CRC-16/SPI-FUJITSU </td></tr>
<tr><td> crc16_genibus </td><td> 16bits             </td><td> big               </td><td> CRC-16/GENIBUS, CRC-16/EPC, CRC-16/I-CODE, CRC-16/DARC </td></tr>
<tr><td> kermit      </td><td> 16bits             </td><td> little            </td><td> KERMIT, CRC-16/CCITT, CRC-16/CCITT-TRUE, CRC-CCITT </td></tr>
<tr><td> x25         </td><td> 16bits             </td><td> little            </td><td> X-25, CRC-16/IBM-SDLC, CRC-16/ISO-HDLC, CRC-B </td></tr>
<tr><td> crc16_mcrf4xx </td><td> 16bits             </td><td> little            </td><td> CRC-16/MCRF4XX        </td></tr>
<tr><td> crc16_riello </td><td> 16bits             </td><td> little            </td><td> CRC-16/RIELLO         </td></tr>
<tr><td> crc32       </td><td> 32bits             </td><td> little            </td><td> CRC-32, CRC-32/ADCCP, PKZIP </td></tr>
<tr><td> crc32_bzip2 </td><td> 32bits             </td><td> big               </td><td> CRC-32/BZIP2, CRC-32/AAL5, CRC-32/DECT-B, B-CRC-32 </td></tr>
<tr><td> crc32_c     </td><td> 32bits             </td><td> little            </td><td> CRC-32C, CRC-32/ISCSI, CRC-32/CASTAGNOLI </td></tr>
<tr><td> crc32_d     </td><td> 32bits             </td><td> little            </td><td> CRC-32D               </td></tr>
<tr><td> crc32_mpeg2 </td><td> 32bits             </td><td> big               </td><td> CRC-32/MPEG-2         </td></tr>
<tr><td> crc32_posix </td><td> 32bits             </td><td> big               </td><td> CRC-32/POSIX, CKSUM   </td></tr>
<tr><td> crc32_q     </td><td> 32bits             </td><td> big               </td><td> CRC-32Q               </td></tr>
<tr><td> jamcrc      </td><td> 32bits             </td><td> little            </td><td> JAMCRC                </td></tr>
<tr><td> xfer        </td><td> 32bits             </td><td> big               </td><td> XFER                  </td></tr>
<tr><td> crc32_k     </td><td> 32bits             </td><td> big               </td><td> CRC-32K               </td></tr></tbody></table>

<b>notes:</b>
<ul><li>based on <a href='http://reveng.sourceforge.net/crc-catalogue/all.htm'>Catalogue of parametrised CRC algorithms</a><br>we implemented only 8, 16 and 32bits<br>and discarded others or any CRC generating more than 32bits hash.<br>
</li><li>big endian means Msbit-first (Most significant bit first)<br>
</li><li>little endian means Lsbit-first (Least significant bit first)<br>
</li><li>see <a href='http://en.wikipedia.org/wiki/Computation_of_CRC#Bit_ordering_.28Endianness.29'>Computation of CRC - Bit ordering - Endianness</a></li></ul>

<br>

Checksums (TODO, ex: MD2, MD4, MD5, SHA-1, SHA-256, etc.)<br>
<table><thead><th> <b>name</b> </th><th> <b>digest size</b> </th><th> <b>description</b> </th></thead><tbody>
<tr><td>             </td><td>                    </td><td>                    </td></tr></tbody></table>

<br>

Non-cryptographic hash functions<br>
<table><thead><th> <b>name</b> </th><th> <b>digest size</b> </th><th> <b>description</b> </th></thead><tbody>
<tr><td> ap          </td><td> 32bits             </td><td> Arash Partow hash function </td></tr>
<tr><td> bkdr        </td><td> 32bits             </td><td> Brian Kernighan and Dennis Ritchie hash function </td></tr>
<tr><td> brp         </td><td> 32bits             </td><td> Bruno R. Preiss hash function </td></tr>
<tr><td> dek         </td><td> 32bits             </td><td> Donald E. Knuth hash function </td></tr>
<tr><td> djb         </td><td> 32bits             </td><td> Professor Daniel J. Bernstein hash function </td></tr>
<tr><td> elf         </td><td> 32bits             </td><td> ELF hash function  </td></tr>
<tr><td> fnv         </td><td> 32bits             </td><td> Fowler–Noll–Vo hash function </td></tr>
<tr><td> js          </td><td> 32bits             </td><td> Justin Sobel hash function </td></tr>
<tr><td> pjw         </td><td> 32bits             </td><td> Peter J. Weinberger hash function </td></tr>
<tr><td> rs          </td><td> 32bits             </td><td> Robert Sedgwicks hash function </td></tr>
<tr><td> sdbm        </td><td> 32bits             </td><td> open source SDBM project hash function </td></tr></tbody></table>

<h2>Ressources</h2>
<ul><li><a href='http://en.wikipedia.org/wiki/Hash_function'>Hash function</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/Checksum'>Checksums</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/Cyclic_redundancy_check'>Cyclic redundancy check</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/List_of_hash_functions'>List of hash functions</a> (Wikipedia)<br>
</li><li><a href='http://www.partow.net/programming/hashfunctions/index.html'>General Purpose Hash Function Algorithms</a> (Arash Partow)<br>
</li><li><a href='http://home.comcast.net/~bretm/hash/'>Pluto Scarab — Hash Functions</a> (Bret Mulvey) (note: very good explanation of hash functions)<br>
</li><li><a href='http://reveng.sourceforge.net/crc-catalogue/'>Catalogue of parametrised CRC algorithms</a> (SourceForge)<br>
</li><li><a href='http://code.google.com/p/classless-hasher/wiki/ProvidedAlgorithms'>classless-hasher provided algorithms</a> (Google Code)</li></ul>

<h2>TODO</h2>
<ul><li>implement Checksum functions<br>
</li><li>build the command line utilities</li></ul>

<hr />

<h1>Usages</h1>

<h2>Hashing strings</h2>

Simply writes UTF-8 into a bytearray and hash it<br>
<pre><code>import core.hash.elf;<br>
import core.strings.padLeft;<br>
<br>
import flash.utils.ByteArray;<br>
<br>
var bytes:ByteArray = new ByteArray();<br>
      bytes.writeUTFBytes( "hello world" );<br>
<br>
var hash:uint = elf( bytes );<br>
<br>
trace( "ELF hash = " + hash ); //18131988<br>
trace( "hex = " + hash.toString( 16 ) ); //hex = 114ac14<br>
trace( "32bits hex = 0x" + padLeft( hash.toString( 16 ), 8, "0" ) ); //32bits hex = 0x0114ac14<br>
</code></pre>

<br>

<h2>Hashing non-ASCII strings</h2>

If you need to hash non-ASCII strings you should pay attention with the difference<br>
between Unicode and UTF-8.<br>
<br>
When converting non-ASCII to Unicode you will end up with 2 bytes<br>
for ex: <b>ざ</b> gives in Unicode <code>0x3056</code>

When converting non-ASCII to UTF-8 you will end up with variable bytes length<br>
for ex: <b>ざ</b> gives in UTF-8 <code>0xE38196</code> (3 bytes)<br>
<br>
The same string "ざづぜげ" will not generate the same hash, see bellow.<br>
<br>
<pre><code>//UTF-8<br>
var bytes1:ByteArray = new ByteArray();<br>
      bytes1.writeMultiByte( "ざづぜげ", "UTF-8" );<br>
<br>
var hash1:uint = elf( bytes );<br>
<br>
trace( "ELF hash = " + hash1 ); //218292322<br>
trace( "32bits hex = 0x" + padLeft( hash1.toString( 16 ), 8, "0" ) ); //32bits hex = 0x0d02e062<br>
<br>
//Unicode<br>
var bytes2:ByteArray = new ByteArray();<br>
      bytes2.writeMultiByte( "ざづぜげ", "unicodeFFFE" );<br>
<br>
var hash2:uint = elf( bytes );<br>
<br>
trace( "ELF hash = " + hash2 ); //157834242<br>
trace( "32bits hex = 0x" + padLeft( hash2.toString( 16 ), 8, "0" ) ); //32bits hex = 0x09685c02<br>
</code></pre>

Also<br>
<code>bytes.writeUTFBytes( "ざづぜげ" );</code><br>
is the same as<br>
<code>bytes.writeMultiByte( "ざづぜげ", "UTF-8" );</code>

<br>

<h2>Hashing binaries, bytes, files</h2>

Here an example using <b>File</b> and <b>FileStream</b> in AIR<br>
<pre><code>var bytes:ByteArray = new ByteArray();<br>
<br>
var file:File = File.desktopDirectory.resolvePath( "archive.zip" );<br>
var stream:FileStream = new FileStream();<br>
     stream.open( file, FileMode.READ );<br>
     stream.readBytes( bytes );<br>
     stream.close();<br>
<br>
var hash:uint = elf( bytes );<br>
<br>
trace( "ELF hash = " + hash );<br>
trace( "32bits hex = 0x" + padLeft( hash.toString( 16 ), 8, "0" ) );<br>
</code></pre>
<br>