//
//  JJJSBridgeWebViewDSL.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit
import JavaScriptCore

/** Use case

 // Launch --> inject framework JS
 webView.jj_jsbridge.registJSScript(script)

 // dispatcher --> listening
 webView.jj_jsbridge.addHandler(with: "clickHandler") { (data) in print("clickHandler : \(data)") }

*/
public class JJJSBridgeWebViewDSL:NSObject {
    let webView : WKWebView
    var contentController : WKUserContentController?
    public init(webview : WKWebView) {
        webView = webview
        contentController = webview.configuration.userContentController
    }

    //MARK: - registScript
    @available(*, deprecated, message: "Use addJSScriptBeforeRendered insdead")
    public func registJSScript(_ scriptString:String) {
        let script = WKUserScript(source: scriptString, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        contentController?.addUserScript(script)
    }
    /** Add JS before dom rendered. */
    public func addJSScriptBeforeRendered(_ jsString : String) {
        contentController?.addUserScript(WKUserScript(source: jsString, injectionTime: .atDocumentStart, forMainFrameOnly: false))
    }
    /** Add JS after dom rendered. */
    public func addJSScriptAfterRendered(_ jsString : String) {
        contentController?.addUserScript(WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: false))
    }
    /** Execute JS imediately. */
    public func executeJSScript(_ jsString : String, _ complete : @escaping(Any?, Error?)->Void) {
        webView.evaluateJavaScript(jsString) { (result, error) in
            complete(result, error)
        }
    }
    //MARK: - handler
    /**Handle event from js. */
    public func addHandler(with key:String, subscribe subscriber:@escaping(Any)->Void){
        let newObserver = JJJSFunctionObserver(with: key, observer: subscriber)
        webView.setJSFunctionCallingObserver(newObserver, with: key) //retain it.
        contentController?.add(newObserver, name: key)
    }
    /**Handle event from js with custom delegate. */
    public func addHandler(with key:String, customDelegate:WKScriptMessageHandler){
        contentController?.add(customDelegate, name: key)
    }
    /** Send event to window, js must receive with 'window.addEventListener' */
    public func postEventToWindow(_ eventName : String, eventMsg : [String:Any], _ complete : ((Any?, Error?)->Void)?) {
        var msg : String = ""
        let jsonData = try? JSONSerialization.data(withJSONObject: eventMsg, options: [.prettyPrinted])
        if let _jsonData = jsonData{
            msg = String(data: _jsonData, encoding: .utf8) ?? msg
        }
        let commandScript = """
            var event = new CustomEvent("\(eventName)", {
                  detail: \(msg)
            });
            window.dispatchEvent(event);
        """
        self.executeJSScript(commandScript) { (result, err) in
            complete?(result, err)
        }
    }

}
