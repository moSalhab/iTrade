//
//  UserFS.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/6/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation
struct UserFS : Codable {
    var id: String!
    var userName: String!
    var password: String!
    var firstName: String!
    var lastName: String!
    var address:  String!
    var phoneNumber:String!
    var email: String!
    var age: Int!
    var isActive: Bool!
}
