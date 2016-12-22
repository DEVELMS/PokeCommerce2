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
    @IBOutlet weak var CCV: VSTextField!
    @IBOutlet weak var cardMonth: VSTextField!
    @IBOutlet weak var cardYear: VSTextField!
    
    lazy var creditCardModal: CreditCardModal = CreditCardModal(nibName: CreditCardModal.identifier, bundle: nil)
    var pokemon: Pokemon?
    var priceString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creditCardModal.delegate = self
        cardNumber.setFormatting("#### #### #### ####", replacementChar: "#")
        CCV.setFormatting("###", replacementChar: "#")
        cardMonth.setFormatting("##", replacementChar: "#")
        cardYear.setFormatting("##", replacementChar: "#")
        
        setScreenAttributes()
        setContent()
    }
    
    private func setScreenAttributes() {
    
        self.title = "Store"
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "store-background"))
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        
        pokemonCell.backgroundColor = .clear
        nameCell.backgroundColor = .clear
        cardNumberCell.backgroundColor = .clear
        cardExperationCell.backgroundColor = .clear
        buyCell.backgroundColor = .clear
        
        tableView.keyboardDismissMode = .onDrag
        
        hideKeyboardWhenTappedAround()
    }
    
//    private func addDoneButton() {
//        
//        let keyboardToolbar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 44)))
//        keyboardToolbar.sizeToFit()
//        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        
//        let doneBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "closeDown"), style: UIBarButtonItemStyle.done, target: view, action: #selector(UIView.endEditing(_:)))
//        
//        keyboardToolbar.items = [flexBarButton, doneBarButton]
//        
//        cardNumber.inputAccessoryView = keyboardToolbar
//        cardMonth.inputAccessoryView = keyboardToolbar
//        cardYear.inputAccessoryView = keyboardToolbar
//        CCV.inputAccessoryView = keyboardToolbar
//    }
    
    private func setContent() {
        
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
    
    private func checkFields() -> Bool {
    
        tintCell()
        
        guard let name = userName.text, let number = cardNumber.text, let ccv = CCV.text, let month = cardMonth.text, let year = cardYear.text else {
            return false
        }
        
        if name.characters.count >= 2, number.characters.count == 16, ccv.characters.count == 3, month.characters.count == 2, year.characters.count == 2 {
            return true
        }
        else { return false }
    }
    
    private func tintCell() {
    
        guard let name = userName.text, let number = cardNumber.text, let ccv = CCV.text, let month = cardMonth.text, let year = cardYear.text else {
            return
        }
        
        let errorColor = self.navigationController?.navigationBar.barTintColor
        
        if name.characters.count < 2 { nameCell.backgroundColor = errorColor }
        else { nameCell.backgroundColor = .clear }
        if number.characters.count < 16 { cardNumberCell.backgroundColor = errorColor }
        else if ccv.characters.count < 3 { cardNumberCell.backgroundColor = errorColor }
        else { cardNumberCell.backgroundColor = .clear }
        if month.characters.count < 2 { cardExperationCell.backgroundColor = errorColor }
        else if year.characters.count < 2 { cardExperationCell.backgroundColor = errorColor }
        else { cardExperationCell.backgroundColor = .clear }
    }
    
    @IBAction internal func buy(_ sender: UIButton) {
        
        guard let pokemon = self.pokemon else { return print("pokemon store nil") }
        
        if checkFields() {
         
            let purchase = Purchase()
            purchase.name = pokemon.name
            purchase.price = priceString
            purchase.userName = userName.text!
            purchase.cardNumber = cardNumber.text!
            purchase.month = cardMonth.text!
            purchase.year = cardYear.text!
            purchase.ccv = CCV.text!
            purchase.date = Formatter.currentDate()
            
            if let image = pokemonImage?.image {
                purchase.image = UIImagePNGRepresentation(image) as NSData?
            }
            
            creditCardModal.configModal(buyCell, purchase: purchase);
            self.present(creditCardModal, animated: true)
        }
        else {
            Alert.show(delegate: self, title: "Ué?", message: "Você deve preencher todos os campos para efetuar a transação, espertinho :)", buttonTitle: "OK") { _ in }
        }
    }
    
    // MARK - TextField Delegate
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIPopoverPresentationDelegate
    
    internal func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Buying Delegate
    
    internal func buyConfirmed(purchase: Purchase) {
        
        let realm = try! Realm()
        
        try! realm.write {
            
            realm.add(purchase)
            Alert.show(delegate: self, title: "Parabéns", message: "\(purchase.name) comprado pela bagatela de \(purchase.price), enjoy it :)") { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

// MARK: Keyboard Extension

extension StoreController {
    
    fileprivate func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StoreController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
