//
//  MenuExtensions.swift
//  FlipperTests
//
//  Created by Stephen Walsh on 04/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

@testable import Flipper

extension Menu {
    
    static func createDummy() -> Menu {
        return Menu(id: 12345, sections: [])
    }
}
