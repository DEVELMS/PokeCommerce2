//
//  CollectionViewCell.swift
//  PokeCommerce
//
//  Created by Storm on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collection: UICollectionView!
    
    // MARK: UICollectionViewDelegate
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collection.delegate = dataSourceDelegate
        collection.dataSource = dataSourceDelegate
        collection.tag = row
        collection.setContentOffset(collection.contentOffset, animated:false)
        collection.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collection.contentOffset.x = newValue }
        get { return collection.contentOffset.x }
    }
}
