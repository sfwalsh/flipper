//
//  MenuItemCell.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class MenuItemCell: UICollectionViewCell, ReusableCell {
    
    private enum Layout {
        static let insets = UIEdgeInsets(top: 7, left: 14, bottom: 0, right: 14)
        static let strokeWidth: CGFloat = 1.0
        static let cardCornerRadius: CGFloat = 4.0
    }
}


// MARK: Setup

extension MenuItemCell {
    
}


// MARK: Actions

extension MenuItemCell {
    
    func setup(withViewModel viewModel: MenuItemViewModel) {
        backgroundColor = ColourPalette.offWhite
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
                                           height: rect.height-(Layout.insets.top+Layout.insets.bottom)))
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
