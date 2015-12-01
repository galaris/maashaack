## Introduction ##

<pre>
Adobe® AIR® SDK & Compiler provides developers with a consistent<br>
and flexible development environment for the delivery of out-of-browser<br>
applications and games across devices and platforms (Windows, Mac, iOS, Android)<br>
</pre>


## Details ##

AIR SDK and Compiler includes:
  * Framework for Adobe AIR APIs
  * ActionScript Compiler 1.0 or 2.0
  * Template for the Adobe AIR application install badge
  * Command-line Adobe AIR Debug Launcher (ADL)
  * Command-line Adobe AIR Developer Tool (ADT)

AIR allows AS3 developers to [Use a Cross-Platform Runtime to Build Better Apps](http://blogs.adobe.com/simplicity/2011/07/build-better-apps.html)
<pre>
The inherent advantage of using a cross-platform runtime, such as AIR, to develop applications<br>
is typically understood to be the boost in productivity that’s achieved by reducing the amount<br>
of per-platform work that’s required. While it’s true this is a potential advantage, it’s generally<br>
discussed with an implicit assumption that the developer is interested in reducing the development cost.<br>
<br>
Suppose, for moment, that this is not the case. If you spend just as much on development as you did before<br>
and use a cross-platform runtime, then what happens? You build better apps.<br>
<br>
The key is to take all the time you saving writing code once and apply the savings elsewhere in your application.<br>
That could be to additional features. Or it could be a better experience: improved responsiveness, more intuitive UI,<br>
lower memory use. No matter how you spend this savings, you build a better app.<br>
</pre>


### Getting the AIR Runtime ###

latest URL
```
https://get.adobe.com/air/
https://get.adobe.com/air/otherversions/
```

versioned download
```
OSX
http://airdownload.adobe.com/air/mac/download/18.0/AdobeAIR.dmg

WIN
http://airdownload.adobe.com/air/win/download/18.0/AdobeAIRInstaller.exe
```


### Getting the AIR SDK ###

The "no brainer" version is to go on the [Download Adobe AIR SDK](http://www.adobe.com/devnet/air/air-sdk-download.html) page<br>
and then click the yellow button (mac or win).<br>
<br>
but wait...<br>
<br>
there are <b>TWO</b> AIR SDK<br>
<br>
one that come with <a href='https://code.google.com/p/redtamarin/wiki/ASC2'>ASC 2.0</a> but <b>CAN NOT BE MERGED</b> with the Flex SDK (AIRSDK_Compiler)<br>
<br>
one that use the legacy <a href='https://code.google.com/p/redtamarin/wiki/ASC'>ASC 1.0</a> and <b>CAN BE MERGED</b> with the <a href='FLEXSDK.md'>Flex SDK</a> (AdobeAIRSDK)<br>
<br>
<br>
here the URL logic to download them<br>
<br>
<ul><li>get the <b>latest</b> AIR SDK with ASC 2.0<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/latest/AIRSDK_Compiler.tbz2'>airdownload.adobe.com/air/mac/download/*latest*/AIRSDK_Compiler.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/latest/AIRSDK_Compiler.zip'>airdownload.adobe.com/air/win/download/*latest*/AIRSDK_Compiler.zip</a>
</li><li>get AIR <b>3.7</b> SDK with ASC 2.0<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/3.7/AIRSDK_Compiler.tbz2'>airdownload.adobe.com/air/mac/download/*3.7*/AIRSDK_Compiler.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/3.7/AIRSDK_Compiler.zip'>airdownload.adobe.com/air/win/download/*3.7*/AIRSDK_Compiler.zip</a>
</li><li>get AIR <b>3.6</b> SDK with ASC 2.0<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/3.6/AIRSDK_Compiler.tbz2'>airdownload.adobe.com/air/mac/download/*3.6*/AIRSDK_Compiler.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/3.6/AIRSDK_Compiler.zip'>airdownload.adobe.com/air/win/download/*3.6*/AIRSDK_Compiler.zip</a>
</li><li>etc.</li></ul>

and the same for the classic SDK (which is older and so can be downloaded for older version than 3.6)<br>
<br>
<ul><li>get the <b>latest</b> AIR SDK to merge with Flex SDK<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/latest/AdobeAIRSDK.tbz2'>airdownload.adobe.com/air/mac/download/*latest*/AdobeAIRSDK.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/latest/AdobeAIRSDK.zip'>airdownload.adobe.com/air/win/download/*latest*/AdobeAIRSDK.zip</a>
</li><li>get AIR <b>3.7</b> SDK to merge with Flex SDK<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/3.7/AdobeAIRSDK.tbz2'>airdownload.adobe.com/air/mac/download/*3.7*/AdobeAIRSDK.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/3.7/AdobeAIRSDK.zip'>airdownload.adobe.com/air/win/download/*3.7*/AdobeAIRSDK.zip</a>
</li><li>get AIR <b>3.6</b> SDK to merge with Flex SDK<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/3.6/AdobeAIRSDK.tbz2'>airdownload.adobe.com/air/mac/download/*3.6*/AdobeAIRSDK.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/3.6/AdobeAIRSDK.zip'>airdownload.adobe.com/air/win/download/*3.6*/AdobeAIRSDK.zip</a>
</li><li>...<br>
</li><li>get AIR <b>3.0</b> SDK to merge with Flex SDK<br>Mac OS X : <a href='http://airdownload.adobe.com/air/mac/download/3.0/AdobeAIRSDK.tbz2'>airdownload.adobe.com/air/mac/download/*3.0*/AdobeAIRSDK.tbz2</a><br>Windows : <a href='http://airdownload.adobe.com/air/win/download/3.0/AdobeAIRSDK.zip'>airdownload.adobe.com/air/win/download/*3.0*/AdobeAIRSDK.zip</a>
</li><li>etc.</li></ul>

<hr />
<h3>Ressources</h3>

<b>links:</b>
<ul><li><a href='http://www.adobe.com/devnet/air/air-sdk-download.html'>Download Adobe AIR SDK</a> (Adobe)<br>
</li><li><a href='http://help.adobe.com/en_US/air/build/index.html'>Adobe AIR</a> (Adobe Documentation)<br>
</li><li><a href='http://blogs.adobe.com/airodynamics/'>Adobe AIR on Mobile Blog</a> (Adobe)<br>
</li><li><a href='http://helpx.adobe.com/x-productkb/multi/how-overlay-air-sdk-flex-sdk.html'>How to Overlay the AIR SDK for Use With the Flex SDK</a>