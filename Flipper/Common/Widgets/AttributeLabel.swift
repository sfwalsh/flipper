//
//  AttributeLabel.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class AttributeLabel: UILabel {
    
    private enum Layout {
        static let inset: CGSize = CGSize(width: 16, height: 2)
    }
    
    private var borderColor: UIColor = .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width+Layout.inset.width,
                      height: super.intrinsicContentSize.height+Layout.inset.height)
    }
}


// MARK: Actions

extension AttributeLabel {
    
    func setupTextColor(color: UIColor) {
        textColor = color
        borderColor = calculateBackgroundColor(for: color)
        setNeedsDisplay()
    }
    
    func update(withTitle title: String?) {
        text = title
        setNeedsDisplay()
    }
}


// MARK: Helpers

extension AttributeLabel {
    
    private func calculateBackgroundColor(for color: UIColor) -> UIColor {
        return color.withAlphaComponent(0.2)
    }
}


// MARK: Drawing

extension AttributeLabel {
    
    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        drawBorder(in: rect,
                   ctx: ctx)
        
        super.draw(rect)
    }
    
    private func drawBorder(in rect: CGRect,
                            ctx: CGContext) {
        let path = UIBezierPath(roundedRect: rect,
                                cornerRadius: rect.height/2).cgPath
        ctx.addPath(path)
        ctx.setFillColor(borderColor.cgColor)
        ctx.fillPath()
    }
}

