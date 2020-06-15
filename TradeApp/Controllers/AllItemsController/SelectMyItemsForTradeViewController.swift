//
//  SelectMyItemsForTradeViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/5/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire
class SelectMyItemsForTradeViewController: UIViewController {
    
    @IBOutlet weak var myItemTable: UITableView!
    @IBOutlet weak var sendTrade: UIButton!
    
    var item: ItemFS!
    
    var selectedItemForTrade = [ItemFS]()
    var itemArray = [ItemFS]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myItemTable.delegate = self
        myItemTable.dataSource = self
        
        myItemTable.allowsMultipleSelection = true
    }
    
    @IBAction func sendTrade(_ sender: Any) {
        if let path = myItemTable.indexPathsForSelectedRows {
            for item in path {
                selectedItemForTrade.append(API.myItems[item.row])
            }
            myItemTable.reloadData()
        }
        var itemIDArray = [String]()//to store id of selected items
        for item in selectedItemForTrade {
            itemIDArray.append(item.id)
        }

        let tradeVM = TradeVM(party1: API.user.id, party2: self.item.userId, requestedItems: [self.item.id], offeredItems: itemIDArray)

        
        NetworkLayer.proposeTrade(tradeVM: tradeVM)

        self.dismiss(animated: true, completion: nil)
    }

}


extension SelectMyItemsForTradeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return API.myItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyItemsTableViewCell")!
        
        let item = API.myItems[indexPath.row]
        //
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.details
        if item.images != nil {
            let imageURLString = item.images[0]
            let imageURL:URL = URL(string: imageURLString)!
            cell.imageView?.loadImge(withUrl: imageURL)
        } else {
            cell.imageView?.image = UIImage(named: "Logo.png")
        }
        //        cell.imageView?.image = UIImage(named: "PosterPlaceholder")
        //        if let posterPath = movie.posterPath {
        //            TMDBClient.downloadPosterImage(path: posterPath) { data, error in
        //                guard let data = data else {
        //                    return
        //                }
        //                let image = UIImage(data: data)
        //                cell.imageView?.image = image
        //                cell.setNeedsLayout()
        //            }
        //        }
        return cell
    }
    
    
}
