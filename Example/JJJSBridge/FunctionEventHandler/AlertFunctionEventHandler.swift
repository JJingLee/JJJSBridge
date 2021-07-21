//
//  AlertFunctionEventHandler.swift
//  JJJSBridge_Example
//
//  Created by chiehchun.lee on 2021/5/5.
//  Copyright © 2021 JKOS. All rights reserved.
//

import Foundation
import JJJSBridge

class AlertFunctionEventHandler : JJWebJSFunctionEventHandler {
    override func sendEvent(with data: Any?) {
        guard let json = data as? [String:Any], let vc = self.webViewController, let msg = json["msg"] as? String else {return}

        let alert = UIAlertController(title: "alert!", message: (msg) , preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        vc.present(alert, animated: false, completion: nil)
    }
}
