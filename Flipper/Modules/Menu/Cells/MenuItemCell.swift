//
//  MenuItemCell.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit
import SDWebImage

/*
 Used by the Collectionview of the MenuView for rendering a single MenuItem
 */

final class MenuItemCell: UICollectionViewCell, ReusableCell {
    
    static let preferredHeight: CGFloat = 120.0
    
    private enum Layout {
        
        static let contentInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        static let internalContentInsets = UIEdgeInsets(top: 10, left: 13, bottom: 13, right: 13)

        static let priceLabelHeight: CGFloat = 26.0
        static let minPriceLabelWidth: CGFloat = 70.0
    }
    
    private enum Style {
        static let placeholderImage: UIImage = #imageLiteral(resourceName: "empty-state-icon")
    }
    
    private let cardView = CardView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.backgroundColor = ColourPalette.alphaBlack10
        imageView.image = Style.placeholderImage
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontMachine.title
        label.textColor = ColourPalette.Text.primaryBlack
        label.numberOfLines = 2
 
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontMachine.paragraph
        label.textColor = ColourPalette.Text.secondaryBlack
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = Style.placeholderImage
    }
}


// MARK: Setup

extension MenuItemCell {
    
    private func setupUI() {
        backgroundColor = ColourPalette.lovelyLilac
        addSubviews()
        applyConstraints()
    }
    
    private func addSubviews() {
        addSubviewsForAutolayout(views: [
            cardView,
            imageView,
            titleLabel,
            descriptionLabel,
            priceLabel
        ])
    }
    
    private func applyConstraints() {
        priceLabel.setContentHuggingPriority(.required,
                                             for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor,
                                           constant: Layout.contentInsets.top),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,
                                               constant: Layout.contentInsets.left),
            imageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Layout.contentInsets.bottom),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                             constant: 1.0),
            
            
            priceLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Layout.contentInsets.top),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Layout.contentInsets.right),
            priceLabel.heightAnchor.constraint(equalToConstant: Layout.priceLabelHeight),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Layout.contentInsets.top),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                                constant: Layout.contentInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor,
                                                 constant: -Layout.contentInsets.right),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: Layout.internalContentInsets.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                                      constant: Layout.contentInsets.left),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                                     constant: -Layout.contentInsets.bottom),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Layout.contentInsets.right)
        ])
    }
}


// MARK: Actions

extension MenuItemCell {
    
    func setup(withViewModel viewModel: MenuItemViewModel) {
        priceLabel.update(withTitle: viewModel.priceLabelText)
        titleLabel.text = "Beautiful long text reiongeai nireog nogan eiorgn eos"
        descriptionLabel.text = viewModel.descriptionLabelText
        applyImage(forURLString: viewModel.mainImageURLString)
    }
}


// MARK: Private helper functions

extension MenuItemCell {
    
    private func applyImage(forURLString urlString: String?) {
        if let imageURLString = urlString,
            let imageURL = URL(string: imageURLString) {
            imageView.sd_setImage(with: imageURL,
                                  placeholderImage: Style.placeholderImage,
                                  options: [.scaleDownLargeImages])
            
            imageView.sd_imageTransition = SDWebImageTransition.fade(duration: 4)
        }
    }
}
