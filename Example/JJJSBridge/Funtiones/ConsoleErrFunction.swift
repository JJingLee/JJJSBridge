//
//  ConsoleErrFunction.swift
//  JKPay
//
//  Created by chiehchun.lee on 2021/5/14.
//

import Foundation
import JJJSBridge

public class ConsoleErrFunction : JJWebJSFunction {
    public override func dispatchMethod(args: JJWebJSFunction.argsT, with dispatcher: JJWebJSFunctionEventDispatcher) {
        print("⚠️: \(args)")
    }
    public override func functionJSScript() -> String {
        return """
                console.error = function(){
                    window.addEventListener('error', function(e){
                        var module = new \(moduleName)();
                        module.\(functionName)(e.message);
                    });
                    console.error = function(){
                        var module = new \(moduleName)();
                        module.\(functionName)(JSON.stringify(arguments));
                    };
                };
            """
    }
}
