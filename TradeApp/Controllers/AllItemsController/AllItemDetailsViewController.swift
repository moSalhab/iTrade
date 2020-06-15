//
//  AllItemDetailsViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/22/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class AllItemDetailsViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemOwner: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var defaultImage: UIImageView!
    
    @IBOutlet weak var tradeButton: UIButton!
    
    var item: ItemFS!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        itemName.text = item.name
        itemPrice.text = "$" + String(item.price)
        itemOwner.text = item.itemOwnerName
        itemDescription.text = item.details
        defaultImage.isHidden = true
        if item.images == nil {//to check if the item has images for default photo
            defaultImage.isHidden = false
        }
        
        

        if item.userId == API.user.id! || API.myItems.count == 0 { //to hide the trade button if the item is mine or if the user does not have items
            tradeButton.isHidden = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! SelectMyItemsForTradeViewController
        segue.item = self.item
    }
}


extension AllItemDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("item.images.count")
        if item.images != nil {
            return item.images.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllItemImagesCollectionViewCell", for: indexPath) as! AllItemImagesCollectionViewCell
        //print(API.allItems[indexPath.row].name)
        //itemDescription.layer.borderColor = UIColor.black.cgColor
        //itemDescription.layer.borderWidth = 1
        
        viewCell.setData(data: item.images[indexPath.row])
        //viewCell.itemImage.image = UIImage(named: "iMac.png")

        return viewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let imageController = self.storyboard!.instantiateViewController(withIdentifier: "ViewImageViewController") as! ViewImageViewController
        imageController.imageURLString = item.images[indexPath.row]
        navigationController!.pushViewController(imageController, animated: true)
    }
}
