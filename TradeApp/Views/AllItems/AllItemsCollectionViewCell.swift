//
//  AllItemsCollectionViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/21/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class AllItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func setData(data: ItemFS) {
        self.itemName.text = data.name
        if data.images != nil {
            let imageURLString = data.images[0]
            guard let imageURL:URL = URL(string: imageURLString) else { return }
            itemImage.loadImge(withUrl: imageURL)
        } else {
            itemImage.image = UIImage(named: "applogo.png")
        }
    }
}
