//
//  MenuListPresenter.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

final class MenuListPresenter {
    
    private unowned var view: MenuListViewRepresentable?
    private let interactor: MenuListInteractorRepresentable
    private let router: MenuListRouter
    private var menu: Menu?
    
    init(interactor: MenuListInteractorRepresentable, router: MenuListRouter) {
        self.interactor = interactor
        self.router = router
    }
}


// MARK: MenuListPresenterRepresentable Implementation

extension MenuListPresenter: MenuListPresenterRepresentable {
    
    func attachView(view: MenuListViewRepresentable & Navigatable) {
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

extension MenuListPresenter {
    
    func numberOfSections() -> Int {
        return 0
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return 0
    }
    
    func item(atIndexPath indexPath: IndexPath) -> Menu? {
        return menu
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        
    }
    
    func sectionTitle(forSection section: Int) -> String? {
        return ""
    }
}

// MARK: Private helpers

extension MenuListPresenter {
    
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
                    self?.menu = menu
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
