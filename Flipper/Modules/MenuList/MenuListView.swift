//
//  MenuListView.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuListView: UIViewController, Navigatable {
    
    private let presenter: MenuListPresenterRepresentable
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    init(presenter: MenuListPresenterRepresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.attachView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: MenuListViewRepresentable Implementation

extension MenuListView: MenuListViewRepresentable {
    
    func applyTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func setupSubviews() {
         view.backgroundColor = .white
         view.addSubviewsForAutolayout(views: [
             activityIndicator
         ])
         
         applyConstraints()
     }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: View methods

extension MenuListView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
}
