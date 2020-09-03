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
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol MenuListPresenterRepresentable: PresenterRepresentable {
    func attachView(view: MenuListViewRepresentable & Navigatable)
}

protocol MenuListInteractorRepresentable {
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void))
}
