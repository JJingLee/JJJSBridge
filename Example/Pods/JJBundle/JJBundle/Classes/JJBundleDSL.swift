//
//  JKOBundleDSL.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2021/4/21.
//

import Foundation

open class JJBundleDSL {
    public let _bundle : Bundle
    private let mainBundle : Bundle?
    public init?(mainBundleName : String, anyClassNameInSameBundle className : String) {
        guard let bundleClass = NSClassFromString(className) else {return nil}
        _bundle = Bundle(for: bundleClass)
        guard let bundlePath = _bundle.path(forResource: mainBundleName, ofType: "bundle") else {return nil}
        mainBundle = Bundle.init(path: bundlePath)
    }
    public var main : Bundle? {
        return mainBundle
    }
}
