//
//  MenuItemViewHeaderCell.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation
import SDWebImage

/*
 Used by the Collectionview of the MenuView for rendering a single MenuItem
 */

final class MenuItemViewHeaderCell: UICollectionViewCell, ReusableCell {
    
    static let preferredHeight: CGFloat = 400.0
    
    private enum Layout {
        static let contentInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let imageHeightMutliplier: CGFloat = 0.75
    }
    
    private enum Style {
        static let placeholderImage: UIImage = #imageLiteral(resourceName: "empty-state-icon")
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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

extension MenuItemViewHeaderCell {
    
    private func setupUI() {
        backgroundColor = .clear
        addSubviews()
        applyConstraints()
    }
    
    private func addSubviews() {
        addSubviewsForAutolayout(views: [
            imageView,
            titleLabel,
            descriptionLabel,
        ])
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: MenuItemViewHeaderCell.preferredHeight * Layout.imageHeightMutliplier),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                            constant: Layout.contentInsets.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Layout.contentInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Layout.contentInsets.right),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                            constant: Layout.contentInsets.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Layout.contentInsets.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Layout.contentInsets.right),

        ])
    }
}


// MARK: Actions

extension MenuItemViewHeaderCell {
    
    func setup(title: String, description: String?, imageURLString: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        applyImage(forURLString: imageURLString)
    }
}


// MARK: Private helper functions

extension MenuItemViewHeaderCell {

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
