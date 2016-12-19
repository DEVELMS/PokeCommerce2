//
//  CreditCardModal.swift
//  PokeCommerce
//
//  Created by Storm on 19/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class CreditCardModal: UIViewController {

    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var CCV: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var clientName: UILabel!
    
    var delegate: Buying?
    private var purchase: Purchase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let purchase = self.purchase else {
            return print("purchase is not valid")
        }
        
        cardNumber.text = purchase.cardNumber
        clientName.text = purchase.userName
        CCV.text = "123"
        month.text = "10"
        year.text = "12"
    }
    
    func configModal(_ sender: UIView, purchase: Purchase) {
        
        guard let delegate = delegate else { return print("CreditCardModal delegate not setted") }
        
        let width: CGFloat = 320
        let height: CGFloat = 240
        let x: CGFloat = sender.bounds.width / 2
        let y: CGFloat = 0
        
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.backgroundColor = .white
        self.popoverPresentationController?.permittedArrowDirections = .down
        self.popoverPresentationController?.sourceRect = CGRect(x: x, y: y, width: 0, height: 0)
        self.preferredContentSize = CGSize(width: width, height: height)
        self.popoverPresentationController?.delegate = delegate
        self.popoverPresentationController?.sourceView = sender
        
        self.purchase = purchase
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        self.dismiss(animated: true)
        
        guard let delegate = delegate, let purchase = self.purchase else { return }
        
        delegate.buyConfirmed(purchase: purchase)
    }
}
