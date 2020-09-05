//
//  MenuItemView.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuItemView: UIViewController, Navigatable {
    
    private let presenter: MenuItemPresenterRepresentable
    
    init(withPresenter presenter: MenuItemPresenterRepresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.attachView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}


// MARK: MenuItemViewRepresentable Implementation

extension MenuItemView: MenuItemViewRepresentable {
    
    func applyTitle(title: String) {
        self.title = title
    }
    
    func setupSubviews() {
        view.backgroundColor = .black
    }
    
    func reload() {
    
    }
    
}
