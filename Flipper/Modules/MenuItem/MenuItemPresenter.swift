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
    private let viewModel: MenuItemViewModel
    
    init(withViewModel viewModel: MenuItemViewModel) {
        self.viewModel = viewModel
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
        0
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        0
    }
    
    func item(atIndexPath indexPath: IndexPath) -> MenuItemViewModel? {
        nil
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) { }
    
    func sectionTitle(forSection section: Int) -> String? {
        return nil
    }
}

// MARK: Private Helpers

extension MenuItemPresenter {
    
    private func performInitialSetup() {
        view?.applyTitle(title: viewModel.titleLabelText)
        view?.setupSubviews()
    }
}
