//
//  MenuView.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuView: UIViewController, Navigatable {
    
    private let presenter: MenuPresenterRepresentable
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        // TODO: Register Cells!
        
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    init(presenter: MenuPresenterRepresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.attachView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: MenuViewRepresentable Implementation

extension MenuView: MenuViewRepresentable {
    
    func reload() {
        collectionView.reloadData()
    }
    
    func applyTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func setupSubviews() {
        view.backgroundColor = .white
        setupCollectionView()
        view.addSubviewsForAutolayout(views: [
            collectionView,
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

extension MenuView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
    }
}


// MARK: UICollectionViewDataSource Implementation

extension MenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
}

// MARK: UICollectionViewDelegate Implementation

extension MenuView: UICollectionViewDelegate {

}
