//
//  JJWebJSDefaultDispatcher.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation

public class JKOAuthWebDispatcher : JJWebJSHandlerDispatchFormat {
    public var functionName: String = ""
    public var args: [Any] = []
    public var functionKey : String {return "func"}
    public var argsKey : String {return "args"}
    public func parse(_ data: Any) {
        let functionName = (data as? [String:Any])?[functionKey] as? String
        let args = (data as? [String:Any])?[argsKey] as? [Any]
        self.functionName = functionName ?? ""
        self.args = args ?? []
    }
}
