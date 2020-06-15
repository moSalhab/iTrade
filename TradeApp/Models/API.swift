//
//  API.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 4/15/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation

class API {
    static var user = UserFS()
    static var allItems = [ItemFS]()
    static var myItems = [ItemFS]()
    static var categories = [CategoryFS]()
    static var sentOffersDetails = [GetSentTradeDetails]()
    static var receivedOffersDetails = [GetRecievedTradeDetails]()
    static var dataController: DataController!
}
