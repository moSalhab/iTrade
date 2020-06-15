//
//  SignUpViewController.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/8/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func Register(_ sender: Any) {
        
        if username.text!.isEmpty || firstName.text!.isEmpty || lastName.text!.isEmpty || email.text!.isEmpty || phoneNo.text!.isEmpty || password.text!.isEmpty || rePassword.text!.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Please fill all fields",preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
                self.present(alert,animated:true,completion:nil)
        } else {

            if password.text! != rePassword.text! {
                let alert = UIAlertController(title: "Error", message: "Passwords are not the same",preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
            } else {
                let userVM = UserVM(userName: username.text, firstName: firstName.text, lastName: lastName.text, email: email.text, password: password.text, phoneNumber: phoneNo.text!, age: 0, address: "Amman, Jordan", isActive: true)
                NetworkLayer.register(userVM: userVM, controller: self)
            }
        }
    }
    
    func goToLoginPage() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: UITextFieldDelegate{
    @objc func keyboardWillShow(_ notification:Notification) {
        if email.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        } else if phoneNo.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        } else if password.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        } else if rePassword.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if !email.isEditing {
            view.frame.origin.y = 0
        } else if !phoneNo.isEditing {
            view.frame.origin.y = 0
        } else if !password.isEditing {
            view.frame.origin.y = 0
        } else if !rePassword.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() { NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
