//
//  MenuViewModel.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

/*
 A formatted and abstracted rendering of the API Menu object, used by the presenter to manage the view
 */

import Foundation

struct MenuViewModel {
    
    private let menu: Menu
    private let sections: [MenuSectionViewModel]
    
    init(withMenu menu: Menu) {
        self.menu = menu
        self.sections = menu.sections
            .map({ MenuSectionViewModel(section: $0) })
            .filter({ $0.items.count > 0 })
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func menuItem(atIndexPath indexPath: IndexPath) -> MenuItemViewModel? {
        guard let menuSection = sections[safe: indexPath.section],
            let menuItem = menuSection.items[safe: indexPath.item] else { return nil }
        return menuItem
    }
    
    func menuSectionTitle(forIndex index: Int) -> String? {
        return sections[safe: index]?.name
    }
}
