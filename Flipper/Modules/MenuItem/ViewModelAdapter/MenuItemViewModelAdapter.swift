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
    
    init(viewModel: MenuItemViewModel) {
        self.viewModel = viewModel
    }
    
    var titleLabelText: String {
        return viewModel.titleLabelText
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return 1
    }
    
    func blockItem(atIndexPath indexPath: IndexPath) -> MenuItemViewModelAdapterBlock? {
        return MenuItemViewModelAdapterBlock.header(title: viewModel.titleLabelText,
                                                    description: viewModel.descriptionLabelText,
                                                    imageURLString: viewModel.mainImageURLString)
    }
    
    func blockSectionType(forSection section: Int) -> CollectionSectionType {
        return .hidden
    }
}

enum MenuItemViewModelAdapterBlock {
    case header(title: String, description: String?, imageURLString: String?)
}
