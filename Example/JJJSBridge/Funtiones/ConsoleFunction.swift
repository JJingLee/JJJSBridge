//
//  ConsoleFunction.swift
//  JJJSBridge_Example
//
//  Created by chiehchun.lee on 2021/5/5.
//  Copyright © 2021 JKOS. All rights reserved.
//

import Foundation
import JJJSBridge

class ConsoleFunction : JJWebJSFunction {
    override func dispatchMethod(args: JJWebJSFunction.argsT, with dispatcher: JJWebJSFunctionEventDispatcher) {
        guard let msg = args.first else {return}
        dispatcher.post(event:
                JJWebJSFunctionEvent(module: self.moduleName,
                                   name: "alert",
                                   data: [
                                    "msg" : msg
                                   ])
        )
        print(msg)
    }
}
