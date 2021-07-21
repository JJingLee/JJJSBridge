//
//  JJWebJSFunctionEventHandler.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit

public struct JJWebJSFunctionEvent {
    public var module : String
    public var name : String
    public var data : Any
    public init(module:String, name : String, data : Any) {
        self.module = module
        self.name = name
        self.data = data
    }
}

public class JJWebJSFunctionEventDispatcher {
    public var eventHandler : (JJWebJSFunctionEvent)->Void
    public init(eventHandler : @escaping (JJWebJSFunctionEvent)->Void){
        self.eventHandler = eventHandler
    }
    public func post(event : JJWebJSFunctionEvent) {
        self.eventHandler(event)
    }
}

open class JJWebJSFunctionEventHandler {
    public internal(set) weak var webview : WKWebView?
    public internal(set) weak var webViewController : UIViewController?
    var _moduleName : String
    var _functionName : String
    public init(moduleName:String, functionName:String) {
        _moduleName = moduleName
        _functionName = functionName
    }
    public func module()->String {
        return _moduleName
    }
    public func functionName()->String {
        return _functionName
    }
    open func sendEvent(with data:Any?) {}

}
