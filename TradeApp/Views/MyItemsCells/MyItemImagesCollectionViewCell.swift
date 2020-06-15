//
//  MyItemImagesCollectionViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/2/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class MyItemImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    func setData(data: String) {
            let imageURLString = data
            guard let imageURL:URL = URL(string: imageURLString) else { return }
            itemImage.loadImge(withUrl: imageURL)
    }
}
