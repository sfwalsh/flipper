//
//  MenuSection.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSection: Decodable {
    
    let id: Int
    let name: String?
    let description: String?
    let imageUrl: String?
    let menuItems: [MenuSectionItem]
    let availability: MenuSectionAvailibility?
    
    private enum CodingKeys: String, CodingKey {
        case id = "MenuSectionId"
        case name = "Name"
        case description = "Description"
        case imageUrl = "ImageUrl"
        case menuItems = "MenuItems"
        case availability = "MenuSectionAvailability"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.description = try values.decodeIfPresent(String.self, forKey: .description)
        self.imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        self.menuItems = try values.decodeIfPresent([MenuSectionItem].self, forKey: .menuItems) ?? []
        self.availability = try values.decodeIfPresent(MenuSectionAvailibility.self, forKey: .availability)
        
    }
}

/*
 
 API Sample:
 
    {
      "MenuSectionId": 194490,
      "Name": "Mains",
      "Description": null,
      "DisplayOrder": 0,
      "MenuItems": [],
      "PublicId": "0dfc594c-5fd5-4a94-b7c0-b7c9dbc2d71e",
      "IsDeleted": false,
      "IsAvailable": true,
      "IsHiddenFromUsers": false,
      "ImageName": "5csY9WytLuMFRJQt29QkV94iAps.jpg",
      "ImageUrl": "https://flipdish.imgix.net/5csY9WytLuMFRJQt29QkV94iAps.jpg",
      "CellAspectRatio": 4.0,
      "CellLayoutType": 0,
      "MenuSectionAvailability": {}
      "ConcessionStoreId": null,
      "MenuSectionMetadata": [
        
      ]
    },
*/
