//
//  MenuItemView.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuItemView: UIViewController, Navigatable {
    
    private enum Layout {
        static let headerHeight: CGFloat = 85.0
        static let footerHeight: CGFloat = 45.0
    }
    
    private let presenter: MenuItemPresenterRepresentable
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        
        collectionView.register(MenuItemViewHeaderCell.self,
                                forCellWithReuseIdentifier: MenuItemViewHeaderCell.reuseIdentifier)
        collectionView.register(MenuItemMasterOptionSetItemCell.self,
                                forCellWithReuseIdentifier: MenuItemMasterOptionSetItemCell.reuseIdentifier)
        collectionView.register(SectionHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        collectionView.register(SectionFooterCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: SectionFooterCell.reuseIdentifier)
        return collectionView
    }()
    
    
    init(withPresenter presenter: MenuItemPresenterRepresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.attachView(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: MenuItemViewRepresentable Implementation

extension MenuItemView: MenuItemViewRepresentable {
    
    func applyTitle(title: String) {
        self.title = title
    }
    
    func setupSubviews() {
        view.backgroundColor = ColourPalette.lovelyLilac
        setupCollectionView()
        view.addSubviewsForAutolayout(views: [
            collectionView
        ])
        
        applyConstraints()
    }
    
    func reload() {
        collectionView.reloadData()
    }
}


// MARK: View methods

extension MenuItemView {
    
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
            
        ])
    }
}

// MARK: UICollectionViewDataSource Implementation

extension MenuItemView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = presenter.item(atIndexPath: indexPath),
            let cell = setupCell(forItem: item, atIndexPath: indexPath) else {
                fatalError("Oh dear.")
        }
            
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
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: SectionHeaderCell.reuseIdentifier,
                                                                             for: indexPath) as? SectionHeaderCell else { return UICollectionReusableView() }
        
        let sectionInfo = presenter.sectionType(forSection: indexPath.section)
        switch sectionInfo {
        case .text(let title):
            headerView.setup(withTitle: title)
        case .hidden: break
        }
        
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

extension MenuItemView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(atIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        presenter.didDeselectItem(atIndexPath: indexPath)
    }
}


// MARK: UICollectionViewDelegateFlowLayout Implementation

extension MenuItemView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = presenter.item(atIndexPath: indexPath) else { return .zero }
        
        let height = calculateHeight(forItem: item)
        return CGSize(width: collectionView.frame.width,
                      height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionInfo = presenter.sectionType(forSection: section)
        
        switch sectionInfo {
        case .text:
            return CGSize(width: collectionView.frame.width,
                          height: Layout.headerHeight)
        case .hidden:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionInfo = presenter.sectionType(forSection: section)
        
        switch sectionInfo {
        case .text:
            return CGSize(width: collectionView.frame.width,
                          height: Layout.footerHeight)
        case .hidden:
            return .zero
        }
    }
}


// MARK: Private helper functions

extension MenuItemView {
    
    private func calculateHeight(forItem item: MenuItemViewModelAdapterBlock) -> CGFloat {
        switch item {
        case .header:
            return MenuItemViewHeaderCell.preferredHeight
        case .masterOptionSetItem, .optionSetItem:
            return MenuItemMasterOptionSetItemCell.preferredHeight
        }
    }
    
    private func setupCell(forItem item: MenuItemViewModelAdapterBlock,
                           atIndexPath indexPath: IndexPath) -> UICollectionViewCell? {
        switch item {
        case .header(let title, let description, let imageURLString):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemViewHeaderCell.reuseIdentifier, for: indexPath) as? MenuItemViewHeaderCell else { return nil }
            
            cell.setup(title: title, description: description, imageURLString: imageURLString)
            return cell
        case .masterOptionSetItem(let title, let price), .optionSetItem(let title, let price):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemMasterOptionSetItemCell.reuseIdentifier, for: indexPath) as? MenuItemMasterOptionSetItemCell else { return nil }
            
            cell.setup(titleText: title, priceText: price)
            return cell
        }
    }
}
