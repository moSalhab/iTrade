//
//  MyItemsViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/9/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
class MyItemsViewController: UIViewController {

    @IBOutlet weak var myItemsTableView: UITableView!
    
    var user: UserData!

    let fetchRequst: NSFetchRequest<UserData> = UserData.fetchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let result = try? API.dataController.viewContext.fetch(fetchRequst) {
            user = result.first
            API.user.id = user.id
            API.user.address = user.address
            API.user.email = user.email
            API.user.firstName = user.firstName
            API.user.lastName = user.lastName
            API.user.phoneNumber = user.phoneNumber
        }
        myItemsTableView.dataSource = self
        myItemsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkLayer.getUserItems(controller: self)
//        let request = AF.request("http://furniture.sketchandscript.com/api/items/GetUserItems?userid=" + API.user.id!)
//        request.responseDecodable( of: [ItemFS].self){
//            (response) in
//            guard let items = response.value else {
//                debugPrint(response)
//                let alert = UIAlertController(title: "Internet connection fails", message: "Please check the connection of the Internet network to load your items", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
//                self.present(alert,animated:true,completion:nil)
//                return
//            }
//            API.myItems = items
//            self.myItemsTableView.reloadData()
//        }
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
        if segue.identifier == "details" {
            let dataSegue = segue.destination as! MyItemDetailsViewController
            let cell = sender as! UITableViewCell
            let indexPath = myItemsTableView.indexPath(for: cell)
            let itemdata = API.myItems[(indexPath?.row)!]
            dataSegue.item = itemdata
        }
        else if segue.identifier == "add" {
            let _ = segue.destination as! AddItemViewController
        }
    }
}

extension MyItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return API.myItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewCell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! MyItemsTableViewCell
        viewCell.setData(data: API.myItems[indexPath.row])
        return viewCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let request = AF.request("http://furniture.sketchandscript.com/api/items/DeleteItem?itemId=" + API.myItems[indexPath.row].id + "&userId=" + API.user.id!)
            request.responseDecodable(of: Bool.self){
                (response) in
                guard let deleteItemFS = response.value else {debugPrint("Error can't delete this item: \(response)")
                    return
                }
                if(deleteItemFS) {
                    API.myItems.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.myItemsTableView.reloadData()
                }
            }
        }
    }
}
