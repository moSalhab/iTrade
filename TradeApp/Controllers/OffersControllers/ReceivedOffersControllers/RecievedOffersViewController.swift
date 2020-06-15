//
//  RecievedOffersViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/5/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire
class RecievedOffersViewController: UIViewController {

    @IBOutlet weak var receivedOffers: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        receivedOffers.delegate = self
        receivedOffers.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkLayer.getreceivedOffersInfo(userID: API.user.id!, controller: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecievedOffersDetailsViewController" {
            let dataSegue = segue.destination as! RecievedOffersDetailsViewController
            let cell = sender as! UITableViewCell
            let indexPath = receivedOffers.indexPath(for: cell)
            let receivedOffersData = API.receivedOffersDetails[(indexPath?.row)!]
            dataSegue.receivedOffersDetails = receivedOffersData
        }
    }
}

extension RecievedOffersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return API.receivedOffersDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewCell = tableView.dequeueReusableCell(withIdentifier: "ReceivedOffersTableViewCell", for: indexPath) as! ReceivedOffersTableViewCell
        viewCell.setData(row: indexPath.row)
        return viewCell
    }
}
