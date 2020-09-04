//
//  SectionHeaderCell.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import UIKit

final class SectionHeaderCell: UICollectionReusableView, ReusableCell {
    
    private enum Layout {
        static let insets = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)
        static let separatorLineWidth: CGFloat = 3.0
        static let separatorLength: CGFloat = 74.0
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColourPalette.Text.primaryBlack
        label.font = FontMachine.header
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubviewForAutolayout(view: headerLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.insets.top),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.insets.bottom),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.insets.left),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.insets.right),
            ])
    }
    
    func setup(withTitle title: String?) {
        headerLabel.text = title
    }
}


// MARK: Drawing

extension SectionHeaderCell {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawSeparator(in: context, for: rect)
    }
    
    private func drawSeparator(in context: CGContext,
                               for rect: CGRect) {
        
        context.move(to: CGPoint(x: rect.minX+Layout.insets.left,
                                 y: rect.maxY-Layout.separatorLineWidth))
        context.addLine(to: CGPoint(x: rect.minX+Layout.insets.left+Layout.separatorLength,
                                    y: rect.maxY-Layout.separatorLineWidth))
        
        context.setLineWidth(Layout.separatorLineWidth)
        context.setStrokeColor(ColourPalette.offWhite.cgColor)
        context.strokePath()
    }
}

