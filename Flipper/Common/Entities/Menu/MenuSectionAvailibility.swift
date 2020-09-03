//
//  MenuSectionAvailibility.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSectionAvailibility: Decodable {
    
    let availableTimes: [MenuSectionAvailibilityHours]
    
    private enum CodingKeys: String, CodingKey {
        case availableTimes = "AvailableTimes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.availableTimes = try values.decodeIfPresent([MenuSectionAvailibilityHours].self, forKey: .availableTimes) ?? []
    }
}

/*
 
 API Sample:
 
    {
        "AvailableTimes": [],
        "MenuSectionId": 194490,
        "AvailabilityMode": 1
    }
*/
