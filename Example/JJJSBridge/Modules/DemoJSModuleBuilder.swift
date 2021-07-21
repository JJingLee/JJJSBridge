//
//  DemoJSModuleBuilder.swift
//  JJJSBridge_Example
//
//  Created by chiehchun.lee on 2021/5/5.
//  Copyright © 2021 JKOS. All rights reserved.
//

import Foundation
import JJJSBridge

class DemoJSModuleBuilder : JJWebBaseJSModuleBuilder {
    override var functions: [JJWebJSFunction] {
        return [
            ConsoleFunction(moduleName: self.name, functionName: "console"),
            ConsoleFunction(moduleName: self.name, functionName: "click")
        ]
    }
    override var jsScripts: [String] {
        return [
            """
                var jkocb = new JKOCB(); jkocb.console('I did a console.');
            """
        ]
    }

    override var jsFileNames: [String] {
        return ["test"]
    }
    override var eventHandlers: [JJWebJSFunctionEventHandler] {
        [
            AlertFunctionEventHandler(moduleName: self.name, functionName: "alert")
        ]
    }
}
