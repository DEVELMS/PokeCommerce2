//
//  PurchaseListController.swift
//  PokeCommerce
//
//  Created by Lucas M Soares on 17/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit
import RealmSwift

class PurchaseListController: UITableViewController {

    fileprivate var purchases: RealmSwift.Results<Purchase>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Purchases"
        
        let realm = try! Realm()
        purchases = realm.objects(Purchase.self).sorted(byProperty: "date", ascending: false)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let purchases = self.purchases else { return 0 }
        
        return purchases.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let purchases = self.purchases else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseCell.identifier, for: indexPath) as! PurchaseCell
        
        cell.setContent(purchase: purchases[indexPath.row])
        
        return cell
    }
}
