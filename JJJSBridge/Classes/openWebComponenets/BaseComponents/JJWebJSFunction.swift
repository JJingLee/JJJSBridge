//
//  JJWebJSFunction.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit

open class JJWebJSFunction {
    public typealias argsT = [Any]
    public var moduleName : String
    public var functionName : String
    public init(moduleName:String, functionName : String) {
        self.moduleName = moduleName
        self.functionName = functionName
    }
    open func dispatchMethod(args:argsT, with dispatcher : JJWebJSFunctionEventDispatcher) {

    }
    open func functionJSScript()->String {
        return ""
    }
}
