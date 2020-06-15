//
//  SentOffersTableViewCell.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/6/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class SentOffersTableViewCell: UITableViewCell {

    @IBOutlet weak var receiverImage: UIImageView!
    @IBOutlet weak var receiverName: UILabel!
    @IBOutlet weak var receiverRate: UILabel!
    @IBOutlet weak var offerStatus: UILabel!
    
    func setData(row: Int) {
        self.receiverName.text = API.sentOffersDetails[row].partyTwoUserName!
        self.receiverRate.text = "⭐️ " +  String(API.sentOffersDetails[row].partyTwoRating)
        if API.sentOffersDetails[row].trade.party2Accepted {
            self.offerStatus.text = "Accepted"
        } else {
            self.offerStatus.text = "Pending"
        }
        if API.sentOffersDetails[row].partyTwoProfilePicture != nil {
            let imageURLString = API.sentOffersDetails[row].partyTwoProfilePicture
            guard let imageURL:URL = URL(string: imageURLString!) else { return }
            receiverImage.loadImge(withUrl: imageURL)
        } else {
            receiverImage.image = UIImage(named: "applogo.png")
        }
    }
}
