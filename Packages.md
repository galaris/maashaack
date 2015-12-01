# Introduction #

When you name something you should name it well,<br>
so it is easy to use, write and remember.<br>
<br>
If you want an apple you ask "Can I have an apple ?"<br>
not "can I have this colored round shaped fruit ?"<br>
that's the best way to end up with an orange.<br>
<br>
<br>
<h2>About naming packages</h2>

We do not believe in the classic <code>com.companyName.productName</code><br>
convention to apply to a general framework naming system.<br>
<br>
Long time ago (AS2 times) someone tried to create the "ActionScript Standard Library" (ASL)<br>
but that's not what we are trying to do (a standard library).<br>
<br>
Some other people use <code>org.osflash.libraryName</code> but considering the state of osflash,<br>
even if we are pro open source we don't think our code belong in this naming.<br>
<br>
<b>maashaack</b> is merely a pun or a joke as a name<br>
(we don't take ourselves seriously but we <b>DO</b> take code seriously)<br>
so we didn't feel either to use <code>org.maashaack.framework</code>.<br>
<br>
historically it went like that<br>
<pre>
a: man I wish I had a Java or .NET framework for AS3<br>
b: me too<br>
a: I don't get why Adobe does not provide one<br>
b: they are busy with Flex :)<br>
a: but Flex is not pure AS3<br>
b: true<br>
a: we should write one<br>
b: a framework ?<br>
a: yes<br>
b: I'm already too busy with my own projects<br>
a: me too<br>
b: and it would take too much time<br>
a: yeah it would be a massive hack<br>
b: we could merge our projects for a start<br>
a: yes let's do that!<br>
</pre>

In some cases, we could reuse the package <b>flash.something</b><br>
but we are afraid that maybe Adobe's lawyer will make us change it.<br>
(they did it by telling <b>flashobject</b> to change their name, see <a href='http://code.google.com/p/swfobject/wiki/history'>swfobject history</a>)<br>
<br>
We kind of liked how Python name their libraries,<br>
but <code>sys</code> feel a bit too short to us.<br>
<br>
So, we are not a company, we don't want <code>org.maashaack.something</code> as<br>
it's too long to type and we can't bother to buy this domain name<br>
and we want things to be simple and easy to use.<br>
<br>
So we decided to use a main package named <b>system</b>.<br>
<br>
<br>
<h2>About the other packages</h2>

We kept it simple too, core basic stuff are in the package <b>core</b><br>
graphic related stuff are in the package <b>graphics</b><br>
and library related stuff are in <b>libraries</b>, etc.<br>
<br>
<br>
<h1>Details</h1>

The following describe the different <b>root</b> packages and their scope.<br>
<br>
<b>core</b> - classes and functions utilities<br>
<b>system</b> - the maashaack application framework<br>
<b>graphics</b> - an extension to the framework<br>
<b>library</b> - a container for libraries<br>

and that's about it<br>
<br>
<h1>Our Primary Goal</h1>

here an example of what we try to achieve in a day to day code usage<br>
<br>
<pre><code>package<br>
{<br>
    import flash.display.Sprite;<br>
    <br>
    import system.Strings;<br>
    import system.Version;<br>
    import system.URI;<br>
    import system.externals.HTMLDOM;<br>
    import system.terminals.SocketConsole;<br>
    <br>
    import graphics.colors.RGB;<br>
    import graphics.filters.ReflectionFilter;<br>
    <br>
    import library.zlib;<br>
    import library.PNG;<br>
    <br>
    <br>
    public class Main extends Sprite<br>
    {<br>
        //...<br>
    }<br>
    <br>
}<br>
</code></pre>

see the naming for the imports ?<br>
<br>
it stays simple, clean and easy to use and we like that a lot.