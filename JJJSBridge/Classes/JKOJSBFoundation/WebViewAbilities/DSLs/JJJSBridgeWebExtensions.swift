//
//  JJJSBridgeWebExtensions.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit

extension WKWebView {
    @objc public var jj_jsbridge : JJJSBridgeWebViewDSL { JJJSBridgeWebViewDSL(webview: self) }
    @objc static public var jj_jsbridge : JJJSBridgeWebViewDSL.Type { JJJSBridgeWebViewDSL.self }
}

//MARK: - +Observers
extension WKWebView {

    private static let jjJSMsgObserverKey = "jjJSMsgObserverKey"
    func setJSFunctionCallingObserver(_ observer:JJJSFunctionObserver, with key:String) {
        objc_setAssociatedObject(self, "\(WKWebView.jjJSMsgObserverKey)_\(key)", observer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func getJSFunctionCallingObserver(with key:String)->JJJSFunctionObserver? {
       return objc_getAssociatedObject(self, "\(WKWebView.jjJSMsgObserverKey)_\(key)") as? JJJSFunctionObserver
    }
}
