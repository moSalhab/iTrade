//
//  TradeFS.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/5/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation

struct TradeFS: Codable {
    var party1: String!//sender
    var party2: String!//receiver
    var requestedItems: [String]!
    var offeredItems: [String]!
    var isPending: Bool
    var party1Accepted: Bool// True by default unless offer will be canceld
    var party2Accepted: Bool
    var status: String!
    var contactInformation: ContactInformation!
    var id: String
}
