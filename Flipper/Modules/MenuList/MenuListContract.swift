//
//  MenuListContract.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

protocol MenuListViewRepresentable: class {
    
}

protocol MenuListPresenterRepresentable: PresenterRepresentable {
    func attachView(view: MenuListViewRepresentable)
}

protocol MenuListInteractorRepresentable {
    func fetchMenu(completion: @escaping ((NetworkResult<Menu, MenuFetchError>) -> Void))
}
