//
//  OffersViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/9/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import CoreData

class OffersViewController: UIViewController {

    @IBOutlet weak var segmentOffer: UISegmentedControl!
    
    @IBOutlet weak var sentOffers: UIView!
    @IBOutlet weak var recievedOffers: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sentOffers.isHidden = false
        recievedOffers.isHidden = true

    }
    
    
    @IBAction func segmentSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sentOffers.isHidden = false
            recievedOffers.isHidden = true
        case 1:
            sentOffers.isHidden = true
            recievedOffers.isHidden = false
        default:
            break
        }
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
}
