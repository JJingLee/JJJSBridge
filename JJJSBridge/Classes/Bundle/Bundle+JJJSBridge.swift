//
//  Bundle+JJJSBridge.swift
//  JJBundle
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import JJBundle

extension Bundle {
    public static var jjjsb : JJBundleDSL? {
        return JJBundleDSL(mainBundleName: "JJJSBridge", anyClassNameInSameBundle: "JJJSBridge.JJJSWorker")
    }
}
