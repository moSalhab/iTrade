//
//  SentOfferDetailsViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/6/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class SentOfferDetailsViewController: UIViewController {
    
    @IBOutlet weak var myItemsOffered: UITableView!
    @IBOutlet weak var requestedItemsOffered: UITableView!
    @IBOutlet weak var tradeStatus: UILabel!
    @IBOutlet weak var showUserInfo: UIButton!
    
    var sentOffersDetails: GetSentTradeDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myItemsOffered.delegate = self
        myItemsOffered.dataSource = self
        
        requestedItemsOffered.delegate = self
        requestedItemsOffered.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if sentOffersDetails.trade.party2Accepted {
            tradeStatus.text = "Accepted"
            showUserInfo.isEnabled = true
            showUserInfo.isHidden = false
        } else {
            tradeStatus.text = "Pending"
            showUserInfo.isEnabled = false
            showUserInfo.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserInfoViewController" {
            let dataSegue = segue.destination as! ShowUserInfoViewController
            dataSegue.getUserInfo = sentOffersDetails
        }
    }
}

extension SentOfferDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.myItemsOffered {
            return sentOffersDetails.offeredItems.count
        } else {
            return sentOffersDetails.requestedItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.myItemsOffered {
            let viewCell = tableView.dequeueReusableCell(withIdentifier: "MyItemsOfferedTableViewCell", for: indexPath) as! MyItemsOfferedTableViewCell
            let item = sentOffersDetails.offeredItems[indexPath.row]
            let itemName = sentOffersDetails.offeredItems[indexPath.row].name
            let itemQuantity = String(sentOffersDetails.offeredItems[indexPath.row].quantity)
            let itemPrice = String(sentOffersDetails.offeredItems[indexPath.row].price)
            viewCell.setData(item: item, itemName: itemName, itemQuantity: itemQuantity, itemPrice: itemPrice)
            return viewCell
        } else {
            let viewCell = tableView.dequeueReusableCell(withIdentifier: "RequestedItemsTableViewCell", for: indexPath) as! RequestedItemsTableViewCell
            let item = sentOffersDetails.requestedItems[indexPath.row]
            let itemName = sentOffersDetails.requestedItems[indexPath.row].name
            let itemQuantity = String(sentOffersDetails.requestedItems[indexPath.row].quantity)
            let itemPrice = String(sentOffersDetails.requestedItems[indexPath.row].price)
            viewCell.setData(item: item, itemName: itemName, itemQuantity: itemQuantity, itemPrice: itemPrice)
            return viewCell
        }
    }
}

