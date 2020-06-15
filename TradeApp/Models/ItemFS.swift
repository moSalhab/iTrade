//
//  ItemFS.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/21/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation


struct ItemFS: Codable{
    var categoryId: String!
    var userId: String
    var name: String
    var images: [String]!
    var details: String
    var isAvailableForTrading: Bool!
    var itemOwnerName: String!
    var price: Double!
    var isNew: Bool!
    var quantity:Int!
    var tags: String!
    var tradings: [String]?
    var id: String!
}
