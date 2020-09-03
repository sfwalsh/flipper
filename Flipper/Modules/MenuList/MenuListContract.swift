//
//  MenuListContract.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

protocol MenuListViewRepresentable: class {
    func applyTitle(title: String)
    func setupSubviews()
    func reload()
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol MenuListPresenterRepresentable: PresenterRepresentable {
    func attachView(view: MenuListViewRepresentable & Navigatable)
    
    
    // MARK: Datasource Operators
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    
    func item(atIndexPath indexPath: IndexPath) -> Menu?
    func didSelectItem(atIndexPath indexPath: IndexPath)
    func sectionTitle(forSection section: Int) -> String?
}
extension MenuListPresenterRepresentable {
    

}

protocol MenuListInteractorRepresentable {
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void))
}
