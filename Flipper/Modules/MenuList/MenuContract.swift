//
//  MenuContract.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

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
    
    func item(atIndexPath indexPath: IndexPath) -> Menu?
    func didSelectItem(atIndexPath indexPath: IndexPath)
    func sectionTitle(forSection section: Int) -> String?
}
extension MenuPresenterRepresentable {
    

}

protocol MenuInteractorRepresentable {
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void))
}
