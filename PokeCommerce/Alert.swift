//
//  Alert.swift
//  PokeCommerce
//
//  Created by Lucas M Soares on 17/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

struct Alert {
    
    private init() {}
    
    static func show(delegate: AnyObject,title: String, message: String, buttonTitle: String? = nil, hasChoice: Bool? = nil, ok: @escaping (Bool) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        var aux = buttonTitle
        if aux == nil { aux = "OK" }
        
        alert.addAction(UIAlertAction(title: aux, style: UIAlertActionStyle.default) {
            action in
            ok(true)
        })
        
        if let choice = hasChoice, choice {
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                action in
                ok(false)
            })
        }
        
        delegate.present(alert, animated: true, completion: nil)
    }
}
