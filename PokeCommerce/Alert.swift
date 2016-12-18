//
//  Alert.swift
//  PokeCommerce
//
//  Created by Lucas M Soares on 17/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

struct Alert {
    
    static func show(title: String, message: String, buttonTitle: String? = nil, delegate: AnyObject, ok: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        var aux = buttonTitle
        if aux == nil { aux = "OK" }
        
        alert.addAction(UIAlertAction(title: aux, style: UIAlertActionStyle.default) {
            action in
            ok()
        })
        
        delegate.present(alert, animated: true, completion: nil)
    }
}
