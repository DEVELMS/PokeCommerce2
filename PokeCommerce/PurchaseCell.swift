//
//  PurchaseCell.swift
//  PokeCommerce
//
//  Created by Lucas M Soares on 17/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class PurchaseCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buyerName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var date: UILabel!

    func setContent(purchase: Purchase) {
        
        self.name.text = purchase.name
        self.price.text = purchase.price
        self.buyerName.text = purchase.userName
        self.cardNumber.text = purchase.cardNumber
        self.date.text = purchase.date
        self.pokemonImage.image = purchase.image
    }
}
