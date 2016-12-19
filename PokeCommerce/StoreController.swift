//
//  StoreController.swift
//  PokeCommerce
//
//  Created by Storm on 15/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit
import RealmSwift

class StoreController: UITableViewController, Buying {

    @IBOutlet weak var pokemonCell: UITableViewCell!
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var cardNumberCell: UITableViewCell!
    @IBOutlet weak var cardExperationCell: UITableViewCell!
    @IBOutlet weak var buyCell: UITableViewCell!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var cardNumber: VSTextField!
    @IBOutlet weak var CCV: UITextField!
    @IBOutlet weak var cardMonth: UITextField!
    @IBOutlet weak var cardYear: UITextField!
    
    lazy var creditCardModal: CreditCardModal = CreditCardModal(nibName: CreditCardModal.identifier, bundle: nil)
    var pokemon: Pokemon?
    var priceString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creditCardModal.delegate = self
        cardNumber.setFormatting("####-####-####-####", replacementChar: "#")
        
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
        
        guard let pokemon = self.pokemon else { return print("pokemon store nil") }
        
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
        
        guard let pokemon = self.pokemon else { return print("pokemon store nil") }
        
        let purchase = Purchase()
        purchase.name = pokemon.name
        purchase.price = priceString
        purchase.userName = "Nerd Stark"
        purchase.cardNumber = "0000 0000 0000 0000"
        purchase.date = Formatter.currentDate()
        
        if let image = pokemonImage?.image {
            purchase.image = UIImagePNGRepresentation(image) as NSData?
        }
        
        creditCardModal.configModal(buyCell, purchase: purchase);
        self.present(creditCardModal, animated: true)
    }
    
    // MARK: UIPopoverPresentationDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Buying Delegate
    
    func buyConfirmed(purchase: Purchase) {
        
        let realm = try! Realm()
        
        try! realm.write {
            
            realm.add(purchase)
            Alert.show(title: "Parabéns", message: "\(purchase.name) comprado!", delegate: self) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
