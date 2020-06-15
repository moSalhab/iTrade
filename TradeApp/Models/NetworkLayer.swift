//
//  NetworkLayer.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 6/8/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer {
    
    static let base = ""
    
    static func login(username: String, password: String, controller: SignInViewController) {
        let request = AF.request(self.base + "/api/users/getuser?username=" + username + "&password=" + password)
        
        request.responseDecodable(of: UserFS.self){
            (response) in
            guard let user = response.value else {
                AlertClass.showAlert(controller: controller, message: "Incorrect username or password.", seconds: 2.0)
                return
            }
            
            debugPrint(response)
            if user.id == nil { //if incorrect ceredential intered
                let alert = UIAlertController(title: "Error", message: "Wrong email or password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
                controller.present(alert,animated:true,completion:nil)
            } else {
                let userData = UserData(context: API.dataController.viewContext)
                userData.id = user.id
                userData.address = user.address
                userData.email = user.email
                userData.firstName = user.firstName
                userData.lastName = user.lastName
                userData.phoneNumber = user.lastName
                try? API.dataController.viewContext.save()
                controller.goToMainPage()
            }
        }
    }
    
    static func register(userVM: UserVM, controller: SignUpViewController) {
        
        let request = AF.request(self.base + "/api/users/adduser",
                                 method: .post,
                                 parameters: userVM,
                                 encoder: JSONParameterEncoder.default).response { response in debugPrint(response)
        }
        
        request.responseDecodable(of: UserFS.self){
            (response) in
            guard response.value != nil else {
                AlertClass.showAlert(controller: controller, message: "Error from server", seconds: 2)
                print("error")
                return
            }
            
            controller.goToLoginPage()
        }
    }
    
    static func forgotPassword(username: String, controller: ForgotPasswordViewController) {
           let request = AF.request(self.base + "/api/users/forgetpassword?username=" + username)
        
           request.responseDecodable(of: String.self) {
               (response) in
               guard response.value == nil
                   else {
                    debugPrint(response)
                    AlertClass.showAlert(controller: controller, message: "Old password has been sent to the email address.", seconds: 2.0)
                    return
               }
           }
    }
    
    static func getUserItems(controller: MyItemsViewController) {
        let request = AF.request(self.base + "/api/items/GetUserItems?userid=" + API.user.id!)
        request.responseDecodable( of: [ItemFS].self){
            (response) in
            guard let items = response.value else {
                debugPrint(response)
                let alert = UIAlertController(title: "Internet connection fails", message: "Please check the connection of the Internet network to load your items", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
                controller.present(alert,animated:true,completion:nil)
                return
            }
            API.myItems = items
            controller.myItemsTableView.reloadData()
        }
    }
    
    static func getUserItems(controller: AllItemsViewController) {
        let request = AF.request(self.base + "/api/items/getallitems")
        request.responseDecodable(of: [ItemFS].self){
            (response) in
            guard let items = response.value else {
                debugPrint(response)
                let alert = UIAlertController(title: "Internet connection fails", message: "Please check the connection of the Internet network to load all items uploaded by all users.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
                controller.present(alert,animated:true,completion:nil)
                return
            }
            API.allItems = items
            controller.allItemsCollectionView.reloadData()
            debugPrint(response)
        }
    }
    
    static func proposeTrade(tradeVM: TradeVM) {
        let request = AF.request(self.base + "/api/trades/requesttrade", method: .post , parameters: tradeVM , encoder: JSONParameterEncoder.default)

        request.responseDecodable(of: TradeFS.self)
        {
            (response) in
            guard let itemFT = response.value
                else{debugPrint("Error : \(response)")
                    return}
            print("Request Send successfully : \(itemFT)")
        }
    }

    static func getSentOffersInfo(userID: String, controller: SentOffersViewController) {
        let request = AF.request(self.base + "/api/trades/GetSentTradeDetails?userId=" + userID)
        request.responseDecodable(of: [GetSentTradeDetails].self) {
            (response) in
            guard let sentOffers = response.value else {
                debugPrint(response)
                let alert = UIAlertController(title: "Internet connection fails", message: "Please check the connection of the Internet network to load send offers.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
                controller.present(alert,animated:true,completion:nil)
                return
            }
            API.sentOffersDetails = sentOffers
            controller.sentOffers.reloadData()
        }
    }
    
    static func getreceivedOffersInfo(userID: String, controller: RecievedOffersViewController) {
        let request = AF.request(self.base + "/api/trades/GetRecievedTradeDetails?userId=" + userID)
        request.responseDecodable(of: [GetRecievedTradeDetails].self){
            (response) in
            guard let receivedOffers = response.value else {
                debugPrint(response)
                let alert = UIAlertController(title: "Internet connection fails", message: "Please check the connection of the Internet network to load received offers.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { Void in }))
                controller.present(alert,animated:true,completion:nil)
                return
            }
            API.receivedOffersDetails = receivedOffers
            controller.receivedOffers.reloadData()
        }
    }
    
    static func rejectOffer(offerID: String, userID: String, controller: RecievedOffersDetailsViewController) {
        let request = AF.request(self.base + "/api/trades/RefuseTrade?tradeid=" + offerID + "&userid=" + API.user.id!)
        request.responseDecodable(of: Bool.self) {
            (response) in
            guard response.value != nil
                else {
                debugPrint(response)
                return
            }
            controller.navigationController?.popToRootViewController(animated: true)
            debugPrint(response)
        }
    }
    
    static func acceptOffer(tradeID: String, latitude: String, longitude: String) {
        let request = AF.request(self.base + "/api/trades/AcceptTradeWithLocation?tradeid=" + tradeID + "&userid=" + API.user.id! + "&lat=" + latitude + "&lon=" + longitude)
        
        request.responseDecodable(of: TradeFS.self) {
            (response) in
            guard response.value != nil else {
                debugPrint(response)
                return
            }
            debugPrint(response)
        }
    }
    
    static func loadCategories(controller: AddItemViewController){
        let request = AF.request(self.base + "/api/items/getallcategories")
        request.responseDecodable(of: [CategoryFS].self){
            (response) in
            guard let categories = response.value else { debugPrint(response)
                AlertClass.showAlert(controller: controller, message: "No internet connection, please check internet connection to be able to add an item.", seconds: 3.0)
                controller.addItem.isEnabled = false
                return }
            API.categories = categories
            controller.categories.reloadAllComponents()
            debugPrint(response)
        }
    }
    
    static func addItem(itemVM: ItemVM, controller: AddItemViewController){
        let request = AF.request(self.base + "/api/items/additem?userid=" + API.user.id!, method:.post, parameters: itemVM, encoder: JSONParameterEncoder.default)
        
        request.responseDecodable(of: ItemFS.self) {
            (response) in
            guard let item = response.value else {
                
                debugPrint(response)
                AlertClass.showAlert(controller: controller, message: "Please do not forget to upload photos to the item", seconds: 2.0)
                controller.addItem.isEnabled = false
                return }
            controller.item = item
            debugPrint("Added item successfully\(response)")
        }
    }
    
    static func addImageToItem(itemID: String, image: UIImage) {
        let headers : HTTPHeaders = [
         "Content-type" : "multipart/form-data" ,
         "Accept" : "application/json"
        ]
        if let data = image.jpegData(compressionQuality: 0.5){
        AF.upload(multipartFormData : {
        MultipartFormData in
        MultipartFormData.append(data , withName : "file", fileName: "file.jpeg", mimeType: "image/jpeg")
         }, to: self.base + "/api/images?itemId=" + itemID, method: .post , headers: headers).response {
        resp in
            debugPrint (resp)
            }
        }

    }
}
