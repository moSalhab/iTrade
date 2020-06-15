//
//  MyItemsTableViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/21/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class MyItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
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
