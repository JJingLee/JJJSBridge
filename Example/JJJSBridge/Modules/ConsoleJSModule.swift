//
//  ConsoleJSModule.swift
//  JKPay
//
//  Created by chiehchun.lee on 2021/5/14.
//

import Foundation
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
