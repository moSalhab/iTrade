//
//  itemDetailsViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/22/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit

class MyItemDetailsViewController: UIViewController {

    


    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var defaultImage: UIImageView!
    
    var item: ItemFS!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionLayout()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        itemName.text = item.name
        itemPrice.text = "$" + String(item.price)
        itemDescription.text = item.details
        
        if item.images == nil {//to check if the item has images for default photo
            defaultImage.isHidden = false
        } else {
            defaultImage.isHidden = true
        }
    }
    
    


    
}

extension MyItemDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if item.images != nil {
            return item.images.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyItemImagesCollectionViewCell", for: indexPath) as! MyItemImagesCollectionViewCell
        
        viewCell.setData(data: item.images[indexPath.row])

        return viewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let imageController = self.storyboard!.instantiateViewController(withIdentifier: "ViewImageViewController") as! ViewImageViewController
        imageController.imageURLString = item.images[indexPath.row]
        navigationController!.pushViewController(imageController, animated: true)
    }
}
