//
//  ViewController.swift
//  JJJSBridge
//
//  Created by JJingLee on 04/19/2021.
//  Copyright (c) 2021 JJingLee. All rights reserved.
//

import UIKit
import WebKit
import JJJSBridge
import SnapKit
import JJBundle

class ViewController: UIViewController {
    let webView = WKWebView()
    let toNative = "toNative"
    var toJS = "toJS"
    lazy var preJS = """
        window.addEventListener('\(toJS)', function(e){ window.webkit.messageHandlers.\(toNative).postMessage({'func':'consoleLog', 'args':e.message});
            console.log('got toJS');
        })
    """
    lazy var postEvent = """

        function postEvent() {
            document.body.style.backgroundColor = "red";
            window.webkit.messageHandlers.toNative.postMessage({'func':'consoleLog', 'args':jsFunc("123")});
            var event = new CustomEvent("toJS", {
              detail: {
                hazcheeseburger: true
              }
            });
            window.dispatchEvent(event);
        };

    """
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configWebView()
        basicFunctionTests()
    }

    private func basicFunctionTests(){
        //add jsscript
        webView.jj_jsbridge.addJSScriptAfterRendered(postEvent)
        let indexHtml = Bundle.main.fetchHTMLDocument(with: "index") ?? ""
        webView.loadHTMLString(indexHtml, baseURL: nil)
        webView.jj_jsbridge.addHandler(with: toNative) { (data) in
            self.webView.jj_jsbridge.postEventToWindow(self.toJS, eventMsg: ["title":"anything"], {_,_ in })
        }
        webView.jj_jsbridge.addHandler(with: "toConsole") { (data) in
            print("data : \(data)")
            let vc = openWebViewController()
            self.present(vc, animated: true) {

            }
        }
        webView.jj_jsbridge.addHandler(with: "toDemoOpenWeb") { (data) in
            print("data : \(data)")
            let vc = DemoOpenWebViewController()
            self.present(vc, animated: true) {
                vc.startLoad(with:"index2")
            }
        }
    }

    private func configWebView() {
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

