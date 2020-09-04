//
//  ColourPalette.swift
//  Flipper
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

/*
 Indexes Colours used in the app
 */

import UIKit

struct ColourPalette {
    static let coralOrange = UIColor(red: 217/255, green: 105/255, blue: 83/255, alpha: 1.0)
    static let gregariousGreen = UIColor(red: 83/255, green: 217/255, blue: 113/255, alpha: 1.0)
    static let lovelyLilac = UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1.0)
    static let offWhite = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    static let alphaBlack10 = Text.primaryBlack.withAlphaComponent(0.1)
    
    struct Text {
        static let primaryBlack = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
        static let secondaryBlack = Text.primaryBlack.withAlphaComponent(0.6)
    }
}
