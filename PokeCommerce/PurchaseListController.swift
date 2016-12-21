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

    fileprivate var dataBase: Realm?
    fileprivate var purchases: RealmSwift.Results<Purchase>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Purchases"
        
        dataBase = try! Realm()
        
        addRightBarButtonItems()
        updateData()
    }
    
    fileprivate func addRightBarButtonItems() {
        
        let cleanItem = UIBarButtonItem(title: "Clean", style: .plain, target: self, action: #selector(self.cleanPurchases))
        cleanItem.tintColor = .white
        
        self.navigationItem.setRightBarButtonItems([cleanItem], animated: true)
    }

    fileprivate func updateData() {
    
        guard let dataBase = self.dataBase else { return }
        
        purchases = dataBase.objects(Purchase.self).sorted(byProperty: "date", ascending: false)
        
        tableView.reloadData()
    }
    
    @objc fileprivate func cleanPurchases() {
        
        if purchases?.count == 0 {
            
            Alert.show(delegate: self, title: ";)", message: "You haven't purchases yet.", buttonTitle: "OK") { _ in }
        }
        else {
            
            Alert.show(delegate: self, title: "Are you sure?", message: "You will delete all your purchases doing this.", buttonTitle: "OK", hasChoice: true) { choice in
                
                if choice {
                    
                    guard let dataBase = self.dataBase else { return }
                    
                    try! dataBase.write { dataBase.deleteAll() }
                    
                    self.updateData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let purchases = self.purchases else { return 0 }
        
        if purchases.count == 0 { return 1 }
        
        return purchases.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let purchases = self.purchases else { return UITableViewCell() }
        
        if purchases.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasesEmpty", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseCell.identifier, for: indexPath) as! PurchaseCell
        cell.setContent(purchase: purchases[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let purchases = self.purchases, let dataBase = self.dataBase else { return }
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            try! dataBase.write {
                dataBase.delete(purchases[indexPath.row])
            }
            
            updateData()
        }
    }
}
