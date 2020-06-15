//
//  ItemVM.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/1/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation

struct ItemVM : Codable {
    var categoryId : String!
    var userId: String!
    var name: String!
    var details : String!
    var price : Double!
    var isNew: Bool!
    var quantity : Int!
    //var tags: String!
}


