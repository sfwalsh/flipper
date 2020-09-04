//
//  PriceFormatter.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct PriceFormatter {
    
    static func format(value: Double?, isMinPrice: Bool = false) -> String {
        guard let value = value else {
            return NSLocalizedString("NO_PRICE", comment: "")
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = NSLocale.current
        
        numberFormatter.currencyCode = NSLocale.current.currencyCode
        

        let priceString = numberFormatter.string(from: NSNumber(value: value))
        
        if let priceString = priceString, isMinPrice {
            return NSLocalizedString("FROM_PRICE_PREFIX", comment: "") + priceString
        }
        
        return priceString ?? NSLocalizedString("NO_PRICE", comment: "")
    }
}
