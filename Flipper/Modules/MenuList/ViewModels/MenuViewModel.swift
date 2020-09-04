//
//  MenuViewModel.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuViewModel {
    
    private let menu: Menu
    
    init(withMenu menu: Menu) {
        self.menu = menu
    }
    
    var numberOfSections: Int {
        return menu.sections.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return menu.sections[safe: section]?.menuItems.count ?? 0
    }
    
    func menuItem(atIndexPath indexPath: IndexPath) -> MenuItemViewModel? {
        guard let menuSection = menu.sections[safe: indexPath.section],
            let menuItem = menuSection.menuItems[safe: indexPath.item] else { return nil }
        return MenuItemViewModel(withMenuItem: menuItem)
    }
    
    func menuSectionTitle(forIndex index: Int) -> String? {
        return menu.sections[safe: index]?.name
    }
}
