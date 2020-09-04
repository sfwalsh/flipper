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
    
    var titleLabelText: String {
        return menuSectionItem.name
    }
    
    var descriptionLabelText: String? {
        return menuSectionItem.description
    }
    
    var priceLabelText: String {
        return PriceFormatter.format(value: menuSectionItem.price, isMinPrice: false)
    }
    
    init(withMenuItem menuItem: MenuSectionItem) {
        self.menuSectionItem = menuItem
    }
}
