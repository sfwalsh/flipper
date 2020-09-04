//
//  MenuItemViewModel.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuItemViewModel {
    
    private let menuSectionItem: MenuSectionItem
    
    var mainImageURLString: String? {
        return menuSectionItem.imageUrl
    }
    
    var titleLabelText: String {
        return menuSectionItem.name
    }
    
    var descriptionLabelText: String? {
        return menuSectionItem.description
    }
    
    var priceLabelText: String {
        return calculatePrice()
    }
    
    init(withMenuItem menuItem: MenuSectionItem) {
        self.menuSectionItem = menuItem
    }
}


// MARK: Private helper functions

extension MenuItemViewModel {
    
    private func calculatePrice() -> String {
        let masterOptionSetItems = menuSectionItem.optionSets
            .filter({$0.isMasterOptionSet})
            .flatMap({ $0.items })
        if masterOptionSetItems.count > 0 {
            let cheapestOption = masterOptionSetItems.compactMap({ $0.price }).min(by: { $0 < $1 })
            return PriceFormatter.format(value: cheapestOption, isMinPrice: true)
        } else {
            return PriceFormatter.format(value: menuSectionItem.price, isMinPrice: false)
        }
    }
}
