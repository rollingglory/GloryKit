<h1 align="center">GloryKit</h1>
<p align="center">
<a href="https://github.com/kefranabg/readme-md-generator/blob/master/LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-yellow.svg" target="_blank" /></a> <img alt="Swift: 4.2" src="https://img.shields.io/badge/swift-4.2-blue" target="_blank" />
<img alt="XCode: 10.2" src="https://img.shields.io/badge/xcode-10.2-blueviolet" target="_blank" />
</p>

>GloryKit starts your project off with a great preparation and _almost_ everything you need to start developing with ease ❤️ and a peace of mind 😌.

## Installation

Currently GloryKit can only be installed using Carthage or manual submoduling.

**Carthage**:
```bash
github "https://github.com/rollingglory/GloryKit" == 1.0
```
New to Carthage? You can follow the instructions [here](https://github.com/Carthage/Carthage#installing-carthage) to use Carthage and add frameworks to project.

**Submodule**:

Simply clone or download this project and add manually to your project directory.

## Usage

For basic usage you can import GloryKit and other corresponding framework, as GloryKit doesn't automatically include specific framework in usage of its methods.

```swift
import GloryKit

class MyClass: GloryController {
override func viewDidLoad() {
super.viewDidLoad()

Glory().initiate()
}
}
```

You can directly use GloryKit features, extensions, public helper and many more.
For advanced class reference, though, you can read them all [here](https://rollingglory.com/glorykit/docs.html).

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

MIT License

Copyright (c) 2019 Rolling Glory

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

<p>
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
</p>
