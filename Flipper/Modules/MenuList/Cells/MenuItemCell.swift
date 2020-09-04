//
//  MenuItemCell.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit
import SDWebImage

final class MenuItemCell: UICollectionViewCell, ReusableCell {
    
    private enum Layout {
        static let insets = UIEdgeInsets(top: 7, left: 14, bottom: 0, right: 14)
        static let strokeWidth: CGFloat = 1.0
        static let cardCornerRadius: CGFloat = 4.0
        
        static let contentInsets = UIEdgeInsets(top: 13, left: 13, bottom: 14, right: 13)
        static let internalContentInsets = UIEdgeInsets(top: 10, left: 13, bottom: 14, right: 13)

        static let priceLabelHeight: CGFloat = 26.0
        static let minPriceLabelWidth: CGFloat = 70.0
    }
    
    private enum Style {
        static let placeholderImage: UIImage = #imageLiteral(resourceName: "empty-state-icon")
    }
    
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
        backgroundColor = .clear
        addSubviews()
        applyConstraints()
    }
    
    private func addSubviews() {
        addSubviewsForAutolayout(views: [
            imageView,
            titleLabel,
            descriptionLabel,
            priceLabel
        ])
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor,
                                           constant: offsetTopConstraintConstant(constant: Layout.contentInsets.top)),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: offsetLeftConstraintConstant(constant: Layout.contentInsets.left)),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offsetBottomConstraintConstant(constant: Layout.contentInsets.bottom)),
            
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                             constant: 1.0),
            
            
            priceLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: offsetTopConstraintConstant(constant: Layout.contentInsets.top)),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -offsetRightConstraintConstant(constant: Layout.contentInsets.right)),
            priceLabel.heightAnchor.constraint(equalToConstant: Layout.priceLabelHeight),
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Layout.minPriceLabelWidth),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: offsetTopConstraintConstant(constant: Layout.contentInsets.top)),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                                constant: Layout.contentInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor,
                                                 constant: -Layout.contentInsets.right),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: Layout.internalContentInsets.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                                      constant: Layout.contentInsets.left),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                                     constant: -offsetBottomConstraintConstant(constant: Layout.contentInsets.bottom)),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -offsetRightConstraintConstant(constant: Layout.contentInsets.right))
        ])
    }
}


// MARK: Actions

extension MenuItemCell {
    
    func setup(withViewModel viewModel: MenuItemViewModel) {
        priceLabel.update(withTitle: viewModel.priceLabelText)
        titleLabel.text = viewModel.titleLabelText
        descriptionLabel.text = viewModel.descriptionLabelText
        applyImage(forURLString: viewModel.mainImageURLString)
    }
}


// MARK: Drawing

extension MenuItemCell {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawCard(in: context, for: rect)
    }
    
    private func drawCard(in context: CGContext,
                          for rect: CGRect) {
        let cardRect = CGRect(origin: CGPoint(x: rect.minX+Layout.insets.left,
                                              y: rect.minY+Layout.insets.top),
                              size: CGSize(width: rect.width-(Layout.insets.left+Layout.insets.right),
                                           height: rect.height-(Layout.insets.top+Layout.insets.bottom+Layout.strokeWidth)))
        let path = UIBezierPath(roundedRect: cardRect, cornerRadius: Layout.cardCornerRadius)
        
        context.addPath(path.cgPath)
        context.setFillColor(ColourPalette.offWhite.cgColor)
        context.fillPath()
        
        context.addPath(path.cgPath)
        context.setLineWidth(Layout.strokeWidth)
        context.setStrokeColor(ColourPalette.alphaBlack10.cgColor)
        context.strokePath()
    }
}


// MARK: Private helper functions

extension MenuItemCell {
    
    /*
     To offset the inset of the card drawing
     */
    
    private func offsetTopConstraintConstant(constant: CGFloat) -> CGFloat {
        return constant + Layout.insets.top
    }
    
    private func offsetLeftConstraintConstant(constant: CGFloat) -> CGFloat {
        return constant + Layout.insets.left
    }
    
    private func offsetBottomConstraintConstant(constant: CGFloat) -> CGFloat {
        return constant + Layout.insets.bottom
    }
    
    private func offsetRightConstraintConstant(constant: CGFloat) -> CGFloat {
        return constant + Layout.insets.right
    }
    
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
