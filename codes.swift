//
//  codes.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 6/3/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//




//        if (try? API.dataController.viewContext.fetch(fetchRequst)) != nil {
//            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
//            let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
//            navigationController.viewControllers = [rootViewController]
//            self.window?.rootViewController = navigationController
//            return true
//        }

//print("Fetched Request:*******")
//print(fetchRequst.userDa)
//        if let result = try?
//            API.dataController.viewContext.fetch(fetchRequst) {
//            if let users = result {
//
//                print("***************************")
//                print(user.id)
//                API.user.id = user.id
//                API.user.address = user.address
//                API.user.email = user.email
//                API.user.firstName = user.firstName
//                API.user.lastName = user.lastName
//                API.user.phoneNumber = user.phoneNumber
//                print("***************************")
//                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                let tabBarViewController = storyBoard.instantiateViewController(identifier: "tabBarViewController")
//        UIApplication.shared.keyWindow?.rootViewController = tabBarViewController
//                return true
//            }
//        }

//        if (try? API.dataController.viewContext.fetch(fetchRequst)) != nil {
//            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
//            let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
//            navigationController.viewControllers = [rootViewController]
//            self.window?.rootViewController = navigationController
//            return true
//        }


//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as! UITabbarController
//        let nc = UINavigationController(rootViewController: vc)
//        self.present(nc, animated: false, completion: nil)
        
        
//        let story = UIStoryboard(name: "Main", bundle:nil)
//        let vc = story.instantiateViewController(withIdentifier: "MyItems") as! MyItemsViewController
//        UIApplication.shared.windows.first?.rootViewController = vc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let tabBarViewController = storyBoard.instantiateViewController(identifier: "tabBarViewController")
//        present(tabBarViewController, animated: true, completion: nil)
        
        
        //navigationController!.pushViewController(tabBarViewController, animated: true)
        
//        let rootViewController = self.window!.rootViewController as! UINavigationController
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarViewController") as! MyItemsViewController
        
        
//        rootViewController.pushViewController(profileViewController, animated: true)
//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let tabBarViewController = storyBoard.instantiateViewController(identifier: "tabBarViewController")
//        UIApplication.shared.keyWindow?.rootViewController = tabBarViewController


//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBarViewController") as? MyItemsViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
