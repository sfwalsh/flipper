//
//  MenuItemViewModelAdapter.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuItemViewModelAdapter {
    
    private let viewModel: MenuItemViewModel
    private let blocks: [(CollectionSectionType, [MenuItemViewModelAdapterBlock])]
    
    init(viewModel: MenuItemViewModel) {
        self.viewModel = viewModel
        self.blocks = MenuItemViewModelAdapter.build(for: viewModel)
    }
    
    var titleLabelText: String {
        return viewModel.titleLabelText
    }
    
    var numberOfSections: Int {
        return blocks.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return blocks[safe: section]?.1.count ?? 0
    }
    
    func blockItem(atIndexPath indexPath: IndexPath) -> MenuItemViewModelAdapterBlock? {
        return blocks[safe: indexPath.section]?.1[safe: indexPath.item]
    }
    
    func blockSectionType(forSection section: Int) -> CollectionSectionType {
        return blocks[safe: section]?.0 ?? .hidden
    }
}

extension MenuItemViewModelAdapter {
    
    private static func build(for viewModel: MenuItemViewModel) -> [(CollectionSectionType, [MenuItemViewModelAdapterBlock])] {
        let headerItem = MenuItemViewModelAdapterBlock.header(title: viewModel.titleLabelText,
                                                              description: viewModel.descriptionLabelText,
                                                              imageURLString: viewModel.mainImageURLString)
        return [
            (.hidden, [headerItem])
        ]
    }
}

enum MenuItemViewModelAdapterBlock {
    case header(title: String, description: String?, imageURLString: String?)
}
