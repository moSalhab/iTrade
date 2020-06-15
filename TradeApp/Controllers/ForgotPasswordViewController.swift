//
//  ForgotPasswordViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/9/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire
class ForgotPasswordViewController: UIViewController {
    
    
    
    @IBOutlet weak var userName: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        if(!userName.text!.isEmpty) {
            NetworkLayer.forgotPassword(username: userName.text!, controller: self)
        } else {
            //self.userName.isHidden = false
            self.userName.text = "Please enter user name"
            self.userName.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    
}
