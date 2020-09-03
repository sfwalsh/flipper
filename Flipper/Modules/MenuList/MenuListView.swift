//
//  MenuListView.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuListView: UIViewController {
    
    private let presenter: MenuListPresenterRepresentable
    
    init(presenter: MenuListPresenterRepresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.attachView(view: self)
        view.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: MenuListViewRepresentable Implementation

extension MenuListView: MenuListViewRepresentable {
    
}

// MARK: View methods

extension MenuListView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
