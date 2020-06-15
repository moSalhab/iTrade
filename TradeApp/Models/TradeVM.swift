//
//  TradeVM.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/5/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation
struct TradeVM : Codable {
    var party1 : String!
    var party2 :String!
    var requestedItems : [String]!
    var offeredItems : [String]!
}
