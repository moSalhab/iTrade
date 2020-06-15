//
//  Utility.swift
//  TradeApp
//
//  Created by Mohammad Salhab on 5/2/20.
//  Copyright © 2020 Mohammad Salhab. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImge(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
