//
//  JJWebJSHandlerDispatchFormat.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation

public protocol JJWebJSHandlerDispatchFormat {
    var functionName : String {get set}
    var args : [Any] {get set}
    var functionKey : String {get}
    var argsKey : String {get}
    func parse(_ data : Any)
}
