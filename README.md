<p align="center">
<a href="https://imgbb.com/"><img src="https://i.ibb.co/x8GMf7g/Anjay-With-Background.png" alt="Anjay-With-Background" border="0"></a>
</p>
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
```bash
github "rollingglory/GloryKit"
```

<p>New to Carthage? You can follow the instructions <a href="https://github.com/Carthage/Carthage#installing-carthage">here</a> to use Carthage and add frameworks to project.</p>

<b>Submodule</b>:

<p>Simply clone or download this project and add manually to your project directory.</p>

<h2>Usage</h2>

<h3>Basic</h3>
<p>For basic usage you can import GloryKit and other corresponding framework, as GloryKit doesn't automatically include specific framework in usage of its methods.</p>

```swift
import GloryKit

class MyClass: GloryController {
  override func viewDidLoad() {
    super.viewDidLoad()

    Glory().initiate()
  }
}
```

<p>You can directly use GloryKit features, extensions, public helper and many more.</p>

<h3>Networking</h3>
<p>GloryKit uses <a href="https://github.com/Moya/Moya">Moya</a> as its networking layer. Moya itself covers <a href="https://github.com/Alamofire/Alamofire">Alamofire</a> in exchange of <code>URLSession</code>. To use Moya, you need to create <b>two</b> basic class/struct. The first one is <b>service</b>, and the other is <b>interactor/adapter</b>.</p>

<b>Service</b>
<p>A service handles your list of endpoints in a server-way, you configure an endpoint's request method, base url, path, headers, url and body parameters.</p>

```swift
import Moya

enum AuthenticationService {
  case login(email: String, password: String)
}

extension AuthenticationService: TargetType {
  var baseURL: URL { return "api.randomdude.com" }
  var path: String { return "/login" }
  var method: Moya.Method { return .post }
  var sampleData: Data { return Data() } // You can ignore this by setting `Data()` as default
  var task: Task {
    switch self {
      case .login(let email, let password):
        let params: [String: Any] = [
          "email": email, "password": password
        ]
        return .requestParameters(parameters: params, encoding: JSONEncoding.default)
    }
  }
  var headers: [String: String]? {
    return ["Content-Type": "application/json"
  }
}
```

<b>Interactor/Adapter</b>
<p>Use any phrase you fancy to use. Interactor creates actual mediator between our service enum with the server.</p>

```swift
struct AuthenticationInteractor {
  let provider = MoyaProvider<AuthenticationService>()

  func login(email: String, password: String) {
    provider.request(.login(email: email, password: password)) { result in
      // Handle result here
    }
  }
}
```

Once you're done with these two, your classes can call 
```swift
AuthenticationInteractor().login(email: "something", password: "encrypted something")
```
 from anywhere in the class and handles its result.

<h3>Database</h3>
<p>As for database, GloryKit uses good ol' <a href="https://realm.io/docs/swift/latest/">Realm</a>. Realm gives an ease of use in writing, fetching and manipulating data. GloryKit ensures a more effective use of Realm with expanding its functions to better help developers.</p>
<p>GloryKit has `RealmHelper` class as-you guess it-Realm's helper functions. There, you can find Realm's default instance to be used from anywhere in your code. For example:</p>

```swift
...
// Get default realm instance
let realm = RealmHelper.shared.realm

// Get list of realm object (and filter them as well)
RealmHelper.shared.get(Object.self, filter: "id != 12")

// You can also create a custom transaction within a closure
RealmHelper.shared.write(inRealm: realm) { (realm) in
  realm.add(object, update: .modified)
  realm.delete(anotherObject)
  // etc.
}
...
```

<h3>Keychain</h3>
<p>Keychain is a secure storage. You can store all kind of sensitive data in it: user passwords, credit card numbers, secret tokens etc. Using <a href="https://github.com/evgenyneu/keychain-swift">KeychainSwift</a>, your sensitive data is ensured to be secure all the time. KeychainSwift lets you get and set data in and out of device's keychain in an easy way.</p>

```swift
let keychain = KeychainSwift()
keychain.set("hello world", forKey: "myKey")
keychain.get("myKey")
```

<h3>Image Loading</h3>
<p><a href="https://github.com/onevcat/Kingfisher">Kingfisher</a> is a powerful, pure-Swift library for downloading and caching images from the web. With plenty of helpful functions already, Kingfisher is developers' favourite image library. 

GloryKit extends a little bit of Kingfisher's method.</p>

```swift
let soloImageView = UIImageView()
soloImageView.setImage(urlString: "https://img.url/anjaymabar")
```
<p>Other than <code>urlString</code> parameter, there are <code>placeholder</code>, <code>options</code>, <code>fade</code> and <code>completionHandler</code>.</p>

<h3>Other</h3>
<p>You can read all advanced class reference <a href="https://rollingglory.com/glorykit/docs.html">here</a>.</p>

<h2>Contributing</h2>
<p>Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.</p>

<h2>Information</h2>
<p>For further information you can follow us <a href="http://rollingglory.com">on our website</a>.</p>

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

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p>