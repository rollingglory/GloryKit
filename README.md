<h1 align="center">GloryKit</h1>
<p align="center">
<img alt="Cocoapods Support" src="https://img.shields.io/badge/cocoapods-not%20supported-red" target="_blank">
<img alt="Carthage Support" src="https://img.shields.io/badge/carthage-available-success" target="_blank">
<img alt="Swift: 4.2" src="https://img.shields.io/badge/swift-4.2-blue" target="_blank" />
<img alt="XCode: 10.2" src="https://img.shields.io/badge/xcode-10.2-blueviolet" target="_blank" />
<a href="https://github.com/rollingglory/GloryKit/releases"><img alt="Release" src="https://img.shields.io/github/v/tag/rollingglory/GloryKit?label=latest" target="_blank"></a>
</p>
<p align="center">Release Status<br>
<img alt="Release" src="https://img.shields.io/github/v/release/rollingglory/GloryKit" target="_blank" /></p>

<p>GloryKit starts your project off with a great preparation and <i>almost</i> everything you need to start developing with ease 💖 and a peace of mind 😌.

<h2>Installation</h2>

Currently GloryKit can only be installed using Carthage or manual submoduling.
<b>Please refer to <i>release status</i> for release availability. Don't use incubation/beta version without knowing and accepting possible bugs or issues.</b></p>

<b>Carthage</b>:
<pre>
github "https://github.com/rollingglory/GloryKit" == 1.0
</pre>

<p>New to Carthage? You can follow the instructions <a href="https://github.com/Carthage/Carthage#installing-carthage">here</a> to use Carthage and add frameworks to project.</p>

<b>Submodule</b>:

<p>Simply clone or download this project and add manually to your project directory.</p>

<h2>Usage</h2>

<p>For basic usage you can import GloryKit and other corresponding framework, as GloryKit doesn't automatically include specific framework in usage of its methods.</p>

<pre>
import GloryKit

class MyClass: GloryController {
  override func viewDidLoad() {
    super.viewDidLoad()

    Glory().initiate()
  }
}
</pre>

<p>You can directly use GloryKit features, extensions, public helper and many more.
For advanced class reference, though, you can read them all <a href="https://rollingglory.com/glorykit/docs.html">here</a>.</p>

<h2>Contributing</h2>
<p>Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.</p>

<h2>License</h2>

<p>MIT License

Copyright (c) 2019 Rolling Glory

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
</p>
