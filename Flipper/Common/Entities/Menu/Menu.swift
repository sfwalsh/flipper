//
//  Menu.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct Menu: Decodable {
    
    let id: Int
    let sections: [MenuSection]
    
    enum CodingKeys: String, CodingKey {
        case id = "MenuId"
        case sections = "MenuSections"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.sections = try values.decode([MenuSection].self, forKey: .sections)
    }
    
    init(id: Int, sections: [MenuSection]) {
        self.id = id
        self.sections = sections
    }
}

/*
 
 API Sample:
 
    {
        "MenuId": 16798,
        "MenuVersionNumber": 354,
        "VersionGuid": "e6220da2-c34a-4ea2-bb51-a3e190fc5f08",
        "MenuSections": [],
        "MenuSectionBehaviour": 1,
        "DisplaySectionLinks": true,
        "ConcessionStores": []
    }
*/
 
