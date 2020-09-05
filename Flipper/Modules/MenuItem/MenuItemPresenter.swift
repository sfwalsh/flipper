//
//  MenuItemPresenter.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

final class MenuItemPresenter {
    
    private unowned var view: MenuItemViewRepresentable?
    private let viewModel: MenuItemViewModelAdapter
    
    init(withViewModel viewModel: MenuItemViewModel) {
        self.viewModel = MenuItemViewModelAdapter(viewModel: viewModel)
    }
}


// MARK: MenuItemPresenterRepresentable Implementation

extension MenuItemPresenter: MenuItemPresenterRepresentable {
    
    func attachView(view: MenuItemViewRepresentable & Navigatable) {
        self.view = view
    }
    
    func viewDidLoad() {
        performInitialSetup()
    }
    
    func viewWillAppear(animated: Bool) { }
    
    func viewDidAppear(animated: Bool) { }
    
    func viewWillDisappear(animated: Bool) { }
    
    func viewDidDisappear(animated: Bool) { }
}

// MARK: Datasource Operators

extension MenuItemPresenter {
    
    func numberOfSections() -> Int {
        return viewModel.numberOfSections
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func item(atIndexPath indexPath: IndexPath) -> MenuItemViewModelAdapterBlock? {
        return viewModel.blockItem(atIndexPath: indexPath)
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) { }
    
    func didDeselectItem(atIndexPath indexPath: IndexPath) { }
    
    func sectionType(forSection section: Int) -> CollectionSectionType {
        return viewModel.blockSectionType(forSection: section)
    }
}

// MARK: Private Helpers

extension MenuItemPresenter {
    
    private func performInitialSetup() {
        view?.applyTitle(title: viewModel.titleLabelText)
        view?.setupSubviews()
    }
}
