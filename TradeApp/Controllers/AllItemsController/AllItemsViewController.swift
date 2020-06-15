//
//  AllItemsViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/9/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class AllItemsViewController: UIViewController {
    
    @IBOutlet weak var allItemsCollectionView: UICollectionView!
    
    private let sectionInsets = UIEdgeInsets(top: 5.0,
                                             left: 20,
                                             bottom: 5.0,
                                             right: 20)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        allItemsCollectionView.delegate = self
        allItemsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkLayer.getUserItems(controller: self)
    }
    
    @IBAction func logout(_ sender: Any) {
        clearUserInfo()
            let signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "initialViewController") as! UINavigationController
            self.view.window?.rootViewController = signInViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        
        func clearUserInfo() {
            let managedContext = API.dataController.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let arrUsrObj = try managedContext.fetch(fetchRequest)
                for usrObj in arrUsrObj as! [NSManagedObject] {
                    managedContext.delete(usrObj)
                }
                try managedContext.save() //don't forget
            } catch let error as NSError {
                print("delete fail--",error)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dataSegue = segue.destination as! AllItemDetailsViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = allItemsCollectionView.indexPath(for: cell)
        let itemdata = API.allItems[(indexPath?.row)!]
        dataSegue.item = itemdata
    }
}

extension AllItemsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * 3
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2.1
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return API.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! AllItemsCollectionViewCell
        print(API.allItems[indexPath.row].name)
        viewCell.layer.borderColor = UIColor.black.cgColor
        viewCell.layer.borderWidth = 1
        viewCell.layer.cornerRadius = 10
        viewCell.setData(data: API.allItems[indexPath.row])
        return viewCell
    }
}
