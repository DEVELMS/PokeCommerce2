//
//  PokemonListController.swift
//  PokeCommerce
//
//  Created by Storm on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class PokemonListController: UITableViewController {
    
    fileprivate var storedOffsets = [Int: CGFloat]()
    fileprivate var sectionHeight = CGFloat(50)
    fileprivate var cellHeight = CGFloat(221)
    fileprivate let application = Application.sharedInstance
    fileprivate var itemSelected: (price: String, pokemon: Pokemon)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexadecimal: 0xf23937)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Table view data source
    
    override internal func numberOfSections(in tableView: UITableView) -> Int {
        
        return application.sections.count
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sectionHeight
    }
    
    override internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: sectionHeight))
        header.backgroundColor = .white
        
        let title = UILabel(frame: CGRect(x: 10, y: 8, width: view.frame.width, height: 20))
        title.text = application.sections[section].name
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .darkGray
        header.addSubview(title)
        
        let price = UILabel(frame: CGRect(x: 10, y: 28, width: view.frame.width, height: 15))
        price.text = String(Formatter.moneyFormat(value: application.sections[section].price))
        price.font = UIFont.systemFont(ofSize: 14)
        price.textColor = .darkGray
        header.addSubview(price)
        
        return header
    }
    
    override internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
        
        return cell
    }
    
    override internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CollectionCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.section] ?? 0
    }
    
    override internal func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CollectionCell else { return }
        
        storedOffsets[indexPath.section] = tableViewCell.collectionViewOffset
    }
}

extension PokemonListController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return application.sections[collectionView.tag].pokemons.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionCell.identifier, for: indexPath) as! PokemonCollectionCell
        
        cell.setContent(pokemon: application.sections[collectionView.tag].pokemons[indexPath.item])
        
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        itemSelected = (price: Formatter.moneyFormat(value: application.sections[collectionView.tag].price), pokemon: application.sections[collectionView.tag].pokemons[indexPath.item])
        
        performSegue(withIdentifier: "sgDetail", sender: nil)
    }
    
    // MARK: - Navigation
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
                
            case "sgDetail":
                
                if let detailController = segue.destination as? PokemonDetailController {
                    
                    guard let pokemon = itemSelected?.pokemon, let price = itemSelected?.price else {
                        return print("pokemon selected not valid")
                    }
                    
                    detailController.pokemon = pokemon
                    detailController.priceString = price
                }
                
            default: print("Identifier \(identifier) isn't a valid segue")
            }
        }
    }
}
