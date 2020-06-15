//
//  Alert.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/12/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation
import UIKit

class AlertClass {
    static func showAlert(controller  : UIViewController ,     message : String , seconds : Double) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 10
        
        controller.present(alert ,animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            
            alert.dismiss(animated: true)
            
        }
    }
}
