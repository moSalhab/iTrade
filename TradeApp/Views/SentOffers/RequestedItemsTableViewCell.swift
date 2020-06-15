//
//  ReceiverItemsTableViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/6/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class RequestedItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
     func setData(item: ItemFS, itemName: String, itemQuantity: String, itemPrice: String){
           self.itemName.text = itemName
           self.itemQuantity.text = itemQuantity
           self.itemPrice.text = "$" + itemPrice
           if item.images != nil {
               let imageURLString = item.images[.zero]
               guard let imageURL:URL = URL(string: imageURLString) else { return }
               self.itemImage.loadImge(withUrl: imageURL)
           } else {
               self.itemImage.image = UIImage(named: "applogo.png")
           }
       }
}
