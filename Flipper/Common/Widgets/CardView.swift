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
        static let selectedStrokeWidth: CGFloat = 3.0
        static let strokeWidth: CGFloat = 1.0
        static let cardCornerRadius: CGFloat = 4.0
    }
    
    private let highlightColour: UIColor
    
    var isSelected: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(highlightColour: UIColor) {
        self.highlightColour = highlightColour
        super.init(frame: .zero)
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
        let path = calculatePath(forRect: rect)
        context.addPath(path)
        context.setFillColor(ColourPalette.offWhite.cgColor)
        context.fillPath()
        
        context.addPath(path)
        
        context.setLineWidth(calculateStrokeWidth())
        context.setStrokeColor(calculateStrokeColour())
        context.strokePath()
    }
    
    private func calculatePath(forRect rect: CGRect) -> CGPath {
        let inset: CGPoint = isSelected ? CGPoint(x: Layout.selectedStrokeWidth, y: Layout.selectedStrokeWidth) : .zero
        return UIBezierPath(roundedRect: rect.insetBy(dx: inset.x, dy: inset.y),
            cornerRadius: Layout.cardCornerRadius).cgPath
    }
    
    private func calculateStrokeWidth() -> CGFloat {
        return isSelected ? Layout.selectedStrokeWidth : Layout.strokeWidth
    }
    
    private func calculateStrokeColour() -> CGColor {
        return isSelected ? highlightColour.cgColor : ColourPalette.alphaBlack10.cgColor
    }
}
