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
    
    init(withMenuItem menuItem: MenuSectionItem) {
        self.menuSectionItem = menuItem
    }
}
