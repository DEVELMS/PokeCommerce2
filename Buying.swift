//
//  Buying.swift
//  PokeCommerce
//
//  Created by Storm on 19/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

protocol Buying: UIPopoverPresentationControllerDelegate {

    func buyConfirmed(purchase: PurchaseRealm)
}
