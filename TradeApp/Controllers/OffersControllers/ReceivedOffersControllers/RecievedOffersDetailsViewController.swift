//
//  RecievedOffersDetailsViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/8/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire
class RecievedOffersDetailsViewController: UIViewController {

    @IBOutlet weak var myItemsRequested: UITableView!
    @IBOutlet weak var offeredItems: UITableView!
    var receivedOffersDetails: GetRecievedTradeDetails!
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var showUserInfo: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showUserInfo.isEnabled = false
        showUserInfo.isHidden = true
        
        myItemsRequested.delegate = self
        myItemsRequested.dataSource = self
        
        offeredItems.delegate = self
        offeredItems.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if receivedOffersDetails.trade.party2Accepted {
            acceptButton.isHidden = true
            acceptButton.isEnabled = false
            
            declineButton.isHidden = true
            declineButton.isEnabled = false
            
            showUserInfo.isEnabled = true
            showUserInfo.isHidden = false
        }
    }
    
    @IBAction func rejectOffer(_ sender: Any) {
        NetworkLayer.rejectOffer(offerID: receivedOffersDetails.trade.id, userID: API.user.id!, controller: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmLocationViewController" {
            let dataSegue = segue.destination as! ConfirmLocationViewController
            dataSegue.getUserInfo = receivedOffersDetails
        } else if segue.identifier == "ShowSenderInfoViewController" {
            let dataSegue = segue.destination as! ShowSenderInfoViewController
            dataSegue.getUserInfo = receivedOffersDetails
        }
    }
}


extension RecievedOffersDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.myItemsRequested {
            return receivedOffersDetails.requestedItems.count
        } else {
            return receivedOffersDetails.offeredItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.myItemsRequested {
            let viewCell = tableView.dequeueReusableCell(withIdentifier: "MyItemsRequestedTableViewCell", for: indexPath) as! MyItemsRequestedTableViewCell
            let item = receivedOffersDetails.requestedItems[indexPath.row]
            let itemName = receivedOffersDetails.requestedItems[indexPath.row].name
            let itemQuantity = String(receivedOffersDetails.requestedItems[indexPath.row].quantity)
            let itemPrice = String(receivedOffersDetails.requestedItems[indexPath.row].price)
            viewCell.setData(item: item, itemName: itemName, itemQuantity: itemQuantity, itemPrice: itemPrice)
            return viewCell
        } else {
            let viewCell = tableView.dequeueReusableCell(withIdentifier: "OfferedItemsTableViewCell", for: indexPath) as! OfferedItemsTableViewCell
            let item = receivedOffersDetails.offeredItems[indexPath.row]
            let itemName = receivedOffersDetails.offeredItems[indexPath.row].name
            let itemQuantity = String(receivedOffersDetails.offeredItems[indexPath.row].quantity)
            let itemPrice = String(receivedOffersDetails.offeredItems[indexPath.row].price)
            viewCell.setData(item: item, itemName: itemName, itemQuantity: itemQuantity, itemPrice: itemPrice)
            return viewCell
        }
    }
    
}
