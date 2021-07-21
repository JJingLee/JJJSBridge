//
//  DemoOpenWebViewController.swift
//  JKOJSBridge_Example
//
//  Created by chiehchun.lee on 2021/7/19.
//  Copyright © 2021 JKOS. All rights reserved.
//

import UIKit
import JJJSBridge

class DemoOpenWebViewController: JJBaseWebViewController {

    public override func jsModulesBuilders() -> [JJWebBaseJSModuleBuilder] {
        return [
            ConsoleJSModule(name: "jkosConsole"),
            DemoJSModuleBuilder(name: "demoAlert")
        ]
    }

}
