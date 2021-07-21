//
//  JJJSFunctionObserver.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit
/** Delegation of JSHandler for web */
public class JJJSFunctionObserver : NSObject, WKScriptMessageHandler {
    var _observer : (Any)->Void
    var _key : String
    init(with key : String, observer: @escaping (Any)->Void) {
        _observer = observer
        _key = key
    }
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == _key {
            _observer(message.body)
        }
    }
}
