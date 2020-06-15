//
//  ReceivedOffersTableViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/7/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class ReceivedOffersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var senderImage: UIImageView!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var sendrRate: UILabel!
    @IBOutlet weak var offerStatus: UILabel!
    
    func setData(row: Int) {
        self.senderName.text = API.receivedOffersDetails[row].partyOneUserName!
        self.sendrRate.text = "⭐️" +  String(API.receivedOffersDetails[row].partyOneRating)
        if !API.receivedOffersDetails[row].trade.party2Accepted {
            self.offerStatus.text = "Pending"
        } else {
            self.offerStatus.text = "Accepted"
        }
        if API.receivedOffersDetails[row].partyOneProfilePicture != nil {
            let imageURLString = API.receivedOffersDetails[row].partyOneProfilePicture
            guard let imageURL:URL = URL(string: imageURLString!) else { return }
            senderImage.loadImge(withUrl: imageURL)
        } else {
            senderImage.image = UIImage(named: "applogo.png")
        }
    }
}
