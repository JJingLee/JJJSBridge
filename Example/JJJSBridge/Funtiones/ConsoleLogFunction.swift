//
//  ConsoleLogFunction.swift
//  JKPay
//
//  Created by chiehchun.lee on 2021/5/14.
//

import Foundation
import JJJSBridge

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

public enum JKOJSEvents {
    static let jsCallback = "jsCallback"
}
public class JSFuncGetJkosAccessToken: JJWebJSFunction {
    public override func dispatchMethod(args: JJWebJSFunction.argsT, with dispatcher: JJWebJSFunctionEventDispatcher) {
//        guard let jkosToken = UserInfoObject.getInstance().accessToken else { return }
        let callbackScript = "jkosAccessTokenPromise.resolve('a_token')"
        dispatcher.post(event: JJWebJSFunctionEvent(module: self.moduleName, name: JKOJSEvents.jsCallback, data: callbackScript))
    }
    public override func functionJSScript() -> String {
        return ""
    }
}
