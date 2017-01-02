//
//  PurchaseListController.swift
//  PokeCommerce
//
//  Created by Lucas M Soares on 17/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class PurchaseListController: UITableViewController {

    fileprivate var purchaseService = PurchaseService()
    fileprivate var purchases = [Purchase]()
    fileprivate let rowHeight: CGFloat = 230
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Purchases"
        
        addRightBarButtonItems()
        updateData()
    }
    
    fileprivate func addRightBarButtonItems() {
        
        let cleanItem = UIBarButtonItem(title: "Clean", style: .plain, target: self, action: #selector(self.cleanPurchases))
        cleanItem.tintColor = .white
        
        self.navigationItem.setRightBarButtonItems([cleanItem], animated: true)
    }

    fileprivate func updateData() {
    
        purchases = purchaseService.getPurchases()
        tableView.reloadData()
    }
    
    @objc fileprivate func cleanPurchases() {
        
        if purchases.count == 0 {
            
            Alert.show(delegate: self, title: ";)", message: "You haven't purchased yet.", buttonTitle: "OK") { _ in }
        }
        else {
            
            Alert.show(delegate: self, title: "Are you sure?", message: "You will delete all your purchases doing this.", buttonTitle: "OK", hasChoice: true) { choice in
                
                if choice {
                    self.purchaseService.clean()
                    self.updateData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if purchases.count == 0 { return 1 }
        
        return purchases.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            purchaseService.remove(purchase: purchases[indexPath.row])
            updateData()
        }
    }
}
