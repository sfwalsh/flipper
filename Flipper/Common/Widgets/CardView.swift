//
//  CardView.swift
//  Flipper
//
//  Created by Stephen Walsh on 05/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class CardView: UIView {
    
    private enum Layout {
        static let strokeWidth: CGFloat = 1.0
        static let cardCornerRadius: CGFloat = 4.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Drawing

extension CardView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawCard(in: context, for: rect)
    }
    
    private func drawCard(in context: CGContext,
                          for rect: CGRect) {
        let cardRect = rect
        let path = UIBezierPath(roundedRect: cardRect,
                                cornerRadius: Layout.cardCornerRadius)
        
        context.addPath(path.cgPath)
        context.setFillColor(ColourPalette.offWhite.cgColor)
        context.fillPath()
        
        context.addPath(path.cgPath)
        context.setLineWidth(Layout.strokeWidth)
        context.setStrokeColor(ColourPalette.alphaBlack10.cgColor)
        context.strokePath()
    }
}
