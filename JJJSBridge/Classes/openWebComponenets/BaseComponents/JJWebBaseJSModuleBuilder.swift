//
//  JJWebBaseJSModuleBuilder.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit
open class JJWebBaseJSModuleBuilder {
    //MARK: overrided functions
    open var eventHandlers : [JJWebJSFunctionEventHandler] { return [] }
    open var functions : [JJWebJSFunction] {return []}
    open var jsScripts : [String] {return []}
    open var jsFileNames : [String]? {return []}
    //MARK: - others
    public weak var webViewController : UIViewController?
    public weak var webView : WKWebView?
    public let jsModule : JJWebJSModule
    public let name : String
    public init(name : String, webViewController:UIViewController? = nil, webView : WKWebView? = nil) {
        self.name = name
        jsModule = JJWebJSModule(name: name)
        let scripts = allScripts()
        jsModule.jsScripts = scripts
        jsModule.jsFunctions = functions
        self.webViewController = webViewController
        self.webView = webView
    }


    private func allScripts()->[String] {
        //init with raw scripts
        var scripts : [String] = self.jsScripts

        //check has js files
        jsFileNames?.forEach({ (jsfileStr) in
            if jsfileStr.count > 0,
               let fileScript = Bundle.main.fetchJSScript(with: jsfileStr), fileScript.count > 0 {
                scripts.append(fileScript)
            }
        })
        return scripts
    }

}
