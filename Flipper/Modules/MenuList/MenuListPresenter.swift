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
    
    init(interactor: MenuListInteractorRepresentable) {
        self.interactor = interactor
    }
}


// MARK: MenuListPresenterRepresentable Implementation

extension MenuListPresenter: MenuListPresenterRepresentable {
    
    func attachView(view: MenuListViewRepresentable) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchMenu(completion: { [weak self] result in
            switch result {
            case .failure(let err):
                break
            case .success(let menu):
                break
            }
        })
    }
    
    func viewWillAppear(animated: Bool) { }
    
    func viewDidAppear(animated: Bool) {
        
    }
    
    func viewWillDisappear(animated: Bool) { }
    
    func viewDidDisappear(animated: Bool) { }
}
