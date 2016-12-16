//
//  PokemonDetailController.swift
//  PokeCommerce
//
//  Created by Storm on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class PokemonDetailController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var weakness: UILabel!
    @IBOutlet weak var typesBotMargin: NSLayoutConstraint!
    @IBOutlet weak var weaknessBotMargin: NSLayoutConstraint!
    
    var pokemon: Pokemon?
    var priceString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContent()
    }

    func setContent() {
        
        guard let pokemon = self.pokemon else {
            return print("pokemon detail nil")
        }
        
        self.title = pokemon.name
        
        self.pokemonDescription.text = pokemon.description
        self.price.text = priceString
        
        setImage(pokemon.image)
        setBackground(pokemon.types)
        addTypes(pokemon.types)
        addWeakness(pokemon.weakness)
    }
    
    private func setImage(_ url: String) {
        
        Image.get(url: url, success: { image in
            self.pokemonImage.image = image
        })
    }
    
    private func setBackground(_ types: [Kind]) {
    
        if types.contains(where: { $0.option == Kind.Option.fire }) {
            self.background.image = #imageLiteral(resourceName: "fire-background")
        }
        else if types.contains(where: { $0.option == Kind.Option.flying }) {
            self.background.image = #imageLiteral(resourceName: "sky-background")
        }
        else if types.contains(where: { $0.option == Kind.Option.water }) {
            self.background.image = #imageLiteral(resourceName: "water-background")
        }
        else { self.background.image = #imageLiteral(resourceName: "default-background") }
    }
    
    private func addTypes(_ kinds: [Kind]) {
        
        var y: CGFloat = 25
        let margins = self.view.layoutMarginsGuide
        
        for kind in kinds {
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = kind.option.image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(imageView)
            
            imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: -10).isActive = true
            imageView.bottomAnchor.constraint(equalTo: types.bottomAnchor, constant: y).isActive = true
            
            y += 25
        }
    }
    
    private func addWeakness(_ kinds: [Kind]) {
        
        var y: CGFloat = 25
        let margins = self.view.layoutMarginsGuide
        
        for kind in kinds {
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = kind.option.image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(imageView)

            imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
            imageView.bottomAnchor.constraint(equalTo: weakness.bottomAnchor, constant: y).isActive = true
            
            y += 25
        }
    }
    
    @IBAction func buy(_ sender: UIButton) {
        
        performSegue(withIdentifier: "sgStore", sender: nil)
    }
    
    // MARK: - Navigation
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
                
            case "sgStore":
                
                if let storeController = segue.destination as? StoreController {
                    
                    storeController.pokemon = pokemon
                    storeController.priceString = priceString
                }
                
            default: print("Identifier \(identifier) isn't a valid segue")
            }
        }
    }
}
