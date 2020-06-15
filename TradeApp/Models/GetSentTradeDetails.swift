//
//  GetSentTradeDetails.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/5/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation
struct GetSentTradeDetails: Codable{
    var trade: TradeFS!
    var partyOneProfilePicture: String!//sender
    var partyTwoProfilePicture: String!//receiver
    var partyOneRating: Int!
    var partyTwoRating: Int!
    var partyOneUserName: String!
    var partyTwoUserName: String!
    var offeredItems: [ItemFS]!
    var requestedItems: [ItemFS]!
}
