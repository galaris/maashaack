<font color='red'>deprecated - you will find this tool distributed under the RedTamarin SDK</font>

# About #

**swfinfo** is a command-line tool made with [redtamarin](http://code.google.com/p/redtamarin/)
which allows to parse the informations of a `*.swf` file.

| **browse** | [/tools/swfinfo/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Ftools%2Fswfinfo%2Ftrunk) |
|:-----------|:--------------------------------------------------------------------------------------------------------|
| **checkout** | `svn checkout http://maashaack.googlecode.com/svn/tools/swfinfo/trunk/ swfinfo-read-only`               |

<img src='http://maashaack.googlecode.com/svn/gfx/download.png' align='left' />
[Linux](http://maashaack.googlecode.com/files/swfinfo_1.0_NIX.zip)<br>
<a href='http://maashaack.googlecode.com/files/swfinfo_1.0_OSX.zip'>OSX 10.6</a><br>
<a href='http://maashaack.googlecode.com/files/swfinfo_1.0_OSX105.zip'>OSX 10.5</a><br>
<a href='http://maashaack.googlecode.com/files/swfinfo_1.0_WIN.zip'>Windows</a>
<br>
<br>
<br>
<br>
<br>
<b>notes:</b><br>
<ul><li>OS X and Linux file probably require to be chmoded<br><code>$ chmod +x swfinfo</code>
</li><li>Linux binary is compiled for Ubuntu</li></ul>

<br>
<br>

<h1>Introduction</h1>
As a programmer when you deal with <b>SWF</b> files,<br>
there is always a time when you need tidbit of infos<br>
or much much more infos.<br>
<br>
<b>swfinfo</b> will provide these kind of infos<br>
<br>
Here the list of tags the program know how to parse<br>
<ul><li>Metadata<br>
</li><li>SetBackgroundColor<br>
</li><li>ProductInfo<br>
</li><li>FrameLabel<br>
</li><li>ScriptLimits<br>
</li><li>FileAttributes</li></ul>

Hopefully with time more tags will be parsed.<br>
<br>
<br>

<h1>Installation</h1>

Unzip somewhere in your file system and be sure the program is accessible from the command line.<br>
<br>
HOWTO install command line tools Windows - TODO<br>
HOWTO install command line tools OSX - TODO<br>
HOWTO install command line tools Linux - TODO<br>

<br>
<br>


<hr />
<h1>Documentation</h1>

<h2>Usage</h2>
<pre><code>swfinfo [-h] [-v] [-L] [-s] [-o:val[=opt]] [-p] [-a] [-u] [-k] [-x] [-n] [-t:val] [-g:val] [-w:val] file<br>
</code></pre>

<b>Options</b>
<pre><code>  file           a local &lt;file&gt; or remote &lt;file&gt;<br>
                 in case of a  remote file, need to be a valid URL<br>
                 eg. starting with http/ftp/etc.<br>
<br>
  -h             this help<br>
  <br>
  -v             to see the program version<br>
  <br>
  -L             License and program informations<br>
<br>
  -s             save a remote file<br>
                 on the current local directory<br>
<br>
  -o:val[=opt]   single line output configured by &lt;opt&gt;<br>
                 when you use this mode the program will return<br>
                 only the info from &lt;opt&gt; and nothing else<br>
                 &lt;val&gt; can be:<br>
                 * type, filetype<br>
                   returns the signature+version (ex: SWF10)<br>
                 * sign, signature<br>
                   returns the signature (ex: SWC)<br>
                 * version<br>
                   returns the version (ex: 9)<br>
                 * rect, rectangle<br>
                   returns the rectangle (ex: x=0, y=0, w=550, h=400)<br>
                 * fps, rate<br>
                   returns the frame rate (ex: 24)<br>
                 * frame, frames<br>
                   returns the frame count (ex: 5)<br>
                 * size [=B, K, M, G, T, P, E, Z, Y]<br>
                   returns the uncompressed file size<br>
                 * unzip, unzipped, uncompressed [=B, K, M, G, T, P, E, Z, Y]<br>
                   returns the compressed file size<br>
                 * metadata [=pp]<br>
                   returns the metadata tag content if found<br>
                 * date, time, timestamp [=string]<br>
                   returns the compilation date if found (ex: 1294419029461)<br>
                 * sdk, sdkversion<br>
                   returns the Flex SDK version if found (ex: 4.0.0.7219)<br>
                 * bgcolor [=hex, rgb]<br>
                   returns the background color of the SWF<br>
                 * labels<br>
                   returns the labell names of the SWF<br>
                 * recursion<br>
                   returns the max recursion limit<br>
                 * timeout<br>
                   returns the script timeout limit<br>
                 * direct, blit<br>
                   returns if the SWF use direct blit<br>
                 * gpu<br>
                   returns if the SWF use GPU<br>
                 * as3<br>
                   returns if the SWF use AS3<br>
                 * network<br>
                   returns if the SWF use network<br>
<br>
  -p             parse SWF tags<br>
                 this option need to be present for<br>
                 -a -u -k -x -n -t options<br>
<br>
  -a             display only the SWF tags header<br>
<br>
  -n             not parsed valid SWF tags will output hex data<br>
                 output is limited by option -t<br>
<br>
  -x             parsed valid SWF tags will output hex data<br>
                 output is limited by option -t<br>
<br>
  -u             unknown SWF tags hex data will not be truncated<br>
<br>
  -k             known SWF tags hex data will not be truncated<br>
<br>
  -t:val         truncate SWF tags hex data from 0 to &lt;val&gt;<br>
                 default &lt;val&gt; is 200<br>
<br>
  -g:val         group hex data by the amount of &lt;val&gt;<br>
                 default &lt;val&gt; is 8<br>
<br>
  -w:val         try to limit the width of the hex data by a certain &lt;val&gt;<br>
                 default &lt;val&gt; is 80<br>
</code></pre>

By default, the program parse only the SWF header.<br>
If you need SWF tags informations you HAVE TO use option <b>-p</b>.<br>
<br>
We have different SWF tags:<br>
<ul><li>known:        the tag id is in the range of SWF tags (0 to 91)<br>
</li><li>parsed:       a known SWF tag that the program know how to parse<br>
</li><li>not parsed:   a known SWF tag that the program dow not know how to parse yet<br>
</li><li>unknown:      any SWF tag outside of the known range</li></ul>

By default, a known parsed SWF tag does not output hex data.<br>
<br>
<br>
<h2>Examples</h2>

<b>default</b>

<code>$ swfinfo test.swf</code>
<pre><code>[ SWC9 rect=(x=0, y=0, w=550, h=400), fps=24, frames=5, size=160.66 KB (unzipped=297.61 KB) ]<br>
</code></pre>

without any options <code>swfinfo</code> will return a one liner<br>
<ul><li>the signature<br>SWF or SWC (compressed)<br>
</li><li>the version<br> 9, 10, etc.<br>
</li><li>the rectangle coordinates<br>
</li><li>the frame rate in seconds<br>
</li><li>the number of frames<br>
</li><li>the size<br>
</li><li>the unzipped size<br>(if the file is compressed)</li></ul>


<b>selected output</b>

you can output even shorter informations with the option <b>-o</b>

<code>$ swfinfo -o:size test.swf</code>
<pre><code>160.66 KB<br>
</code></pre>


<code>$ swfinfo -o:size=M test.swf</code>
<pre><code>0.16 MB<br>
</code></pre>

<code>$ swfinfo -o:unzip test.swf</code>
<pre><code>297.61 KB<br>
</code></pre>

<code>$ swfinfo -o:fps test.swf</code>
<pre><code>24<br>
</code></pre>

etc.<br>
<br>
for <b>size</b> and <b>unzip</b> (unzipped, uncompressed) you can also force the output to<br>
<ul><li>B for bytes<br>
</li><li>M for MegaBytes<br>
</li><li>G for GigaBytes<br>
</li><li>T for TeraBytes<br>
</li><li>etc. (Peta, Exa, Zetta, Yotta)</li></ul>

for <b>metadata</b> you can force the output to <b>pp</b><br>
that will pretty print the XML (with spaces and indentations)<br>
(the default is non-formated all on a single line)<br>
<br>
<code>$ swfinfo -o:metadata test.swf</code>
<pre><code>&lt;rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'&gt;&lt;rdf:Description rdf:about='' xmlns:dc='http://purl.org/dc/elements/1.1'&gt;&lt;dc:format&gt;application/x-shockwave-flash&lt;/dc:format&gt;&lt;dc:title&gt;Adobe Flex 4 Application&lt;/dc:title&gt;&lt;dc:description&gt;http://www.adobe.com/products/flex&lt;/dc:description&gt;&lt;dc:publisher&gt;unknown&lt;/dc:publisher&gt;&lt;dc:creator&gt;unknown&lt;/dc:creator&gt;&lt;dc:language&gt;EN&lt;/dc:language&gt;&lt;dc:date&gt;07-Jan-2011&lt;/dc:date&gt;&lt;/rdf:Description&gt;&lt;/rdf:RDF&gt;<br>
</code></pre>

<code>$ swfinfo -o:metadata=pp test.swf</code>
<pre><code>&lt;rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"&gt;<br>
  &lt;rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1"&gt;<br>
    &lt;dc:format&gt;application/x-shockwave-flash&lt;/dc:format&gt;<br>
    &lt;dc:title&gt;Adobe Flex 4 Application&lt;/dc:title&gt;<br>
    &lt;dc:description&gt;http://www.adobe.com/products/flex&lt;/dc:description&gt;<br>
    &lt;dc:publisher&gt;unknown&lt;/dc:publisher&gt;<br>
    &lt;dc:creator&gt;unknown&lt;/dc:creator&gt;<br>
    &lt;dc:language&gt;EN&lt;/dc:language&gt;<br>
    &lt;dc:date&gt;07-Jan-2011&lt;/dc:date&gt;<br>
  &lt;/rdf:Description&gt;<br>
&lt;/rdf:RDF&gt;<br>
</code></pre>

for <b>date</b> (time, timestamp) you can force the output to <b>string</b><br>
(the default is the time in milliseconds, like a date valueOf)<br>
<br>
<code>$ swfinfo -o:date test.swf</code>
<pre><code>1294419029461<br>
</code></pre>

<code>$ swfinfo -o:date=string test.swf</code>
<pre><code>Fri Jan 7 16:50:29 GMT+0000 2011<br>
</code></pre>


<b>detailled output</b>

You can have more details as soon as you use the option <b>-p</b> (eg. parse the SWF tags in the file).<br>
<br>
<code>$ swfinfo -p test.swf</code>
<pre><code>[ SWC9 rect=(x=0, y=0, w=550, h=400), fps=24, frames=5, size=160.66 KB (unzipped=297.61 KB)<br>
  tag 0x45: FileAttributes | size: 4 B | ratio: 0.001%<br>
  tag 0x4d: Metadata | size: 458 B | ratio: 0.150%<br>
      |__   &lt;rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'&gt;<br>
            &lt;rdf:Description rdf:about='' xmlns:dc='http://purl.org/dc/elements/1.1'&gt;<br>
            &lt;dc:format&gt;application/x-shockwave-flash&lt;/dc:format&gt;<br>
            &lt;dc:title&gt;Adobe Flex 4 Application&lt;/dc:title&gt;<br>
            &lt;dc:description&gt;http://www.adobe.com/products/flex&lt;/dc:description&gt;<br>
            &lt;dc:publisher&gt;unknown&lt;/dc:publisher&gt;<br>
            &lt;dc:creator&gt;unknown&lt;/dc:creator&gt;<br>
            &lt;dc:language&gt;EN&lt;/dc:language&gt;<br>
            &lt;dc:date&gt;07-Jan-2011&lt;/dc:date&gt;<br>
            &lt;/rdf:Description&gt;<br>
            &lt;/rdf:RDF&gt;<br>
  tag 0x41: ScriptLimits | size: 4 B | ratio: 0.001%<br>
  tag 0x09: SetBackgroundColor | size: 3 B | ratio: 0.001%<br>
  tag 0x29: ProductInfo | size: 26 B | ratio: 0.009%<br>
      |__   productId: 3 (Adobe Flex)<br>
            edition: 6 (None)<br>
            version: Flex SDK v4.0.0.7219<br>
            compile Date: Fri Jan 7 16:50:29 GMT+0000 2011<br>
  tag 0x2b: FrameLabel | size: 12 B | ratio: 0.004%<br>
  tag 0x02: DefineShape | size: 50 B | ratio: 0.016%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x27: DefineSprite | size: 224 B | ratio: 0.074%<br>
  tag 0x38: ExportAssets | size: 50 B | ratio: 0.016%<br>
  tag 0x52: DoABC2 | size: 10.61 KB | ratio: 3.566%<br>
  tag 0x4c: SymbolClass | size: 64 B | ratio: 0.021%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x02: DefineShape | size: 66 B | ratio: 0.022%<br>
  tag 0x2e: DefineMorphShape | size: 77 B | ratio: 0.025%<br>
  tag 0x02: DefineShape | size: 679 B | ratio: 0.223%<br>
  tag 0x0e: DefineSound | size: 3.36 KB | ratio: 1.129%<br>
  tag 0x02: DefineShape | size: 389 B | ratio: 0.128%<br>
  tag 0x27: DefineSprite | size: 23 B | ratio: 0.008%<br>
  tag 0x02: DefineShape | size: 33 B | ratio: 0.011%<br>
  tag 0x02: DefineShape | size: 470 B | ratio: 0.154%<br>
  tag 0x20: DefineShape3 | size: 86 B | ratio: 0.028%<br>
  tag 0x0e: DefineSound | size: 1.23 KB | ratio: 0.412%<br>
  tag 0x02: DefineShape | size: 549 B | ratio: 0.180%<br>
  tag 0x27: DefineSprite | size: 2.47 KB | ratio: 0.830%<br>
  tag 0x38: ExportAssets | size: 40 B | ratio: 0.013%<br>
  tag 0x52: DoABC2 | size: 25.79 KB | ratio: 8.666%<br>
  tag 0x4c: SymbolClass | size: 40 B | ratio: 0.013%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x4b: DefineFont3 | size: 10.67 KB | ratio: 3.584%<br>
  tag 0x49: DefineFontAlignZones | size: 953 B | ratio: 0.313%<br>
  tag 0x58: DefineFontName | size: 62 B | ratio: 0.020%<br>
  tag 0x4b: DefineFont3 | size: 10.57 KB | ratio: 3.552%<br>
  tag 0x49: DefineFontAlignZones | size: 953 B | ratio: 0.313%<br>
  tag 0x58: DefineFontName | size: 62 B | ratio: 0.020%<br>
  tag 0x52: DoABC2 | size: 6.66 KB | ratio: 2.236%<br>
  tag 0x4c: SymbolClass | size: 45 B | ratio: 0.015%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x52: DoABC2 | size: 3.67 KB | ratio: 1.232%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x16: DefineShape2 | size: 141 B | ratio: 0.046%<br>
  tag 0x4b: DefineFont3 | size: 14 B | ratio: 0.005%<br>
  tag 0x49: DefineFontAlignZones | size: 3 B | ratio: 0.001%<br>
  tag 0x25: DefineEditText | size: 53 B | ratio: 0.017%<br>
  tag 0x4a: CSMSettings | size: 12 B | ratio: 0.004%<br>
  tag 0x16: DefineShape2 | size: 1.48 KB | ratio: 0.496%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 93 B | ratio: 0.031%<br>
  tag 0x20: DefineShape3 | size: 258 B | ratio: 0.085%<br>
  tag 0x20: DefineShape3 | size: 318 B | ratio: 0.104%<br>
  tag 0x20: DefineShape3 | size: 258 B | ratio: 0.085%<br>
  tag 0x27: DefineSprite | size: 185 B | ratio: 0.061%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x4b: DefineFont3 | size: 13 B | ratio: 0.004%<br>
  tag 0x49: DefineFontAlignZones | size: 3 B | ratio: 0.001%<br>
  tag 0x25: DefineEditText | size: 142 B | ratio: 0.047%<br>
  tag 0x27: DefineSprite | size: 65 B | ratio: 0.021%<br>
  tag 0x27: DefineSprite | size: 76 B | ratio: 0.025%<br>
  tag 0x02: DefineShape | size: 52 B | ratio: 0.017%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x25: DefineEditText | size: 141 B | ratio: 0.046%<br>
  tag 0x25: DefineEditText | size: 141 B | ratio: 0.046%<br>
  tag 0x27: DefineSprite | size: 91 B | ratio: 0.030%<br>
  tag 0x02: DefineShape | size: 54 B | ratio: 0.018%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x02: DefineShape | size: 32 B | ratio: 0.011%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 1.48 KB | ratio: 0.496%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 93 B | ratio: 0.031%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x02: DefineShape | size: 32 B | ratio: 0.011%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 108 B | ratio: 0.035%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x27: DefineSprite | size: 47 B | ratio: 0.015%<br>
  tag 0x25: DefineEditText | size: 32 B | ratio: 0.011%<br>
  tag 0x27: DefineSprite | size: 122 B | ratio: 0.040%<br>
  tag 0x38: ExportAssets | size: 228 B | ratio: 0.075%<br>
  tag 0x52: DoABC2 | size: 210.83 KB | ratio: 70.843%<br>
  tag 0x4c: SymbolClass | size: 228 B | ratio: 0.075%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x00: End | size: 0 B | ratio: 0.000%<br>
 ]<br>
</code></pre>

here the default behaviour when we parse the SWF tags<br>
<ul><li>all tags are listed by their hex code/name/size/ratio<br>
</li><li>if the parser know how to decompile a certain tag<br>it will display a friendly output<br>
</li><li>on certain tags, the parser may display a comment<br>for ex: with known obfuscated tags</li></ul>

if you don't wan the tags details add the option <b>-a</b> to display only the header<br>
<br>
<code>$ swfinfo -p -a test.swf</code>
<pre><code>[ SWC9 rect=(x=0, y=0, w=550, h=400), fps=24, frames=5, size=160.66 KB (unzipped=297.61 KB)<br>
  tag 0x45: FileAttributes | size: 4 B | ratio: 0.001%<br>
  tag 0x4d: Metadata | size: 458 B | ratio: 0.150%<br>
  tag 0x41: ScriptLimits | size: 4 B | ratio: 0.001%<br>
  tag 0x09: SetBackgroundColor | size: 3 B | ratio: 0.001%<br>
  tag 0x29: ProductInfo | size: 26 B | ratio: 0.009%<br>
  tag 0x2b: FrameLabel | size: 12 B | ratio: 0.004%<br>
  tag 0x02: DefineShape | size: 50 B | ratio: 0.016%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x27: DefineSprite | size: 224 B | ratio: 0.074%<br>
  tag 0x38: ExportAssets | size: 50 B | ratio: 0.016%<br>
  tag 0x52: DoABC2 | size: 10.61 KB | ratio: 3.566%<br>
  tag 0x4c: SymbolClass | size: 64 B | ratio: 0.021%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x02: DefineShape | size: 66 B | ratio: 0.022%<br>
  tag 0x2e: DefineMorphShape | size: 77 B | ratio: 0.025%<br>
  tag 0x02: DefineShape | size: 679 B | ratio: 0.223%<br>
  tag 0x0e: DefineSound | size: 3.36 KB | ratio: 1.129%<br>
  tag 0x02: DefineShape | size: 389 B | ratio: 0.128%<br>
  tag 0x27: DefineSprite | size: 23 B | ratio: 0.008%<br>
  tag 0x02: DefineShape | size: 33 B | ratio: 0.011%<br>
  tag 0x02: DefineShape | size: 470 B | ratio: 0.154%<br>
  tag 0x20: DefineShape3 | size: 86 B | ratio: 0.028%<br>
  tag 0x0e: DefineSound | size: 1.23 KB | ratio: 0.412%<br>
  tag 0x02: DefineShape | size: 549 B | ratio: 0.180%<br>
  tag 0x27: DefineSprite | size: 2.47 KB | ratio: 0.830%<br>
  tag 0x38: ExportAssets | size: 40 B | ratio: 0.013%<br>
  tag 0x52: DoABC2 | size: 25.79 KB | ratio: 8.666%<br>
  tag 0x4c: SymbolClass | size: 40 B | ratio: 0.013%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x4b: DefineFont3 | size: 10.67 KB | ratio: 3.584%<br>
  tag 0x49: DefineFontAlignZones | size: 953 B | ratio: 0.313%<br>
  tag 0x58: DefineFontName | size: 62 B | ratio: 0.020%<br>
  tag 0x4b: DefineFont3 | size: 10.57 KB | ratio: 3.552%<br>
  tag 0x49: DefineFontAlignZones | size: 953 B | ratio: 0.313%<br>
  tag 0x58: DefineFontName | size: 62 B | ratio: 0.020%<br>
  tag 0x52: DoABC2 | size: 6.66 KB | ratio: 2.236%<br>
  tag 0x4c: SymbolClass | size: 45 B | ratio: 0.015%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x52: DoABC2 | size: 3.67 KB | ratio: 1.232%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
  tag 0x16: DefineShape2 | size: 141 B | ratio: 0.046%<br>
  tag 0x4b: DefineFont3 | size: 14 B | ratio: 0.005%<br>
  tag 0x49: DefineFontAlignZones | size: 3 B | ratio: 0.001%<br>
  tag 0x25: DefineEditText | size: 53 B | ratio: 0.017%<br>
  tag 0x4a: CSMSettings | size: 12 B | ratio: 0.004%<br>
  tag 0x16: DefineShape2 | size: 1.48 KB | ratio: 0.496%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 93 B | ratio: 0.031%<br>
  tag 0x20: DefineShape3 | size: 258 B | ratio: 0.085%<br>
  tag 0x20: DefineShape3 | size: 318 B | ratio: 0.104%<br>
  tag 0x20: DefineShape3 | size: 258 B | ratio: 0.085%<br>
  tag 0x27: DefineSprite | size: 185 B | ratio: 0.061%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x4b: DefineFont3 | size: 13 B | ratio: 0.004%<br>
  tag 0x49: DefineFontAlignZones | size: 3 B | ratio: 0.001%<br>
  tag 0x25: DefineEditText | size: 142 B | ratio: 0.047%<br>
  tag 0x27: DefineSprite | size: 65 B | ratio: 0.021%<br>
  tag 0x27: DefineSprite | size: 76 B | ratio: 0.025%<br>
  tag 0x02: DefineShape | size: 52 B | ratio: 0.017%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x25: DefineEditText | size: 141 B | ratio: 0.046%<br>
  tag 0x25: DefineEditText | size: 141 B | ratio: 0.046%<br>
  tag 0x27: DefineSprite | size: 91 B | ratio: 0.030%<br>
  tag 0x02: DefineShape | size: 54 B | ratio: 0.018%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x02: DefineShape | size: 32 B | ratio: 0.011%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 1.48 KB | ratio: 0.496%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 93 B | ratio: 0.031%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x02: DefineShape | size: 32 B | ratio: 0.011%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x16: DefineShape2 | size: 108 B | ratio: 0.035%<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
  tag 0x27: DefineSprite | size: 47 B | ratio: 0.015%<br>
  tag 0x25: DefineEditText | size: 32 B | ratio: 0.011%<br>
  tag 0x27: DefineSprite | size: 122 B | ratio: 0.040%<br>
  tag 0x38: ExportAssets | size: 228 B | ratio: 0.075%<br>
  tag 0x52: DoABC2 | size: 210.83 KB | ratio: 70.843%<br>
  tag 0x4c: SymbolClass | size: 228 B | ratio: 0.075%<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x00: End | size: 0 B | ratio: 0.000%<br>
 ]<br>
</code></pre>

at the opposite if you want more details in hexadecimal output use the options <b>-n</b>, <b>-x</b>, <b>-u</b>, <b>-k</b>

<code>$ swfinfo -p -n test.swf</code>
<pre><code>[ SWC9 rect=(x=0, y=0, w=550, h=400), fps=24, frames=5, size=160.66 KB (unzipped=297.61 KB)<br>
  tag 0x45: FileAttributes | size: 4 B | ratio: 0.001%<br>
      |__   19000000 <br>
  tag 0x4d: Metadata | size: 458 B | ratio: 0.150%<br>
      |__   &lt;rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'&gt;<br>
            &lt;rdf:Description rdf:about='' xmlns:dc='http://purl.org/dc/elements/1.1'&gt;<br>
            &lt;dc:format&gt;application/x-shockwave-flash&lt;/dc:format&gt;<br>
            &lt;dc:title&gt;Adobe Flex 4 Application&lt;/dc:title&gt;<br>
            &lt;dc:description&gt;http://www.adobe.com/products/flex&lt;/dc:description&gt;<br>
            &lt;dc:publisher&gt;unknown&lt;/dc:publisher&gt;<br>
            &lt;dc:creator&gt;unknown&lt;/dc:creator&gt;<br>
            &lt;dc:language&gt;EN&lt;/dc:language&gt;<br>
            &lt;dc:date&gt;07-Jan-2011&lt;/dc:date&gt;<br>
            &lt;/rdf:Description&gt;<br>
            &lt;/rdf:RDF&gt;<br>
  tag 0x41: ScriptLimits | size: 4 B | ratio: 0.001%<br>
      |__   e8033c00 <br>
  tag 0x09: SetBackgroundColor | size: 3 B | ratio: 0.001%<br>
      |__   ffffff <br>
  tag 0x29: ProductInfo | size: 26 B | ratio: 0.009%<br>
      |__   productId: 3 (Adobe Flex)<br>
            edition: 6 (None)<br>
            version: Flex SDK v4.0.0.7219<br>
            compile Date: Fri Jan 7 16:50:29 GMT+0000 2011<br>
  tag 0x2b: FrameLabel | size: 12 B | ratio: 0.004%<br>
      |__   67616d65 6d616e61 67657200 <br>
  tag 0x02: DefineShape | size: 50 B | ratio: 0.016%<br>
      |__   01007000 0fa00000 bb800110 84bd63ec 1806be81 6a200200 326598ff 00336600 2015cfa0 <br>
            2ee0f841 81e34487 83e81e2b b800 <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   02000100 87060601 00010002 00400000 00 <br>
  tag 0x27: DefineSprite | size: 224 B | ratio: 0.074%<br>
      |__   03001100 87060601 00020002 004000c8 0a666164 656f7574 00400089 06090100 69004010 <br>
            03bc4000 89060901 00690040 10037840 00890609 01006900 40100334 40008906 09010069 <br>
            00401002 f0400089 06090100 69004010 02ac4000 89060901 00690040 10026840 00890609 <br>
            01006900 40100224 40008906 09010069 00401001 dc400089 06090100 69004010 01984000 <br>
            89060901 00690040 10015440 00890609 01006900 40100110 40008906 09010069 00401000 <br>
            cc400089 06090100 69004010 00884000 89060901 ...<br>
  tag 0x38: ExportAssets | size: 50 B | ratio: 0.016%<br>
      |__   01000300 636f6d2e 6d696e69 636c6970 2e67616d 656d616e 61676572 2e75692e 496e7472 <br>
            6f426163 6b67726f 756e6455 4900 <br>
  tag 0x52: DoABC2 | size: 10.61 KB | ratio: 3.566%<br>
      |__   01000000 6672616d 65310010 002e0006 008080fc 07ffffff 7f808080 78ffff03 00050000 <br>
            00000000 e03f0000 e0ff1fe0 ef410000 e0ffff1f ee410000 0000e0ff ef41b202 0004766f <br>
            69640c66 6c617368 2e657665 6e747305 4576656e 74047569 6e740653 7472696e 6707426f <br>
            6f6c6561 6e0d666c 6173682e 64697370 6c617909 4d6f7669 65436c69 700d4469 73706c61 <br>
            794f626a 65637416 44697370 6c61794f 626a6563 74436f6e 7461696e 6572064f 626a6563 <br>
            74064c6f 61646572 03696e74 012e064e 756d6265 ...<br>
  tag 0x4c: SymbolClass | size: 64 B | ratio: 0.021%<br>
      |__   02000300 636f6d2e 6d696e69 636c6970 2e67616d 656d616e 61676572 2e75692e 496e7472 <br>
            6f426163 6b67726f 756e6455 49000000 67616d65 6d616e61 67657200 <br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
      |__   3200 <br>
  tag 0x02: DefineShape | size: 66 B | ratio: 0.022%<br>
      |__   0400556a a5e067e0 011084ad fa40e18e 0200ff8a 00ffe600 12002015 4a5e06f0 bf3b954d <br>
            daaefbfa af7e02ab baabdcaa 70d43a90 f76cdb8e 8de8155e f40d5771 5800 <br>
  tag 0x2e: DefineMorphShape | size: 77 B | ratio: 0.025%<br>
      |__   05005f85 4e5ac4cf 006d5799 0feb10cf 00270000 000100cc 0000ffcc 0000ff01 00000000 <br>
            00000000 00000000 222d5c2d 62bc8bb7 9576f251 3e5a2600 0005b55e f58f82e5 3cabb7c2 <br>
            8d7e5a26 00 <br>
  tag 0x02: DefineShape | size: 679 B | ratio: 0.223%<br>
      |__   06006d36 5649eea0 84000b10 84b10f2f 114a1ff2 0200ff99 00ffcc00 001084b1 0f2f116b <br>
            dbfc8002 00ff9900 ffcc0000 1084b10f 2f118b0d ff200200 ff9900ff cc000010 84b10f2f <br>
            118f49ff 200200ff 9900ffcc 00001084 b10f2f11 aa00ffc8 0200ff99 00ffcc00 001084b1 <br>
            0f2f1112 1f200200 ff9900ff cc000010 84b10f2f 11b63aff c80200ff 9900ffcc 00001084 <br>
            b10f2f11 93ddff20 0200ff99 00ffcc00 001084b1 0f2f1190 77ff2002 00ff9900 ffcc0000 <br>
            1084b10f 2f119743 ff200200 ff9900ff cc000010 ...<br>
  tag 0x0e: DefineSound | size: 3.36 KB | ratio: 1.129%<br>
      |__   0700268d 4000007d 06ffe320 c0000000 02580000 00000403 02840810 204081b9 ce68d1a3 <br>
            6c1c0416 0f83e080 20081c82 008060a0 3efd3fff f04c1f3f 83e1ffff ff07010e 083ab070 <br>
            10040100 c3c1f07c 3fffea0c 07f940c4 10000e1b 0d88d593 5b6fbd98 f2d2c0d1 a44bfb00 <br>
            a5b4c531 04ffe320 c05b10c0 45fc0149 0000133e b8abdf36 d3dcc2c0 48f09cd9 1efdd0d0 <br>
            c962cdb5 b3c9b758 36011413 925c2139 7a866c05 22642088 3c1fa8ce e7d8df0b fc2a4017 <br>
            46242726 acf7efdc f727bfe9 2b42a2a7 0b2e4108 ...<br>
  tag 0x02: DefineShape | size: 389 B | ratio: 0.128%<br>
      |__   08007000 0b550000 15180100 ffffff00 200dcb55 0000ee43 f4e6a63e 76d5beed aa83cb75 <br>
            a76c7722 3bc028ed 76284d4b 4b05fba1 7cd04074 cb7252b5 ed6edcb7 21b34101 d2adcfa2 <br>
            2e801092 80623564 b6adcc01 aed0698e f0002aa6 01a0b4bb 9aeb027f fb92b8f0 af1c1567 <br>
            0d11c97f a7bc00f3 c59c532c e5b99c6e cfb92f76 ca8cb977 dee53e53 a37ffef2 5dad3927 <br>
            8877e710 9bf3b7cc b979ed2e 0b0b8505 d83fe15d f8117d9a adab2f1b 56a1f655 f9187f0d <br>
            f9a5c566 37380573 dbfe89c8 84f76832 9a6ec974 ...<br>
  tag 0x27: DefineSprite | size: 23 B | ratio: 0.008%<br>
      |__   09000100 440b0600 00008706 06010008 00020040 000000 <br>
  tag 0x02: DefineShape | size: 33 B | ratio: 0.011%<br>
      |__   0a006d57 990feb10 cf000100 cc000000 2015ac87 f58bcabb 7c28d7e5 a27e0b94 80 <br>
            <br>
  tag 0x02: DefineShape | size: 470 B | ratio: 0.154%<br>
      |__   0b006d6d 17ffeec0 85000100 ff000000 201569eb 763ca87b 7291cb78 b71700ad bafccdc4 <br>
            0cad8000 af281ad2 406e5ff6 54c16254 f90cc766 c0099300 26629b4d 8a6b5a01 b95add58 <br>
            6e52796f 1702bb32 9801d9a8 2c5ccf3b 993ec5c0 037177ba a6dca2cb 500623d2 e23e0164 <br>
            a0159e3f 29e3eb00 6e2ef754 db9459a4 002c2c66 b1b00090 98024142 c0163dff 9dcca162 <br>
            e0013378 02827cc9 ea000e13 0037d8a8 4d60a122 01347805 8d8cd636 00121300 4827d802 <br>
            d43ffe4a 5a80311e 9709f00b 2500acf9 f94f1f58 ...<br>
  tag 0x20: DefineShape3 | size: 86 B | ratio: 0.028%<br>
      |__   0c005ce5 6373958d 800112b5 958cac04 0300ffff ffbea4ff ffff66f8 ffffff00 00201568 <br>
            cae7341d 274800a4 d0002938 b9d3462e 74d6e005 15b8018b e2f462f8 b8015bd0 0056e74e <br>
            2f41d38b a920050a 4800749d 2000 <br>
  tag 0x0e: DefineSound | size: 1.23 KB | ratio: 0.412%<br>
      |__   0d0026fc 0f00007d 06ffe320 c0000000 02580140 00003001 00038100 80402800 0c007d40 <br>
            d8303ddd 981b1f03 806b78a4 4bdf8560 00880a47 bf097118 3c5dfed8 c39b8140 28bfefec <br>
            0db25894 0e617479 ff6fc034 027017c1 c8606837 7ff7fc27 827039c7 b94ca638 0a03a7ff <br>
            fff85dc7 98ffe320 c05b2003 e245bf94 6800c199 92e390b8 81ba0c25 1fffffbb edc9e533 <br>
            45bbe266 4bc721a4 dfffffff ffff3e5c 34303436 adaaa90f ff9d2279 0609419f 7ecda0e4 <br>
            a1d1de90 f8b8781c 41bc85e5 3bcce95e 13945b12 ...<br>
  tag 0x02: DefineShape | size: 549 B | ratio: 0.180%<br>
      |__   0e006d1c 15b9fa40 46800100 ffffff00 2015488f 48eeba76 2e6600bd e2e192cb 290365db <br>
            62e3762f 88a56601 49395292 1c5f5626 c2382b4a bff755b6 c4ae8a5b 88fd948d c946ec5f <br>
            71b1b291 b971d147 61ac1624 77d26c31 eca46c4e c968199b 2666009c 802669b2 1a6a6068 <br>
            37ab2b61 2365fb62 7659e02f 5e96f5e0 13e50145 15d9515e 62001631 77d26f27 ba762d74 <br>
            ed1ec57e 9d9dd8b4 de508bec 2e82c757 fa4da6a9 fb4dac76 12375d3b 171b363b 7293f6e5 <br>
            d8eca7ec 5beec5f6 12416a38 fffbb0d9 aadb6253 ...<br>
  tag 0x27: DefineSprite | size: 2.47 KB | ratio: 0.830%<br>
      |__   0f005d00 440b0600 00008d06 06010004 00d11919 1191903e 40400040 00400040 00400040 <br>
            008b0605 0100d167 2c9672c8 3c804000 8b060501 00d19606 9960683c 8040008b 06050100 <br>
            d1a5a61a 5a603e40 40008c06 050100d1 24e1d24e 1c863020 40008c06 050100cd 817db02f <br>
            b2564010 40008c06 050100c9 e4db7936 c9750040 40008c06 050100c9 39334e4c ca430010 <br>
            40008706 05010014 8b802089 06460200 05000200 04008a06 06030006 001ab030 01004000 <br>
            02070100 85061102 001e0288 06050300 1aaee001 ...<br>
  tag 0x38: ExportAssets | size: 40 B | ratio: 0.013%<br>
      |__   01000f00 636f6d2e 6d696e69 636c6970 2e67616d 656d616e 61676572 2e75692e 496e7472 <br>
            6f554900 <br>
  tag 0x52: DoABC2 | size: 25.79 KB | ratio: 8.666%<br>
      |__   01000000 6672616d 65320010 002e0009 c8010006 47ffffff ff0f0504 ffffff07 00027b14 <br>
            ae47e17a 843f8404 0004766f 69640d66 6c617368 2e646973 706c6179 094d6f76 6965436c <br>
            69700c66 6c617368 2e657665 6e747305 4576656e 7407426f 6f6c6561 6e18636f 6d2e6d69 <br>
            6e69636c 69702e67 616d656d 616e6167 6572104d 696e6963 6c697042 61636b6c 696e6b0a <br>
            4d6f7573 65457665 6e740d44 6973706c 61794f62 6a656374 06537472 696e6706 63656e74 <br>
            6572064e 756d6265 720c494f 4572726f 72457665 ...<br>
  tag 0x4c: SymbolClass | size: 40 B | ratio: 0.013%<br>
      |__   01000f00 636f6d2e 6d696e69 636c6970 2e67616d 656d616e 61676572 2e75692e 496e7472 <br>
            6f554900 <br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
      |__   3300 <br>
  tag 0x4b: DefineFont3 | size: 10.67 KB | ratio: 3.584%<br>
      |__   10008500 0b546168 6f6d6142 6f6c6400 5f00c000 c200e700 10018301 7502d203 26053c05 <br>
            b8053406 8206aa06 bf06d106 e306fa06 ab07e607 73088909 be097e0a 7e0b9c0b d80cf10d <br>
            120e370e 590e7c0e 9e0e340f b610e810 c1118512 0c133413 5713f413 1c144414 a914d914 <br>
            f1142315 4a15f715 94168517 0a18eb18 08195819 7a19b419 ea19111a 381a551a 6c1a891a <br>
            aa1abc1a d11a931b 181ccd1c 681d101e 6d1e621f be1fe01f 3c206c20 7e202b21 87212f22 <br>
            b3224e23 a1239524 fc245825 7925b125 e5250b26 ...<br>
  tag 0x49: DefineFontAlignZones | size: 953 B | ratio: 0.313%<br>
      |__   10004002 00000000 00000000 00020000 00000000 00000002 00000000 00000000 00020000 <br>
            00000000 00000002 00000000 00000000 00020000 00000000 00000002 00000000 00000000 <br>
            00020000 00000000 00000002 00000000 00000000 00020000 00000000 00000002 00000000 <br>
            00000000 00020000 00000000 00000002 00000000 00000000 00020000 00000000 00000002 <br>
            00000000 00000000 00020000 00000000 00000002 00000000 00000000 00020000 00000000 <br>
            00000002 00000000 00000000 00020000 00000000 ...<br>
  tag 0x58: DefineFontName | size: 62 B | ratio: 0.020%<br>
      |__   10005461 686f6d61 00efbea9 20323030 34204d69 63726f73 6f667420 436f7270 6f726174 <br>
            696f6e2e 20416c6c 20726967 68747320 72657365 72766564 2e00 <br>
  tag 0x4b: DefineFont3 | size: 10.57 KB | ratio: 3.552%<br>
      |__   11008400 0e546168 6f6d6152 6567756c 6172005f 00c000c2 00e7000f 0183016c 027303b1 <br>
            04c60429 058c05da 05020617 0629063b 065106ff 062e07d1 07dc0811 09ce09d0 0aee0afc <br>
            0bff0c20 0d450d67 0d890dab 0d340e4b 0f7e0f5b 103711c0 11e7110a 12d91201 13281381 <br>
            13b113c9 13fb1322 14ed1475 15801606 17e81705 188418a6 18e01815 193c1962 197f1995 <br>
            19b219d3 19e519fa 19e21a6a 1b131cbc 1c7b1dd6 1db61e13 1f341f9a 1fc91fdb 1f9420f0 <br>
            206f21f5 218722d0 22b7231d 248524a7 24e02415 ...<br>
  tag 0x49: DefineFontAlignZones | size: 953 B | ratio: 0.313%<br>
      |__   11004002 00000000 00000000 00020000 00000000 00000002 00000000 00000000 00020000 <br>
            00000000 00000002 00000000 00000000 00020000 00000000 00000002 00000000 00000000 <br>
            00020000 00000000 00000002 00000000 00000000 00020000 00000000 00000002 00000000 <br>
            00000000 00020000 00000000 00000002 00000000 00000000 00020000 00000000 00000002 <br>
            00000000 00000000 00020000 00000000 00000002 00000000 00000000 00020000 00000000 <br>
            00000002 00000000 00000000 00020000 00000000 ...<br>
  tag 0x58: DefineFontName | size: 62 B | ratio: 0.020%<br>
      |__   11005461 686f6d61 00efbea9 20323030 34204d69 63726f73 6f667420 436f7270 6f726174 <br>
            696f6e2e 20416c6c 20726967 68747320 72657365 72766564 2e00 <br>
  tag 0x52: DoABC2 | size: 6.66 KB | ratio: 2.236%<br>
      |__   01000000 6672616d 65330010 002e0002 000000af 01000476 6f69640d 666c6173 682e6469 <br>
            73706c61 79094d6f 76696543 6c69700c 666c6173 682e6576 656e7473 05457665 6e740653 <br>
            7472696e 67054172 7261790c 666c6173 682e7379 7374656d 11417070 6c696361 74696f6e <br>
            446f6d61 696e0742 6f6f6c65 616e0543 6c617373 0a666c61 73682e74 65787404 466f6e74 <br>
            07726567 756c6172 09666c61 73682e6e 65740a55 524c5265 71756573 740b666c 6173682e <br>
            7574696c 73094279 74654172 72617914 636f6d2e ...<br>
  tag 0x4c: SymbolClass | size: 45 B | ratio: 0.015%<br>
      |__   02001000 666f6e74 732e5461 686f6d61 5f626f6c 64001100 666f6e74 732e5461 686f6d61 <br>
            5f726567 756c6172 00 <br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
      |__   3400 <br>
  tag 0x52: DoABC2 | size: 3.67 KB | ratio: 1.232%<br>
      |__   01000000 6672616d 65340010 002e0003 b424ffff 03000066 0004766f 69640d66 6c617368 <br>
            2e646973 706c6179 094d6f76 6965436c 6970094e 616d6573 70616365 06537472 696e6704 <br>
            75696e74 0a626f6f 74737472 61703406 4f626a65 63740842 6f6f7461 626c650c 636f6d2e <br>
            6d696e69 636c6970 065f6f77 6e657209 5f736563 75726974 7904696e 69741563 6f6d2e6d <br>
            696e6963 6c69702e 626c6163 6b626f78 115f5365 63757269 74795072 6f766964 65722763 <br>
            6f6d2e6d 696e6963 6c69702e 626c6163 6b626f78 ...<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x2b: FrameLabel | size: 2 B | ratio: 0.001%<br>
      |__   3500 <br>
  tag 0x16: DefineShape2 | size: 141 B | ratio: 0.046%<br>
      |__   12007000 0cd00000 7f800200 ffffff00 72c6ff00 201dccbc 01693380 2e974007 84f913dd <br>
            00000467 6ba22700 2311800f 060e2746 0000174e d8bc0ee6 6800b449 c014ca60 03c27c89 <br>
            e9800002 d3b5d113 80168b40 07830713 ad00000a 676c5e1f 08000100 ffffff00 200dcc30 <br>
            0208f851 c1358000 02876b57 26005050 00f05c82 6500000b 0ed9524c 01616000 00 <br>
            <br>
  tag 0x4b: DefineFont3 | size: 14 B | ratio: 0.005%<br>
      |__   13000501 07546168 6f6d6100 0000 <br>
  tag 0x49: DefineFontAlignZones | size: 3 B | ratio: 0.001%<br>
      |__   130080 <br>
  tag 0x25: DefineEditText | size: 53 B | ratio: 0.017%<br>
      |__   140077fb 0bc1ffb0 2370ed32 13001801 000000ff 02000000 00000028 00003c70 20616c69 <br>
            676e3d22 63656e74 6572223e 3c2f703e 00 <br>
  tag 0x4a: CSMSettings | size: 12 B | ratio: 0.004%<br>
      |__   14005000 00000000 00000000 <br>
  tag 0x16: DefineShape2 | size: 1.48 KB | ratio: 0.496%<br>
      |__   15006800 1a4a0000 ba000d00 ffffff10 84ad24db 86b16816 400200ff 8a00ffe6 00121084 <br>
            ad24db84 b7164002 00ff8a00 ffe60012 1084ad24 db853fa5 900200ff 8a00ffe6 00121084 <br>
            ad24db86 2f885900 0200ff8a 00ffe600 121084ad 225b8625 60590002 00ff8a00 ffe60012 <br>
            1084ad24 db85bd91 640200ff 8a00ffe6 00121084 ad24db85 aeb16402 00ff8a00 ffe60012 <br>
            1084ad1f 5b863e50 59000200 ff8a00ff e6001210 84ad1df4 c6a28417 400200ff 8a00ffe6 <br>
            00121084 ad24db86 a6581640 0200ff8a 00ffe600 ...<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   16000100 87060604 00150002 00400000 00 <br>
  tag 0x16: DefineShape2 | size: 93 B | ratio: 0.031%<br>
      |__   17006000 3e800012 c00100b4 e1fe0020 0d8eb000 0f44904d 100000f1 c2b3cc00 f2f001d0 <br>
            dc133c00 0043f0d3 33004444 003e1000 0100e5f5 ff00200d 8f503c0f 0d313004 e4e00744 <br>
            a44d3800 00c9c2b4 4c00c8c8 01d0d713 3200004e 00 <br>
  tag 0x20: DefineShape3 | size: 258 B | ratio: 0.085%<br>
      |__   18006000 3e800012 c0010072 c6ffff00 200d8fa0 3bef0d33 30044440 0744904d 100000f1 <br>
            c2b3cc00 f2f001d0 dc133c00 0043be10 00011084 b3371181 6fecb200 0200ffff ff00ffff <br>
            ffffff00 200d8f50 3c0f0d31 3004e4e0 0744a44d 380000c9 c2b44c00 c8c801d0 d7133200 <br>
            004e3e10 00011084 b1162fc1 6f909500 0400eef9 ffff1dd8 eeffffe2 92d3feff ff72c6ff <br>
            ff00200d 8f280f0c c0161600 1d129135 80000287 0ad13002 82800743 5c4ca000 0161c34c <br>
            3e100001 12b5b1a2 d32df412 d00200ff ffff66ff ...<br>
  tag 0x20: DefineShape3 | size: 318 B | ratio: 0.104%<br>
      |__   19006000 3e800012 c0010072 c6ffff00 200d8eb0 000f4490 4d100000 f1c2b3cc 00f2f001 <br>
            d0dc133c 000043f0 d3330044 44003e10 00011084 b3371181 6fecb200 0200ffff ff00ffff <br>
            ffffff00 200d8f50 3c0f0d31 3004e4e0 0744a44d 380000c9 c2b44c00 c8c801d0 d7133200 <br>
            004e3e10 00011084 b1162fc1 6f909500 0400eef9 ffff1dd8 eeffffe2 92d3feff ff72c6ff <br>
            ff00200d 8f280f0c c0161600 1d129135 80000287 0ad13002 82800743 5c4ca000 0161c34c <br>
            3e100001 1084b2e6 10416fa0 96000200 ffffff1a ...<br>
  tag 0x20: DefineShape3 | size: 258 B | ratio: 0.085%<br>
      |__   1a006000 3e800012 c0010072 c6ffff00 200d8eb0 000f4490 4d100000 f1c2b3cc 00f2f001 <br>
            d0dc133c 000043f0 d3330044 44003e10 00011084 b3371181 6fecb200 0200ffff ff00ffff <br>
            ffffff00 200d8f50 3c0f0d31 3004e4e0 0744a44d 380000c9 c2b44c00 c8c801d0 d7133200 <br>
            004e3e10 00011084 b1162fc1 6f909500 0400eef9 ffff1dd8 eeffffe2 92d3feff ff72c6ff <br>
            ff00200d 8f280f0c c0161600 1d129135 80000287 0ad13002 82800743 5c4ca000 0161c34c <br>
            3e100001 12b5b1a2 d32df412 d00200ff ffff99ff ...<br>
  tag 0x27: DefineSprite | size: 185 B | ratio: 0.061%<br>
      |__   1b003000 c90a6469 7361626c 65640087 06060200 17000200 40004000 40004000 40004000 <br>
            40004000 40000207 0200c70a 6e6f726d 616c0087 06060400 18000200 40004000 40004000 <br>
            40004000 40004000 40004000 40000207 0400c60a 686f7665 72008706 06050019 00020040 <br>
            00400040 00400040 00400040 00400040 00400040 00020705 00c50a64 6f776e00 87060604 <br>
            001a0002 00400040 00400040 00400040 00400040 00400040 00400040 00400040 00400040 <br>
            00400000 00 <br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
      |__   1b006047 ba08420e c8 <br>
  tag 0x4b: DefineFont3 | size: 13 B | ratio: 0.004%<br>
      |__   1c000401 065f7361 6e730000 00 <br>
  tag 0x49: DefineFontAlignZones | size: 3 B | ratio: 0.001%<br>
      |__   1c0040 <br>
  tag 0x25: DefineEditText | size: 142 B | ratio: 0.047%<br>
      |__   1d0067ec 3c07ec09 d08d321c 00dc0000 3366ff02 00000000 00000000 003c7020 616c6967 <br>
            6e3d2263 656e7465 72223e3c 666f6e74 20666163 653d225f 73616e73 22207369 7a653d22 <br>
            31312220 636f6c6f 723d2223 30303333 36362220 6c657474 65725370 6163696e 673d2230 <br>
            2e303030 30303022 206b6572 6e696e67 3d223022 3e613c2f 666f6e74 3e3c2f70 3e00 <br>
            <br>
  tag 0x27: DefineSprite | size: 65 B | ratio: 0.021%<br>
      |__   1e000900 92062601 001b0002 00626163 6b67726f 756e6400 93062607 001d0012 285a0074 <br>
            6578746c 6162656c 00400040 00400040 00400040 00400040 00400000 00 <br>
  tag 0x27: DefineSprite | size: 76 B | ratio: 0.025%<br>
      |__   1f000100 87060602 00120002 00910626 03001400 18230bb8 6d657373 61676500 93062604 <br>
            001600c9 304f4c0b 0c5002f8 6c6f676f 00910626 09001e00 1a53c604 0062746e 5f6f6b00 <br>
            40000000 <br>
  tag 0x02: DefineShape | size: 52 B | ratio: 0.017%<br>
      |__   20006000 25800025 800100ff ffff0020 0d882000 0f24909e c0000028 395b84e0 05028001 <br>
            c8dc2750 0000160e 59213802 c1600000 <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   21000100 87060601 00200002 00400000 00 <br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
      |__   21005954 690551cc 00 <br>
  tag 0x25: DefineEditText | size: 141 B | ratio: 0.046%<br>
      |__   22006ff6 1bd1fd80 b6008d32 1c001801 000000ff 00000000 00000028 00003c70 20616c69 <br>
            676e3d22 6c656674 223e3c66 6f6e7420 66616365 3d225f73 616e7322 2073697a 653d2231 <br>
            34222063 6f6c6f72 3d222330 30303030 3022206c 65747465 72537061 63696e67 3d22302e <br>
            30303030 30302220 6b65726e 696e673d 2231223e 623c2f66 6f6e743e 3c2f703e 00 <br>
            <br>
  tag 0x25: DefineEditText | size: 141 B | ratio: 0.046%<br>
      |__   23006ff6 1bd1fd80 b6008d32 1c001801 000000ff 00000000 00000028 00003c70 20616c69 <br>
            676e3d22 6c656674 223e3c66 6f6e7420 66616365 3d225f73 616e7322 2073697a 653d2231 <br>
            34222063 6f6c6f72 3d222330 30303030 3022206c 65747465 72537061 63696e67 3d22302e <br>
            30303030 30302220 6b65726e 696e673d 2231223e 613c2f66 6f6e743e 3c2f703e 00 <br>
            <br>
  tag 0x27: DefineSprite | size: 91 B | ratio: 0.030%<br>
      |__   24000100 a9112601 01002100 d1199903 fffc1062 61636b67 726f756e 64000102 000000ff <br>
            00000a00 00000a00 66002395 06260300 220018c8 05006465 73637269 7074696f 6e008f06 <br>
            26040023 0018c801 e0746974 6c650040 000000 <br>
  tag 0x02: DefineShape | size: 54 B | ratio: 0.018%<br>
      |__   25007800 0590e000 02b20001 00ffffff 00200deb 21c03233 004e4e00 7a54419a 70000193 <br>
            a5272600 646400f4 577f3320 0004e74d b200 <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   26000100 87060601 00250002 00400000 00 <br>
  tag 0x02: DefineShape | size: 32 B | ratio: 0.011%<br>
      |__   27006000 2bc00024 e00100ff ffff0020 158af000 0f4a4e74 54474db2 742bc000 <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   28000100 87060601 00270002 00400000 00 <br>
  tag 0x16: DefineShape2 | size: 1.48 KB | ratio: 0.496%<br>
      |__   29006800 1a4a0000 ba000d00 ffffff10 84ad24db 86b16816 400200ff 8a00ffe6 00121084 <br>
            ad24db84 b7164002 00ff8a00 ffe60012 1084ad24 db853fa5 900200ff 8a00ffe6 00121084 <br>
            ad24db86 2f885900 0200ff8a 00ffe600 121084ad 225b8625 60590002 00ff8a00 ffe60012 <br>
            1084ad24 db85bd91 640200ff 8a00ffe6 00121084 ad24db85 aeb16402 00ff8a00 ffe60012 <br>
            1084ad1f 5b863e50 59000200 ff8a00ff e6001210 84ad1df4 c6a28417 400200ff 8a00ffe6 <br>
            00121084 ad24db86 a6581640 0200ff8a 00ffe600 ...<br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   2a000100 87060604 00290002 00400000 00 <br>
  tag 0x16: DefineShape2 | size: 93 B | ratio: 0.031%<br>
      |__   2b006000 3e800012 c001006b baf00020 0d8fa00c 8cc01393 801d11f1 34e00003 270b2130 <br>
            03232007 43844cc8 000139c3 383e1000 0100e5f5 ff00200d 8f780c8c c0161600 1d11f135 <br>
            80000287 0b213002 82800743 844ca000 0161c338 00 <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   2c000100 87060602 002b0002 00400000 00 <br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
      |__   2c006032 3b603390 30 <br>
  tag 0x02: DefineShape | size: 32 B | ratio: 0.011%<br>
      |__   2d006000 3e800012 c00100ff 00000020 158fa04b 0f441872 da8e87d0 e54b0000 <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   2e000100 87060601 002d0002 00400000 00 <br>
  tag 0x16: DefineShape2 | size: 108 B | ratio: 0.035%<br>
      |__   2f006000 3e800012 c0010000 99ff0020 0d8fa03e 8f0ce130 04e4e007 447c4d38 0000c9c2 <br>
            c84c00c8 c801d0e1 13320000 4e3e1000 011084b7 740f505b e8258002 000099ff ff9ad7fe <br>
            00200d8f 780c8cc0 1616001d 11f13580 0002870b 21300282 80074384 4ca00001 61c33800 <br>
            <br>
  tag 0x27: DefineSprite | size: 17 B | ratio: 0.006%<br>
      |__   30000100 87060602 002f0002 00400000 00 <br>
  tag 0x4e: DefineScalingGrid | size: 9 B | ratio: 0.003%<br>
      |__   30006032 3b602a10 30 <br>
  tag 0x27: DefineSprite | size: 47 B | ratio: 0.015%<br>
      |__   31000100 8a062601 002c0002 00626700 8d066604 002e0002 006d736b 0009008a 06260600 <br>
            30000200 66670040 000000 <br>
  tag 0x25: DefineEditText | size: 32 B | ratio: 0.011%<br>
      |__   320077fb 0c267fb0 11908d30 1c009001 000000ff 00000000 00000028 00002000 <br>
  tag 0x27: DefineSprite | size: 122 B | ratio: 0.040%<br>
      |__   33000100 9a062601 002600c9 00064000 0100735f 696e6469 6361746f 72426700 8f062603 <br>
            00280010 c8c8735f 69636f6e 00960626 05002a00 c9001340 000e7c10 0a00735f 6c6f676f <br>
            00940626 0a003100 c9000140 000c6402 a8735f62 61720095 06261400 3200c5ff ecff8c31 <br>
            90019073 5f746578 74004000 0000 <br>
  tag 0x38: ExportAssets | size: 228 B | ratio: 0.075%<br>
      |__   05001f00 636f6d2e 6d696e69 636c6970 2e67616d 656d616e 61676572 2e75692e 416c6572 <br>
            74426f78 55490024 00636f6d 2e6d696e 69636c69 702e6761 6d656d61 6e616765 722e7569 <br>
            2e417761 72644e6f 74696669 63617469 6f6e5549 001e0067 6d75695f 616c6572 74626f78 <br>
            5f666c61 2e707573 685f6275 74746f6e 5f330033 00636f6d 2e6d696e 69636c69 702e6761 <br>
            6d656d61 6e616765 722e7569 2e50726f 67726573 73496e64 69636174 6f726455 49003100 <br>
            676d7569 5f70726f 67726573 735f666c 612e646f ...<br>
  tag 0x52: DoABC2 | size: 210.83 KB | ratio: 70.843%<br>
      |__   01000000 6672616d 65350010 002e0075 00c80150 8098ff07 ffffffff 0ffb48ff ffff0702 <br>
            08ffffff ff070b0a 01ff010f ffff03f5 03f603fe 03ff0380 04810482 04a604a7 04a804ab <br>
            049a051a 14640304 0607090c 80ade204 c0843d80 80fc0781 c694ba06 89d7b6fe 0efeb9eb <br>
            c509f6a8 c98101f8 c8aabb0d d6ee9ec6 0edbe181 a102ee9d f78d0caf 9ff0ab0f aa8c9fbc <br>
            04938cc1 c10a81aa 9aea0fd8 b182cc06 afef93da 08b1b7fd ff0fbeaf f3ca08a2 a2c0dc06 <br>
            93e3e1ec 0f8e87e5 b30aa190 d0cd04e2 caf8b00f ...<br>
  tag 0x4c: SymbolClass | size: 228 B | ratio: 0.075%<br>
      |__   05001f00 636f6d2e 6d696e69 636c6970 2e67616d 656d616e 61676572 2e75692e 416c6572 <br>
            74426f78 55490031 00676d75 695f7072 6f677265 73735f66 6c612e64 6f776e6c 6f61645f <br>
            70726f67 72657373 5f696e64 69636174 6f725f35 001e0067 6d75695f 616c6572 74626f78 <br>
            5f666c61 2e707573 685f6275 74746f6e 5f330033 00636f6d 2e6d696e 69636c69 702e6761 <br>
            6d656d61 6e616765 722e7569 2e50726f 67726573 73496e64 69636174 6f726455 49002400 <br>
            636f6d2e 6d696e69 636c6970 2e67616d 656d616e ...<br>
  tag 0x01: ShowFrame | size: 0 B | ratio: 0.000%<br>
  tag 0x00: End | size: 0 B | ratio: 0.000%<br>
 ]<br>
</code></pre>
<hr />