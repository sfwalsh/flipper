//
//  MenuView.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

/*
 Responsible for laying out and updating the view, and notifying the presenter of ongoing user interaction
 */

final class MenuView: UIViewController, Navigatable {
    
    private enum Layout {
        static let headerHeight: CGFloat = 85.0
        static let footerHeight: CGFloat = 45.0
        static let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                              left: 8,
                                                              bottom: 0,
                                                              right: 8)
    }
    
    private let presenter: MenuPresenterRepresentable
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MenuItemCell.self,
                                forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
        collectionView.register(SectionHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        collectionView.register(SectionFooterCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: SectionFooterCell.reuseIdentifier)
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
        view.backgroundColor = ColourPalette.lovelyLilac
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
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = presenter.item(atIndexPath: indexPath),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as? MenuItemCell else {
                fatalError("Uh oh! Something has gone terribly, terribly wrong.")
        }
        
        cell.setup(withViewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return headerView(for: collectionView, at: indexPath)
        } else {
            return footerView(for: collectionView, at: indexPath)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    private func headerView(for collectionView: UICollectionView,
                            at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionTitle = presenter.sectionTitle(forSection: indexPath.section),
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: SectionHeaderCell.reuseIdentifier,
                                                                             for: indexPath) as? SectionHeaderCell else { return UICollectionReusableView() }
        
        headerView.setup(withTitle: sectionTitle)
        return headerView
    }
    
    private func footerView(for collectionView: UICollectionView,
                            at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                               withReuseIdentifier: SectionFooterCell.reuseIdentifier,
                                                                               for: indexPath) as? SectionFooterCell else { return UICollectionReusableView() }
        
        return footerView
    }
}


// MARK: UICollectionViewDelegate Implementation

extension MenuView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(atIndexPath: indexPath)
    }
}


// MARK: UICollectionViewDelegateFlowLayout Implementation

extension MenuView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let _ = presenter.item(atIndexPath: indexPath) else { return .zero }
        return CGSize(width: collectionView.frame.width-(Layout.sectionInsets.left*2),
                      height: MenuItemCell.preferredHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: Layout.headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: Layout.footerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Layout.sectionInsets
    }
}
