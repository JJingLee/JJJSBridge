//
//  openWebViewController.swift
//  JKOJSBridge_Example
//
//  Created by chiehchun.lee on 2021/4/26.
//  Copyright © 2021 JKOS. All rights reserved.
//

import UIKit
import WebKit
import JJJSBridge
import SnapKit
import JJBundle

class openWebViewController: UIViewController {
    let webView = WKWebView()
    lazy var jsbridgeLoader = JJWebJSModuleLoader(webview: self.webView, webViewController: self, dispatcher: JKOAuthWebDispatcher())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.configWebView()
        configJSBridge2()
        self.loadResources()

    }
    
    private func configWebView() {
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func configJSBridge2() {
        jsbridgeLoader.build(with: [
                                    DemoJSModuleBuilder(name: "JKOCB",
                                                        webViewController: self,
                                                        webView: self.webView)
                                    ]
        )
    }
    private func loadResources() {
        let indexHtml = Bundle.main.fetchHTMLDocument(with: "openWebIndex") ?? ""
        webView.loadHTMLString(indexHtml, baseURL: nil)
    }

    deinit {
        print("openWeb deinit")
    }
}
