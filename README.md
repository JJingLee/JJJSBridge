# JJJSBridge

[![CI Status](https://img.shields.io/travis/JJingLee/JJJSBridge.svg?style=flat)](https://travis-ci.org/JJingLee/JJJSBridge)
[![Version](https://img.shields.io/cocoapods/v/JJJSBridge.svg?style=flat)](https://cocoapods.org/pods/JJJSBridge)
[![License](https://img.shields.io/cocoapods/l/JJJSBridge.svg?style=flat)](https://cocoapods.org/pods/JJJSBridge)
[![Platform](https://img.shields.io/cocoapods/p/JJJSBridge.svg?style=flat)](https://cocoapods.org/pods/JJJSBridge)


## Concept
To make native module and function import be like configure legos. Could Imports Modules and Functions, and receive WebKit.messageHandler's event with concrete format.

## Roles
> JJWebJSModuleBuilder : Build All JS Modules to JJBaseWebViewController.

> JJWebJSModule : Define module name

> JJWebJSFunction : Define functions

> JJWebJSHandlerDispatch : Define how you communicate with webcore through MessageHandler.

> JJWebJSFunctionEventHandler : Listen actions from Funtion, and it holds WebView.

<img src="https://drive.google.com/uc?export=view&id=1aKozUtuv5Z_n1Q6Z4VufhwYoOCLHbFH_" width="60%">


## Architect
<img src="https://drive.google.com/uc?export=view&id=1JDruiuE0VQ_uqVlSLCGqp4FZq0WCr7aa" width="60%">

## Code
```swift
//DemoOpenWebViewController.swift
import JJJSBridge

class DemoBaseWebViewController: JJBaseWebViewController {

    public override func jsModulesBuilders() -> [JJWebBaseJSModuleBuilder] {
        return [
            ConsoleJSModule(name: "jjConsole"),
            DemoJSModuleBuilder(name: "demoAlert")
        ]
    }

}
```
``` swift
//ConsoleJSModule.swift
import JJJSBridge

public class ConsoleJSModule : JJWebBaseJSModuleBuilder {
    let consoleFuncName : String = "consoleLog"
    let errorFuncName : String = "consoleErr"
    public override var functions : [JJWebJSFunction] {
        return [
            ConsoleLogFunction(moduleName: self.name, functionName: consoleFuncName),
            ConsoleErrFunction(moduleName: self.name, functionName: errorFuncName)
        ]
    }
    public override var jsScripts : [String] {
        return []
    }
    public override var jsFileNames : [String] {
        return []
    }
    public override var eventHandlers : [JJWebJSFunctionEventHandler] {
        return []
    }
}
```
```swift
public class ConsoleLogFunction : JJWebJSFunction {
    public override func dispatchMethod(args: JJWebJSFunction.argsT, with dispatcher: JJWebJSFunctionEventDispatcher) {
        print("ℹ️: \(args)")
    }
    public override func functionJSScript() -> String {
        return """
                window.addEventListener('message', function(e){
                    var module = new \(moduleName)();
                    module.\(functionName)(e.message);
                });
                console.log = function(){
                    var module = new \(moduleName)();
                    module.\(functionName)(JSON.stringify(arguments));
                };
            """
    }

}
```
How javascript use?
```javascript
var jjconsoler = new jjConsole();
jjconsoler.consoleLog('123test');
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JJJSBridge is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JJJSBridge'
```

## Author

JJingLee, whplue07@gmail.com

## License

JJJSBridge is available under the MIT license. See the LICENSE file for more info.
