//
//  AddItemImagesCollectionViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/4/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class AddItemImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    func setData(data: UIImage) {
        self.itemImage.image = data
    }
    
}
