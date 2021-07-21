//
//  BaseWebViewController.swift
//  JJJSBridge_Example
//
//  Created by chiehchun.lee on 2021/7/19.
//  Copyright © 2021 JKOS. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import JJBundle

open class JJBaseWebViewController: UIViewController {
    public let webView = WKWebView()
    private var jsbridgeLoader : JJWebJSModuleLoader?

    override open func viewDidLoad() {
        super.viewDidLoad()
        configWebView()
        configJSBridge()
    }
    
    //MARK: - Open Functions
    open func startRequest(with url:URL) {
        self.webView.load(URLRequest(url: url))
    }
    open func startLoad(with localHTMLName:String) {
        let html = Bundle.main.fetchHTMLDocument(with: localHTMLName) ?? ""
        webView.loadHTMLString(html, baseURL: nil)
    }
    open func jsModulesBuilders()->[JJWebBaseJSModuleBuilder] {
        return []
    }
    open func hybridDispatcher()->JJWebJSHandlerDispatchFormat {
        return  JKOAuthWebDispatcher()
    }

}

//MARK: - layouts
extension JJBaseWebViewController {
    private func configWebView() {
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func configJSBridge() {
        //Load js modules to web
        jsbridgeLoader =
            JJWebJSModuleLoader(webview: self.webView, dispatcher: hybridDispatcher())
            .build(with: jsModulesBuilders())
    }
}
