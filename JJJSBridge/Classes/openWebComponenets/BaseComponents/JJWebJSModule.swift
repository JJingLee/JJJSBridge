//
//  JJWebJSModule.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation

open class JJWebJSModule {
    public var name : String
    public var jsFunctions : [JJWebJSFunction]
    public var jsScripts : [String]
    public init(name : String, functions : [JJWebJSFunction] = [], jsScripts : [String] = []) {
        self.name = name
        self.jsFunctions = functions
        self.jsScripts = jsScripts
    }
}
