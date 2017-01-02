//
//  PurchaseService.swift
//  PokeCommerce
//
//  Created by Storm on 22/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import RealmSwift
import UIKit

struct PurchaseService {
    
    fileprivate var dataBase: Realm?
    fileprivate var purchases: RealmSwift.Results<PurchaseRealm>?
    
    init() { dataBase = try! Realm() }
    
    mutating func getPurchases() -> [Purchase] {
        
        guard let dataBase = self.dataBase else { return [Purchase]() }
        
        purchases = dataBase.objects(PurchaseRealm.self).sorted(byProperty: "date", ascending: false)
        
        guard let purchases = self.purchases else { return [Purchase]() }
        
        return parsePurchases(purchases: purchases)
    }
    
    func remove(purchase: Purchase) {
        
        guard let dataBase = self.dataBase, let purchaseToDelete = dataBase.objects(PurchaseRealm.self).filter("date = '\(purchase.date)' AND name = '\(purchase.name)'").first else { return }
        
        try! dataBase.write { dataBase.delete(purchaseToDelete) }
    }
    
    func clean() {
        
        guard let dataBase = self.dataBase else { return }
        
        try! dataBase.write { dataBase.deleteAll() }
    }
    
    private func parsePurchases(purchases: RealmSwift.Results<PurchaseRealm>) -> [Purchase] {
        
        var parsedPurchases = [Purchase]()
        
        for purchase in purchases {
            
            var parsedPurchase = Purchase(name: purchase.name, price: purchase.price, userName: purchase.userName, cardNumber: purchase.cardNumber, ccv: purchase.ccv, month: purchase.month, year: purchase.year, date: purchase.date)
            
            if let data = purchase.image as? Data {
                parsedPurchase.image = UIImage(data: data)
            }
            
            parsedPurchases.append(parsedPurchase)
        }
        
        return parsedPurchases
    }
}
