//
//  StoreController.swift
//  PokeCommerce
//
//  Created by Storm on 15/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit
import RealmSwift

class StoreController: UITableViewController {

    @IBOutlet weak var pokemonCell: UITableViewCell!
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var cardNumberCell: UITableViewCell!
    @IBOutlet weak var cardExperationCell: UITableViewCell!
    @IBOutlet weak var buyCell: UITableViewCell!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardMonth: UITextField!
    @IBOutlet weak var cardYear: UITextField!
    
    var pokemon: Pokemon?
    var priceString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setScreenAttributes()
        setContent()
    }
    
    fileprivate func setScreenAttributes() {
    
        self.title = "Store"
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "store-background"))
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        
        pokemonCell.backgroundColor = .clear
        nameCell.backgroundColor = .clear
        cardNumberCell.backgroundColor = .clear
        cardExperationCell.backgroundColor = .clear
        buyCell.backgroundColor = .clear
    }
    
    fileprivate func setContent() {
        
        guard let pokemon = self.pokemon else {
            return print("pokemon store nil")
        }
        
        self.pokemonName.text = pokemon.name
        self.price.text = priceString
        
        setImage(pokemon.image)
    }
    
    private func setImage(_ url: String) {
        
        Image.get(url: url, success: { image in
            self.pokemonImage.image = image
        })
    }
    
    @IBAction func buy(_ sender: UIButton) {
        
        guard let pokemon = self.pokemon else {
            return print("pokemon store nil")
        }
        
        let purchase = Purchase()
        purchase.name = pokemon.name
        purchase.price = priceString
        purchase.userName = "Nerd Stark"
        purchase.cardNumber = "0000 0000 0000 0000"
        purchase.date = Formatter.currentDate()
        purchase.image = pokemonImage?.image
        
        let realm = try! Realm()
        
        print(purchase)
        
        try! realm.write { realm.add(purchase) }
    }
}
