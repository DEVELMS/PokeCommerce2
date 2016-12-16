//
//  PokemonCollectionCell.swift
//  PokeCommerce
//
//  Created by Storm on 13/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class PokemonCollectionCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!

    func setContent(pokemon: Pokemon) {
        
        self.name.text = pokemon.name
        setImage(pokemon.image)
        addTypes(pokemon.types)
    }
    
    private func setImage(_ url: String) {
        
        Image.get(url: url, success: { image in
            self.image.image = image
        })
    }
    
    private func addTypes(_ types: [Kind]) {
        
        let width: CGFloat = 40
        let height: CGFloat = 25
        let x: CGFloat = self.frame.width - width - 5
        var y: CGFloat = 5
        
        for type in types {
            
            let imageView = UIImageView()
            imageView.frame = CGRect(x: x, y: y, width: width, height: height)
            imageView.contentMode = .scaleAspectFit
            imageView.image = type.option.image
            
            self.addSubview(imageView)
            
            y += 20
        }
    }
}
