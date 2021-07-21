//
//  JJWebJSHandlerLoader.swift
//  JJJSBridge
//
//  Created by 李杰駿 on 2021/7/21.
//

import Foundation
import WebKit

public class JJWebJSModuleLoader {
    private var _eventHandler : JJWebJSFunctionEventDispatcher?
    weak var _webview : WKWebView?
    weak var _webviewViewController : UIViewController?
    var _dispatcher : JJWebJSHandlerDispatchFormat
    public init(webview : WKWebView, webViewController : UIViewController? = nil, dispatcher : JJWebJSHandlerDispatchFormat) {
        _webview = webview
        _dispatcher = dispatcher
        _webviewViewController = webViewController
    }
    private func buildCallFunctionJS(moduleName:String, functions:[JJWebJSFunction], functionKey:String, argsKey:String)->String {
        var functionsScript : String = "class \(moduleName) {"
        var otherScripts : String = ""

        functions.forEach { (function) in
            functionsScript +=
            """
                \(function.functionName)(...args) {
                    window.webkit.messageHandlers.\(moduleName).postMessage({'\(functionKey)':'\(function.functionName)', '\(argsKey)': args});
                }

            """
            if function.functionJSScript().count > 0 {
                otherScripts += function.functionJSScript()
            }
        }

        functionsScript += "\n}"
        functionsScript += "\n\(otherScripts)"
        return functionsScript
    }
    public func load(_ modules : [JJWebJSModule])->Self {
        modules.forEach { [weak self](module) in
            guard let _self = self else {return}

            //load function js
            let moduleCallFuncJS = buildCallFunctionJS(moduleName: module.name, functions: module.jsFunctions, functionKey: _dispatcher.functionKey, argsKey: _dispatcher.argsKey)
            self?._webview?.jj_jsbridge.addJSScriptBeforeRendered(moduleCallFuncJS)

            //inject all scripts.
            module.jsScripts.forEach { (script) in
                self?._webview?.jj_jsbridge.addJSScriptBeforeRendered(script)
            }

            //listen to module event(event name of messageHandler).
            _self._webview?.jj_jsbridge.addHandler(with: module.name, subscribe: { (msg) in
                guard let eventHandler = self?._eventHandler else {return}
                //check the target function of event (parse from msg with specific format).
                self?._dispatcher.parse(msg)
                let functionName = self?._dispatcher.functionName ?? "", args = self?._dispatcher.args ?? []
                let jsFunc = module.jsFunctions.first(where: {$0.functionName == functionName})
                jsFunc?.dispatchMethod(args: args, with: eventHandler)
            })
        }
        return self
    }
    public func observe(_ eventHandler : JJWebJSFunctionEventDispatcher) {
        _eventHandler = eventHandler
    }

    @discardableResult public func build(with moduleBuilders : [JJWebBaseJSModuleBuilder])->Self {
        //Modules
        let modules = moduleBuilders.reduce(Array<JJWebJSModule>()) { (modules, builder) -> Array<JJWebJSModule> in
            var newModules = modules
            newModules.append(builder.jsModule)
            return newModules
        }
        //[ModuleName : EventHandlers]
        let eventHandlers = moduleBuilders.reduce([String:[JJWebJSFunctionEventHandler]]()) { [weak self](handlerMap, builder) -> [String:[JJWebJSFunctionEventHandler]] in
            var newHandlerMap = handlerMap
            var eventHandlers : [JJWebJSFunctionEventHandler] = []
            builder.eventHandlers.forEach({
                $0.webview = self?._webview; $0.webViewController = self?._webviewViewController;eventHandlers.append($0)
            })
            newHandlerMap[builder.name] = eventHandlers
            return newHandlerMap
        }
        //Load js modules to web
        self.load(modules)
            //observe event from functions in module
            .observe(JJWebJSFunctionEventDispatcher(eventHandler: { (event) in
            let moduleName = event.module
            let functionName = event.name
            let data = event.data
            print("calling event : \(moduleName).\(functionName)")
            guard let eventHandler = eventHandlers[moduleName]?.first(where: {$0.functionName() == functionName}) else {return}
            eventHandler.sendEvent(with: data)
        }))
        return self
    }
}
