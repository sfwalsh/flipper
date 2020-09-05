//
//  PriceFormatter.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct PriceFormatter {
    
    enum FormatOption {
        case minValue
        case additional
        case standard
    }
    
    private static func createNumberFormatter(forLocale locale: Locale) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        
        numberFormatter.currencyCode = locale.currencyCode
        
        return numberFormatter
    }
    
    static func format(value: Double?, formatOption :FormatOption = .standard) -> String {
        guard let value = value else {
            return NSLocalizedString("NO_PRICE", comment: "")
        }

        let numberFormatter = createNumberFormatter(forLocale: Locale.current)

        let priceString = numberFormatter.string(from: NSNumber(value: value))
        
        switch formatOption {
        case .minValue:
            if let priceString = priceString {
                return NSLocalizedString("FROM_PRICE_PREFIX", comment: "") + priceString
            }
        case .additional:
            if let priceString = priceString {
                return NSLocalizedString("ADDITIONAL_PRICE_PREFIX", comment: "") + priceString
            }
        case .standard:
            break
        }
        
        return priceString ?? NSLocalizedString("NO_PRICE", comment: "")
    }
}
