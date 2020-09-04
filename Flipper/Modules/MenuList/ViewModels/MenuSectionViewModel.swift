//
//  MenuSectionViewModel.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSectionViewModel {
    
    private let section: MenuSection
    let items: [MenuItemViewModel]
    
    var name: String? {
        return section.name
    }
    
    init(section: MenuSection) {
        self.section = section
        self.items = section.menuItems.map({ MenuItemViewModel(withMenuItem: $0) })
    }
}
