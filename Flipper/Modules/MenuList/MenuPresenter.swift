//
//  MenuPresenter.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

final class MenuPresenter {
    
    private unowned var view: MenuViewRepresentable?
    private let interactor: MenuInteractorRepresentable
    private let router: MenuRouterRepresentable
    private var menuViewModel: MenuViewModel?
    
    init(interactor: MenuInteractorRepresentable,
         router: MenuRouterRepresentable) {
        self.interactor = interactor
        self.router = router
    }
}


// MARK: MenuPresenterRepresentable Implementation

extension MenuPresenter: MenuPresenterRepresentable {
    
    func attachView(view: MenuViewRepresentable & Navigatable) {
        self.view = view
        self.router.attachView(view: view)
    }
    
    func viewDidLoad() {
        performInitialSetup()
        fetchMenu()
    }
    
    func viewWillAppear(animated: Bool) { }
    
    func viewDidAppear(animated: Bool) { }
    
    func viewWillDisappear(animated: Bool) { }
    
    func viewDidDisappear(animated: Bool) { }
}


// MARK: Datasource Operator Implementation

extension MenuPresenter {
    
    func numberOfSections() -> Int {
        return menuViewModel?.numberOfSections ?? 0
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return menuViewModel?.numberOfItems(inSection: section) ?? 0
    }
    
    func item(atIndexPath indexPath: IndexPath) -> MenuItemViewModel? {
        return menuViewModel?.menuItem(atIndexPath: indexPath)
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) { }
    
    func sectionTitle(forSection section: Int) -> String? {
        return menuViewModel?.menuSectionTitle(forIndex: section)
    }
}

// MARK: Private helpers

extension MenuPresenter {
    
    private func performInitialSetup() {
        view?.applyTitle(title: NSLocalizedString("FLIPPER_TITLE", comment: ""))
        view?.setupSubviews()
    }
    
    private func fetchMenu() {
        view?.showActivityIndicator()
        interactor.fetchMenu(completion: { result in
            DispatchQueue.main.async { [weak self] in
                self?.view?.hideActivityIndicator()
                switch result {
                case .failure(let err):
                    self?.handleError(error: err)
                case .success(let menu):
                    self?.menuViewModel = MenuViewModel(withMenu: menu)
                    self?.view?.reload()
                }
            }
        })
    }

    private func handleError(error: Error) {
        router.presentAlert(withTitle: NSLocalizedString("Error", comment: ""),
                            message: error.localizedDescription,
                            options: [(NSLocalizedString("OK", comment: ""), {})])
    }
}
