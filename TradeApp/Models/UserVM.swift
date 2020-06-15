//
//  UserVM.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/1/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation

struct UserVM: Codable{
    var id: String!
    var userName: String!
    var firstName: String!
    var lastName: String!
    var email:String!
    var password:String!
    var phoneNumber:String!
    var age:Int
    var address:String!
    var isActive: Bool
}
