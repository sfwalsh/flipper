//
//  MenuContract.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

/*
 Contract giving a birds eye view of the functions and responsibilities of each object in the module
 */

protocol MenuViewRepresentable: class {
    func applyTitle(title: String)
    func setupSubviews()
    func reload()
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol MenuPresenterRepresentable: PresenterRepresentable {
    func attachView(view: MenuViewRepresentable & Navigatable)
    
    
    // MARK: Datasource Operators
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    
    func item(atIndexPath indexPath: IndexPath) -> MenuItemViewModel?
    func didSelectItem(atIndexPath indexPath: IndexPath)
    func sectionTitle(forSection section: Int) -> String?
}

protocol MenuInteractorRepresentable {
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void))
}

protocol MenuRouterRepresentable: Router {
    func routeToDetail(withViewModel viewModel: MenuItemViewModel)
    
    func presentAlert(withTitle title: String,
                         message: String,
                         options: [(String, (() -> Void))])
}

enum MenuModule {
    
    static func createInstance() -> MenuView {
        let interactor = MenuInteractor()
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)
        return MenuView(presenter: presenter)
    }
}
