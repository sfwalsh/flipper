//
//  MenuItemContract.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

protocol MenuItemViewRepresentable: class {
    func applyTitle(title: String)
    func setupSubviews()
    func reload()
}

protocol MenuItemPresenterRepresentable: PresenterRepresentable {
    func attachView(view: MenuItemViewRepresentable & Navigatable)
    
    
    // MARK: Datasource Operators
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    
    func item(atIndexPath indexPath: IndexPath) -> MenuItemViewModelAdapterBlock?
    func didSelectItem(atIndexPath indexPath: IndexPath)
    func sectionType(forSection section: Int) -> CollectionSectionType
}

enum MenuItemModule {
    
    static func createInstance(withViewModel viewModel: MenuItemViewModel) -> MenuItemView {
        let presenter = MenuItemPresenter(withViewModel: viewModel)
        return MenuItemView(withPresenter: presenter)
    }
}
