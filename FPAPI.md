## Introduction ##

**FPAPI** stands for the **Flash Platform API**.

It allows us to refer to the **Flash Player API** (FP API)
and/or the **Adobe Integrated Runtime API** (AIR API)
in our/your usage of the AS3 language.

We will mention the **FPAPI** mainly to inform with
which version of Flash and/or AIR a particular
package or library or tool etc. can works.


## Details ##

Here how the **FPAPI** versioning works:

  * anything starting with _FP works with the **Flash Player**_<br />and will also work with AIR
  * anything starting with _AIR works with the **Adobe Integrated Runtime**_<br />but will not necessary work with the Flash player
  * if no **FPAPI** is mentioned we default to **FP\_9\_0**
  * a change of API version can introduce languages features, SWF features, etc.
  * refer to the table bellow to see which is compatible with what

Our advice is when you start to implement something
simply base it on the current stable **FPAPI**.

If you need backward compatibility with earlier version,
then use [conditional compilation](ConditionalCompilation.md)
and works your way back in the code.

### API Reference Table ###

| **SWF version** | **Flash Player** | **codename** | **FP release**  | **AIR / AIR SDK** | **AIR release** | **Flex SDK** |
|:----------------|:-----------------|:-------------|:----------------|:------------------|:----------------|:-------------|
| SWF9            | 9.0.0            | Moviestar    | 28/01/2008      | 1.0.0             | 25/02/2008      | 3.0.0        |
| SWF9            | 9.0.0            |              |                 | 1.1.0             | ???             | 3.1.0        |
| SWF9            | 9.0.0            |              |                 | 1.5.0             | ???             | 3.2.0        |
| SWF9            | 9.0.0            |              |                 | 1.5.0             |                 | 3.3.0        |
| SWF9            | 9.0.0            |              |                 | 1.5.2             | ???             | 3.4.0        |
| SWF9            | 9.0.0            |              |                 | 1.5.3             | ???             | 3.5.0        |
| SWF9            | 9.0.0            |              |                 | 1.5.3             |                 | 3.6.0        |
| SWF10           | 10.0.0           | Astro        | 15/10/2008      | 1.5.3             |                 | 4.0.0        |
| SWF10           | 10.0.0 / 10.1.0  | Gala?        | 16/08/2010      | 2.0.2             | 10/06/2010      | 4.1.0        |
| SWF11           | 10.2.0           |  Square?     | 08/02/2011      | 2.6.0             | 22/03/2011?     | 4.5.0        |
| SWF11           | 10.2.0           | Spicy        |                 | 2.6.0             |                 | 4.5.1        |
| SWF12           | 10.3.0           | Wasabi       | 12/05/2011      | 2.7.0             | 14/06/2011      | n/a          |
| SWF13           | 11.0.0           | Serrano (Molehill) | 04/10/2011      | 3.0.0             | 04/10/2011      | n/a          |
| SWF14           | 11.1.0           | Anza         | 17/01/2012?     | 3.1.0             | 17/01/2012?     | 4.6.0        |
| SWF15           | 11.2.0           | Brannan      | 28/03/2012      | 3.2.0             | 28/03/2012      | n/a          |
| SWF16           | 11.3.0           | Cyril        | 08/06/2012      | 3.3.0             | 08/06/2012      | n/a          |
| SWF17           | 11.4.0           | Dolores      | 21/08/2012      | 3.4.0             | 21/08/2012      | n/a          |
| SWF18           | 11.5.0           | Ellis        | 26/11/2012      | 3.5.0             | 26/11/2012      | n/a          |
| SWF19           | 11.6.0           | Folsom       | 12/02/2013      | 3.6.0             | 12/02/2013      | n/a          |
| SWF20           | 11.7.0           | Geary        | 09/04/2013      | 3.7.0             | 09/04/2013      | n/a          |
| SWF21           | 11.8.0           | Harrison     | 09/07/2013      | 3.8.0             | 24/07/2013      | n/a          |
| SWF22           | 11.9.0           | Irving       | 08/10/2013      | 3.9.0             | 08/10/2013      | n/a          |
| SWF23           | 12.0.0           | Jones        | 14/01/2014      | 4.0.0             | 14/01/2014      | n/a          |
| SWF24           | 13.0.0           | King         | 08/04/2014      | 13.0.0            | 08/04/2014      | n/a          |
| SWF25           | 14.0.0           | Lombard      | 02/06/2014      | 14.0.0            | 02/06/2014      | n/a          |
| SWF26           | 15.0.0           | Market       | 09/09/2014      | 15.0.0            | 09/09/2014      | n/a          |
| SWF26           | 15.0.0.223       | Market       | 11/11/2014      | 15.0.0.356        | 11/11/2014      | n/a          |
| SWF27           | 16.0.0           | Natoma       | 09/12/2014      | 16.0.0            | 13/01/2015      | n/a          |
| SWF28           | 17.0.0           | Octavia      | 12/03/2015      | 17.0.0            | 12/03/2015      | n/a          |
| **SWF29**       | **18.0.0**       | **Presidio** | **09/06/2015**  | **18.0.0**        | **09/06/2015**  | **n/a**      |
| SWF30           | 19.0.0           | Quint        | ???             | 19.0.0            | ???             | n/a          |


**note:**
  * after Flash Player 10.2, SWF version got incremented for each dot release
  * since AIR SDK 3.6 you have 2 versions of the SDK, one with ASC2, one with ASC that can be merged with the Flex SDK
  * SWF version is the minimum SWF version supported in the Flex SDK
  * AIR SDK is the version provided by default in the Flex SDK
  * bold is the last stable version
  * something followed by ? means "not sure"
  * ??? means no idea
  * correction/contribution/comments welcome :)
  * "Our current plan is to change the next version of AIR (code named King and scheduled for Q2) to version 13, bringing it in line with Flash Player’s version number." see [adobe forums](http://forums.adobe.com/message/6001351#6001351)

### Examples ###

If your class depends on **FPAPI** **FP\_10\_2** (Flash Player 10.2)
  * it will also works with **AIR\_2\_6** (AIR 2.6)
  * and any successive version of Flash Player (10.3, 11, 11.1, etc.)
  * and any successive version of AIR (2.7, 3.0, 3.1, etc.)

if your class depends on **FPAPI** **AIR\_3\_3** (AIR 3.3)
  * it will not work with **FP\_11\_3** (Flash Player 11.3)
  * it will work with any successive version of AIR (3.4, 3.5, etc.)



---

### Ressources ###

**links:**
  * [Adobe roadmap for the Flash runtimes](http://www.adobe.com/devnet/flashplatform/whitepapers/roadmap.html) (Adobe)
  * [Flash Player and Adobe AIR feature list](http://www.adobe.com/devnet/articles/flashplayer-air-feature-list.html) (Adobe)
  * [Versioning in Flash Runtime](http://blogs.adobe.com/airodynamics/2011/08/16/versioning-in-flash-runtime-swf-version/) (Adobe)
  * [API Versioning in AVM](http://hg.mozilla.org/tamarin-redux/raw-file/f5191c18b0e4/doc/apiversioning.html) (tamarin-redux)
  * [api-versions.as](http://hg.mozilla.org/tamarin-redux/file/f5191c18b0e4/core/api-versions.as) (tamarin-redux)
  * [api-versions.xml](http://hg.mozilla.org/tamarin-redux/file/f5191c18b0e4/core/api-versions.xml) (tamarin-redux)