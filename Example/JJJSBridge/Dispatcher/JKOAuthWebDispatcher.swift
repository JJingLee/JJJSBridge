//
//  JKOAuthWebDispatcher.swift
//  JJJSBridge_Example
//
//  Created by chiehchun.lee on 2021/5/5.
//  Copyright © 2021 JKOS. All rights reserved.
//

import Foundation
import JJJSBridge

class JKOAuthWebDispatcher : JJWebJSHandlerDispatchFormat {
    var functionName: String = ""
    var args: [Any] = []
    var functionKey : String {return "func"}
    var argsKey : String {return "args"}
    func parse(_ data: Any) {
        let functionName = (data as? [String:Any])?[functionKey] as? String
        let args = (data as? [String:Any])?[argsKey] as? [Any]
        self.functionName = functionName ?? ""
        self.args = args ?? []
    }
}
