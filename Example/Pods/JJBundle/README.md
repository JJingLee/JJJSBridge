# JJBundle

[![CI Status](https://img.shields.io/travis/JJingLee/JJBundle.svg?style=flat)](https://travis-ci.org/JJingLee/JJBundle)
[![Version](https://img.shields.io/cocoapods/v/JJBundle.svg?style=flat)](https://cocoapods.org/pods/JJBundle)
[![License](https://img.shields.io/cocoapods/l/JJBundle.svg?style=flat)](https://cocoapods.org/pods/JJBundle)
[![Platform](https://img.shields.io/cocoapods/p/JJBundle.svg?style=flat)](https://cocoapods.org/pods/JJBundle)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

/* 
  readme.md
  Pods

  Created by chiehchun.lee on 2021/4/21.
  
*/
## 1. Create bundle and put resource into the bundle by cocoapods.
in .podspec
```ruby
s.resource_bundles = {
  '_bundleName' => ['[framework]/Assets/**/*','[framework]/**/*.{js}']
}
```

## 2. Create your project's Bundle DSL,
```ruby
public extension Bundle {
    static var myBundle : JKOBundleDSL? {
        return JKOBundleDSL(mainBundleName: "_bundleName", anyClassNameInSameBundle: "_bundleName._bundleNameViewController")
    }
}
```

## 3. Use your bundle through DSL
```ruby
Bundle.myBundle?.main?.fetchJSScript(with: fileName)
```

## Requirements

## Installation

JJBundle is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JJBundle'
```

## Author

JJingLee, whplue07@gmail.com

## License

JJBundle is available under the MIT license. See the LICENSE file for more info.
