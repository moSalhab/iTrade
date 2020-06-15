//
//  SentOffersViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/5/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire

class SentOffersViewController: UIViewController {
    
    
    @IBOutlet weak var sentOffers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentOffers.delegate = self
        sentOffers.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkLayer.getSentOffersInfo(userID: API.user.id!, controller: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SentOfferDetailsViewController" {
            let dataSegue = segue.destination as! SentOfferDetailsViewController
            let cell = sender as! UITableViewCell
            let indexPath = sentOffers.indexPath(for: cell)
            let sentOffersData = API.sentOffersDetails[(indexPath?.row)!]
            dataSegue.sentOffersDetails = sentOffersData
        }
    }
}

extension SentOffersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return API.sentOffersDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewCell = tableView.dequeueReusableCell(withIdentifier: "SentOffersTableViewCell", for: indexPath) as! SentOffersTableViewCell
        viewCell.setData(row: indexPath.row)
        return viewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let request = AF.request("http://furniture.sketchandscript.com/api/trades/RefuseTrade?tradeId=" + API.sentOffersDetails[indexPath.row].trade.id + "&userId=" + API.user.id!)
            request.responseDecodable(of : Bool.self){
                (response) in
                guard let deleteItemFS = response.value else {debugPrint("Error can't delete this item  : \(response)")
                    return
                }
                if(deleteItemFS) {
                    API.sentOffersDetails.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.sentOffers.reloadData()
                }
            }
        }
    }
}


