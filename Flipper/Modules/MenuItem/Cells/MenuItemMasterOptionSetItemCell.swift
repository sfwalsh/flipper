//
//  MenuItemMasterOptionSetItemCell.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuItemMasterOptionSetItemCell: UICollectionViewCell, ReusableCell {
    
    static let preferredHeight: CGFloat = 80.0
    
    private enum Layout {
        static let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                       left: 12,
                                                       bottom: 0,
                                                       right: 12)
        static let internalContentInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                                      left: 20,
                                                                      bottom: 0,
                                                                      right: 20)
        static let imageHeightMutliplier: CGFloat = 0.75
        static let priceLabelHeight: CGFloat = 26.0
    }
    
    private enum Style {
        static let placeholderImage: UIImage = #imageLiteral(resourceName: "empty-state-icon")
    }
    
    private let cardView = CardView(highlightColour: ColourPalette.gregariousGreen)
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontMachine.title
        label.textColor = ColourPalette.Text.primaryBlack
        label.numberOfLines = 2
        
        return label
    }()
    
    private let priceLabel: AttributeLabel = {
        let label = AttributeLabel(frame: .zero)
        label.setupTextColor(color: ColourPalette.gregariousGreen)
        label.font = FontMachine.attribute
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Setup

extension MenuItemMasterOptionSetItemCell {
    
    private func setupUI() {
        addSubviews()
        applyConstraints()
    }
    
    private func addSubviews() {
        backgroundColor = .clear
        addSubviewsForAutolayout(views: [
            cardView,
            titleLabel,
            priceLabel
        ])
    }
    
    private func applyConstraints() {
        
        priceLabel.setContentHuggingPriority(.required,
                                             for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.contentInsets.left),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.contentInsets.right),
            
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Layout.internalContentInsets.left),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Layout.internalContentInsets.right),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: Layout.priceLabelHeight)
        ])
    }
}


// MARK: Actions

extension MenuItemMasterOptionSetItemCell {
    
    func setup(titleText: String, priceText: String?) {
        titleLabel.text = titleText
        priceLabel.update(withTitle: priceText)
        
    }
    
    override var isSelected: Bool {
        didSet {
            cardView.isSelected = isSelected
        }
    }
}
