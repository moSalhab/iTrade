//
//  SignUpViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 3/30/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var fetchedResultsController:NSFetchedResultsController<UserData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signIn(_ sender: Any) {

        
        if (!userEmail.text!.isEmpty && !password.text!.isEmpty) {
            
            NetworkLayer.login(username: userEmail.text!, password: password.text!, controller: self)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill username and password.",preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
            self.present(alert,animated:true,completion:nil)
        }
    }
    
    
    func goToMainPage() {
        
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController") as? UITabBarController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
}
