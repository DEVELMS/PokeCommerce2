//
//  Purchase.swift
//  PokeCommerce
//
//  Created by Storm on 16/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import RealmSwift
import UIKit

class PurchaseRealm: Object {
    
    dynamic var name = ""
    dynamic var price = ""
    dynamic var userName = ""
    dynamic var cardNumber = ""
    dynamic var ccv = ""
    dynamic var month = ""
    dynamic var year = ""
    dynamic var date = ""
    dynamic var image: NSData? = nil
}
